Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :name
    column :email
    column :phone_number
    column :sex_name
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |user|
    text_field :name
    text_field :email
    text_field :phone_number
    text_field :password
    text_field :role_id
    select :sex, User.sex_options.to_h
  
    # row do
      # col(xs: 6) { datetime_field :updated_at }
      # col(xs: 6) { datetime_field :created_at }
    # end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  params do |params|
    params.require(:user).permit(:name, :email, :phone_number, :password, :sex, :role_id)
  end
end
