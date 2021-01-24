Rails.application.routes.draw do
  
  get 'test/index'
  
  root to: 'homes#index'

  
  get 'autho', to: 'autho#authentication'
  post 'autho', to: 'autho#authentication'

  get 'autho/update', to: 'autho#authentication_update'
  post 'autho/update', to: 'autho#authentication_update'
  patch 'autho/update', to: 'autho#authentication_update'

  post 'advice', to: 'advice#create'
  patch 'advice/:id', to: 'advice#update'
  get 'advice/:id', to: 'advice#delete'


  get 'edits', to: 'autho#index'
  get 'edits/index', to: 'autho#index'
  get 'edits/caution', to: 'autho#caution'
  get 'edits/add', to: 'autho#edit_add'
  post 'edits/add', to: 'autho#edit_add'
  get 'edits/comment', to: 'autho#comment'
  post 'edits/comment', to: 'autho#comment'
  get 'edits/create_route', to: 'autho#edit_create'
  post 'edits/create_route', to: 'autho#edit_create'
  get 'edits/edit', to: 'autho#edit'
  post 'edits/edit', to: 'autho#edit'
  get 'edits/image', to: 'autho#image'
  post 'edits/image', to: 'autho#image'
  patch 'edits/image', to: 'autho#image'
  get 'edits/plus', to: 'autho#plus'
  post 'edits/plus', to: 'autho#plus'
  get 'edits/search', to: 'autho#search'
  post 'edits/search', to: 'autho#search'
  get 'edits/show', to: 'autho#show'
  post 'edits/show', to: 'autho#show'
  get 'edits/solution', to: 'autho#solution'
  post 'edits/upload-pdf', to: 'autho#upload_pdf'
  get 'edits/title', to: 'autho#title'
  post 'edits/title', to: 'autho#title'
  post 'edits/edit_update', to: 'autho#edit_update'
  get 'edits/edit_update', to: 'autho#edit_update'


  get 'ReqUsrLv', to: 'autho#ReqUsrLv'


  get 'statistics', to: 'statistics#index'


  get 'support', to: 'autho#support'
  get 'support/chat', to: 'autho#chat'
  post 'support/chat/write', to: 'autho#chat_write'


  get 'index'          , to: 'homes#index'
  get 'show'           , to: 'homes#show'
  get 'constructing'   , to: 'homes#constructing'
  get 'caution'        , to: 'homes#caution'
  get 'apolo'          , to: 'homes#apology'
  get 'store'          , to: 'homes#store'

  get 'app'            , to: 'app_homes#index'
  get 'app/show'       , to: 'app_homes#show'
  post 'app/show'       , to: 'app_homes#show'
  get 'app/chat'       , to: 'app_homes#chat'
  post 'app/chat'       , to: 'app_homes#chat'
  get 'app/chat/write', to: 'app_homes#chat_write'
  post 'app/chat/write', to: 'app_homes#chat_write'
  get 'app/user'       , to: 'app_homes#user'
  post 'app/user'       , to: 'app_homes#user'


  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users
end
