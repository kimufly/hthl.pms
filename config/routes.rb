Rails.application.routes.draw do
  get 'customers/index'
  get 'costs/index'
  get 'todos/index'
  resources :projects do 
    collection do 
      get :approving
      get :todo
    end
  end

  get 'documents/index'
  get 'clients/index'
  get 'roles/index'
  get 'home/index'
  root 'hello#index'
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
