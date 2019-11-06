Rails.application.routes.draw do
  resources :products do
    collection do
      get :download
    end
  end

  get 'msg/index'
  resources :event_registrations do
    collection do
      post :import
    end
  end

  resources :tests
  resources :tech_hours

  root 'home#index'


  get 'costs/index'
  resources :customers
  resources :project_users
  resources :satisfactions, only: [:new, :create, :show]

  resources :customer_contacts do
    collection do
      get :find_unit_name
      get :find_by_customer_id
      post :create_customer
      post :create_customer_contact
    end
    member do
      patch :update_customer_contact
    end
   

  end

  resources :projects do
    collection do
      get :approving
      get :project
      get :todo
      get :show_flow_apply
      get :show_project
      get :project_flow_apply #TODO
      get :project_change_flow_apply #TODO
      get :project_finish_file_upload #TODO
      post :create_customer
      post :create_customer_contact
      get :project_over_auditor
      get :find_by_status
    end
    member do
      get :audit
      get :show_my_project
      patch :submit_audit  
      patch :update_customer_contact
      delete :delete_customer_contact
      get :project_details
      post :import
      delete :delete_project_pass
      get :download_project_pass
      get :download_tech_hour
    end
  end

  resources :documents do
    collection do
      get :upload_files
      get :share_files
      post :import
      get :init_share
    end
  end

  resources :roles do
    collection do
      get :role_permission
      get :export
    end
  end

  resources :hello, only: [:index]
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  resources :users do
    collection do
      get :query_by
    end
    member do
      get 'find_by_role_id'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
