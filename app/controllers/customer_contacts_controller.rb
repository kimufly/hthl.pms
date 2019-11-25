class CustomerContactsController < ApplicationController
  def index
    position = params[:position]
    @customer_contacts = CustomerContact.all
    @customer_contacts = @customer_contacts.where('position like ? ', "%#{position}%") if position.present?
    if params[:customer_id]
      @customer_contacts = @customer_contacts.where(customer_id: params[:customer_id])
    end
    @customer_contacts = @customer_contacts.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @customer_contact = CustomerContact.find(params[:id])
    @customer = CustomerContactcustomer
  end


  def new
    @customer_contact = CustomerContact.new
  end

  def edit
    @customers = Customer.all
    @customer_contact = CustomerContact.new
    @users = User.all
  end

  def create
    @customer = Customer.create(customer_params)
    @customer_contact = CustomerContact.new(customer_contacts_params)
    @customer.customer_contacts << @customer_contact
    if@customer.save
      redirect_to customer_contacts_path
    else
      redirect_to "new"
    end
  end

  def update
    Project.transaction do 
      @customer = Custome.find(params[:id])
      if customer.update(customer_params)
        @customer_contact = @customer.customer_contacts
        @customer_contact.update(customer_contacts_params)
        redirect_to customer_contacts_path
      else
        redirect_to "edit"
      end
    end
  end

  def destroy
    @customer_contact = CustomerContact.find(params[:id])
    @customer_contact.destroy
    redirect_to customer_contacts_url
  end

  def create_customer
    @customer = Customer.new(customer_params)
      if @customer.save
        redirect_to new_customer_contact_path
      end 
  end

  def create_customer_contact
    @customer_contact = CustomerContact.new(customer_contact_params)
    if @customer_contact.save
      redirect_to new_customer_contact_path
    end 
  end

  def update_customer_contact
    @customer_contact = CustomerContact.find(params[:customer_contact_id])
    @customer_contact.update(name: params[:name])
    @customer_contact.update(telephone: params[:telephone])
    @customer_contact.update(phone_number: params[:phone_number])
    @customer_contact.update(other_phone: params[:other_phone])
    @customer_contact.update(position: params[:position])
    @customer_contact.update(email: params[:email])
    @customer_contact.update(address: params[:address])
    @customer_contact.update(customer_id: params[:customer_id])
    redirect_to new_customer_contact_path
  end
  




  def find_by_customer_id
    @customer_contacts = CustomerContact.find_by_customer_id(params[:customer_id]) 
    render json: @customer_contacts.to_json  
  end

  def find_unit_name
    @customer_contact = CustomerContact.where(name: params[:name]).first
    redirect_to approving_flow_apply_projects_path(@customer_contact)
  end

  def customer_params
    params.require(:customer).permit(:name)
  end

  def customer_contacts_params
    params.require(:customer).require(:customer_contacts).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position)
  end

  def customer_contact_params
    params.require(:customer_contact).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position, :customer_id)
  end

  

end
