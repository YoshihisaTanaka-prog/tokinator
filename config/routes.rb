Rails.application.routes.draw do
  devise_for :admins

  get  'admin/all' => 'admins#show'
  post 'admin/permit/:id' => 'admins#permission', as: 'permit'
  post 'admin/operator/:id' => 'admins#operator', as: 'operator'
  post 'admin/admin/:id' => 'admins#admin', as: 'adminadmin'

  get  'ncmbs' => 'admin_works#ncmb'
  post 'ncmb' => 'admin_works#add_ncmb'
  get  'columns' => 'admin_works#column'
  post 'columns' => 'admin_works#update_column'
  get 'class/:name' => 'admin_works#set_class'

  get 'edits' => 'edits#index'
  get 'edits/:para' => 'edits#index'
  post 'update' => 'edits#update'
  
  root 'tops#index'
  get '/:para' => 'tops#index'

end
