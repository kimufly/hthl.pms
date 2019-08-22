Rails.application.routes.draw do
<<<<<<< HEAD
  get 'user_password/index'

  resources :customers do 
    collection do 
      get :edit_customer
    end
  end
  

=======
  get 'customers/index'
>>>>>>> 45198ea3c43b07caed9bb828151db93326ce50c2
  get 'costs/index'
  get 'todos/index'

  resources :projects do 
    collection do 
      get :approving
      get :todo
    end
  end

  resources :documents do 
    collection do 
      get :upload_files
      get :share_files
    end
  end



  get 'clients/index'

  resources :roles do 
    collection do 
      get :edit_role
      get :role_permission
    end
  end

  get 'home/index'
  root 'hello#index'
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  resources :users do 
    collection do 
      get :up_personal_password
      get :up_personal_data
      get :edit_user
      get :up_personal_data
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
