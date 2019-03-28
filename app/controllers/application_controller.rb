# LifeProject - project management software of your life
# Copyright (C) 2018  Rosemberg de Oliveira
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :set_locale

  # attr_accessor :user

  #detecting the default language of the browser
  def detect_locale
    langs = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.split(",").map do |lang|
      l, q = lang.split(";q=")
      [l, (q || '1').to_f]
    end

    langs.map do |k,v|
       I18n.available_locales.map do |parsed_locale,_|
         if parsed_locale.to_s==k
           return k
         end
       end
    end

    I18n.default_locale
  end

  def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = params[:locale] || detect_locale
  end


  def default_url_options
    { :locale => I18n.locale }
  end


  delegate :current_user, :user_signed_in?, :to => :user_session

  helper_method :current_user, :user_signed_in?
  #helper_method :current_user, :user_signed_in?, :current_user_session

  # def current_user_session
  #   if self.user.nil?
  #     self.user=current_user
  #   end
  #
  #   self.user
  # end

  def user_session
    UserSession.new(session)
  end

  def require_authentication
    unless user_signed_in?
      redirect_to new_user_sessions_path,
      :alert => t('flash.alert.needs_login')
    end
  end

  def require_no_authentication
    redirect_to root_path if user_signed_in?
  end


  def define_argument(arg)
    @arguments||=[]
    @arguments<<arg
  end

  def define_argument_values(name,p)

    condition=""
    value_condition={}
    values={}
    #session.delete(name)
    if (p && p.has_key?(:q))
      values={q: "q",page: p[:page]}
      @arguments.each do |arg|
        values[arg[:argument]]=p[arg[:argument]]
      end
      session[name]=values

    elsif session.has_key? name
           values=session[name]

           values[:q]="q"
           values[:page]=(p && p[:page])? p[:page]:0

    else


      @arguments.each do |arg|
        values[arg[:argument]]=""
      end
    end



    if values.has_key? :q

      @arguments.each do |arg|

       if( values.has_key?(arg[:argument])  and values[arg[:argument]] and not values[arg[:argument]].empty?)
          if condition.empty?

            if(arg[:type]=="inactive" )
              if(values[arg[:argument]]=="Y")
                condition=" #{arg[:table]}.inactivated_at is not null "
              else
                condition=" #{arg[:table]}.inactivated_at is null "
              end
            elsif(arg[:type]=="like" || arg[:type]=="ilike")
              condition=" #{arg[:table]}.#{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value_condition[arg[:argument].to_sym]="%#{values[arg[:argument]]}%"
            elsif(arg[:type]!="auxiliary")
              condition=" #{arg[:table]}.#{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value_condition[arg[:argument].to_sym]=values[arg[:argument]]
            end

          else

            if(arg[:type]=="inactive" )
              if(values[arg[:argument]]=="Y")
                condition+=" and #{arg[:table]}.inactivated_at is not null "
              else
                condition+=" and #{arg[:table]}.inactivated_at is null "
              end
            elsif(arg[:type]=="like" || arg[:type]=="ilike")
              condition+=" and #{arg[:table]}.#{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value_condition[arg[:argument].to_sym]="%#{values[arg[:argument]]}%"
            elsif(arg[:type]!="auxiliary")
              condition+=" and #{arg[:table]}.#{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value_condition[arg[:argument].to_sym]=values[arg[:argument]]
            end

          end
        end
      end
    end

    instance_variable_set "@#{name}",values
    instance_variable_set "@condition",condition
    instance_variable_set "@value_condition",value_condition

  end

  def mount_argument(arguments)


    name=arguments[:name]
    args=arguments[:arg]
    values=arguments[:values]
    condition=""
    value={}


    if (values && values.has_key?(:q))
      session[name]=values
    elsif session.has_key? name
          values=session[name]
          values[:page]= arguments[:page]? arguments[:page]:0
          values[:q]="q"
    end




    if (values && values.has_key?(:q))

      args.each do |arg|



       if (not values.nil? and not values[arg[:argument]].nil? and not values[arg[:argument]].empty?)
          if(condition.empty?)



            if(arg[:type]=="inactive" )
              if(values[arg[:argument]]=="Y")
                condition=" inactivated_at is not null "

              else
                condition=" inactivated_at is null "

              end
            elsif(arg[:type]=="like" || arg[:type]=="ilike")
              condition=" #{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value[arg[:argument].to_sym]="%#{values[arg[:argument]]}%"
            else
              condition=" #{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value[arg[:argument].to_sym]=values[arg[:argument]]
            end

          else
            if(arg[:type]=="inactive" )
              if(values[arg[:argument]]=="Y")
                condition+=" and inactivated_at is not null "

              else
                condition+=" and inactivated_at is null "

              end
            elsif(arg[:type]=="like" || arg[:type]=="ilike")
              condition+=" and #{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value[arg[:argument].to_sym]="%#{values[arg[:argument]]}%"
            else
              condition+=" and #{arg[:argument]} #{arg[:type]} :#{arg[:argument]} "
              value[arg[:argument].to_sym]=values[arg[:argument]]
            end

          end
        end
      end
    else
      values={}
      args.each do |arg|

        values[arg[:argument]]=""
      end
    end

    {condition: condition, value: value, params: values}

  end


end
