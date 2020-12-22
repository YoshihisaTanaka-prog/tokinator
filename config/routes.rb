Rails.application.routes.draw do
  
  root to: 'homes#index'

  get 'index'        , to: 'homes#index'
  get 'show'         , to: 'homes#show'
  get 'constructing' , to: 'homes#constructing'
  get 'caution'      , to: 'homes#caution'


  get 'edits', to: 'autho#index'
  
  get 'autho', to: 'autho#authentication'
  post 'autho', to: 'autho#authentication'

  get 'edits/caution', to: 'autho#caution'

  get 'edits/aupdate', to: 'autho#authentication_update'
  post 'edits/aupdate', to: 'autho#authentication_update'
  patch 'edits/aupdate', to: 'autho#authentication_update'

  get 'edits/add', to: 'autho#edit_add'
  post 'edits/add', to: 'autho#edit_add'
  get 'edits/create_route', to: 'autho#edit_create'
  post 'edits/create_route', to: 'autho#edit_create'
  get 'edits/edit', to: 'autho#edit'
  post 'edits/edit', to: 'autho#edit'
  post 'edits/edit_update', to: 'autho#edit_update'
  get 'edits/edit_update', to: 'autho#edit_update'
  get 'edits/show', to: 'autho#show'
  post 'edits/show', to: 'autho#show'


  get 'statistics', to: 'statistics#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users
  devise_for :users
end
