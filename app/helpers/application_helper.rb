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

module ApplicationHelper
  def error_tag(model, attribute)
    if model.errors.has_key? attribute
      content_tag :span, model.errors[attribute].first,
      :class => 'help-block has-error'
    end
  end

  def error_div(model, attribute)
    if model.errors.has_key? attribute
      " has-error"
    end
  end

  def button_click(label,js)
    content_tag :button, label, :class => 'btn btn-primary', :onclick =>js, :type => :button
  end

  def buttons_index(path_new)

    content_tag :div, :class => "box-header" do
      concat button_click I18n.t('button.index.new'),"location.href='#{path_new}';"
      concat " "
      concat submit_tag I18n.t('.button.index.search'), :class=>"btn btn-primary",:id=>"btn_search"
    end
  end


  def button_index(path_new)
    render "helpers/button_index", path_new: path_new
  end

  def button_save(path_new,path_index,f)
    render "helpers/button_save", path_new: path_new,path_index: path_index,f: f
  end

  def button_show(path_new,path_edit,path_index)
    render "helpers/button_show", path_new: path_new,path_edit: path_edit,path_index: path_index
  end

  def button_inactivate(object,url_activate)
    if !object.inactivated_at.present?
       link_to t('button.inactivate'), object,:class=>"btn btn-primary",:method => :delete, :data => {:confirm => t('dialogs.inactivate')}
    else
       link_to t('button.activate'), url_activate,:class=>"btn btn-primary",:method => :delete,:data => {:confirm => t('dialogs.activate')}
    end
  end

  def options_from_enum_for_select(instance, enum)
    options_for_select(enum_collection(instance, enum), instance.send(enum))
  end

  def enum_collection(instance, enum)
    instance.class.send(enum.to_s.pluralize).keys.to_a.map { |key| [key.humanize, key] }
  end

end
