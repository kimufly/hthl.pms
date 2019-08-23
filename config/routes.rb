Rails.application.routes.draw do
  get 'user_password/index'

  resources :customers do 
    collection do 
      get :edit_customer
    end
  end
  
  get 'costs/index'
  get 'todos/index'

  resources :projects do 
    collection do 
      get :approving
      get :todo
      get :show_approving
      get :approving_flow_apply
      get :approving_change_flow_apply
      get :show_flow_apply
      get :show_project
      get :project_flow_apply
      get :project_change_flow_apply
      get :project_finish_file_upload
    end
  end

  resources :documents do 
    collection do 
      get :upload_files
      get :share_files
    end
  end

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
