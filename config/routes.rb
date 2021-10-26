Rails.application.routes.draw do
  devise_for :admins

  get  'admin/all' => 'admins#show'
  post 'admin/permit/:id' => 'admins#permission', as: 'permit'
  post 'admin/operator/:id' => 'admins#operator', as: 'operator'
  post 'admin/admin/:id' => 'admins#admin', as: 'adminadmin'

  get  'subjects' => 'admin_works#subject'
  post 'subjects' => 'admin_works#add_subject'
  get  'tokinator_columns' => 'admin_works#tokinator_column'
  post 'tokinator_columns' => 'admin_works#add_tokinator_column'

  get 'edits' => 'edits#index'
  get 'edits/:para' => 'edits#index'
  
  root 'tops#index'
  get '/:para' => 'tops#index'

end
