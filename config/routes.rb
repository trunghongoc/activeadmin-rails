Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # post '/admin/gender_changing/:id_user', to: 'users#gender_changing'
  match "/admin/users/gender_changing/:id_user" => 'users#gender_changing', via: :post, as: :gender_changing
  # match "/admin/add_custom_menu" => 'users#add_custom_menu', via: :get, as: :add_custom_menu

  resources :users do
    resources :books
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
