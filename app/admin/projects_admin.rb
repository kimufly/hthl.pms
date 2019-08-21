Trestle.resource(:projects) do
  menu do
    item :projects, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :name
    column :support_details
    column :genre_name
    column :customer
    column :user
    column :auditor
    column :tech_auditor
    column :remake
    column :time_limit
    column :status
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |project|
    text_field :name
    text_field :support_details
    select :genre, Project.genre_options.to_h
    select :customer_id, Customer.all.select(:id, :name)
    select :user_id, User.all.select(:id, :name)
    select :auditor, User.all.select(:id, :name)
    select :tech_auditor, User.all.select(:id, :name)
    text_field :remake
    text_field :time_limit
    select :status, Project.status_options.to_h
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  params do |params|
    params.require(:project).permit(:name, :support_details, :genre, :customer_id,
                                    :user_id, :auditor, :tech_auditor, :remake,
                                    :time_limit, :status)
  end
end
