Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  LOCALES = /en|pt\-BR/

  scope ":locale", :locale => LOCALES do

    resources :users

    resources :subjects
    resources :content_genres
    resources :content_types
    resources :contents
    resources :people
    resources :summaries
    resources :quotations
    resources :reviews

    get 'quotation/addperson', action: :addperson, controller: :quotations , as: :add_person

    #resource :user_confirmation, :only => [:show]
    resource :confirmation, :only => [:show]
    resource :user_sessions, :only => [:create, :new, :destroy]


  end

  scope '/json' do
    get :person, action: :json, controller: :people , as: :person_json
    get :content, action: :json, controller: :contents , as: :content_json
    get :subject, action: :json, controller: :subjects , as: :subject_json
  end

  get '/:locale' => 'home#index', :locale => LOCALES
  root :to => "home#index"

end
