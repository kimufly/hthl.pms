class CustomerContactsController < ApplicationController
  def index
    position = params[:position]
    @customer_contacts = CustomerContact.all
    @customer_contacts = @customer_contacts.where('position like ? ', "%#{position}%") if position.present?
    @customer_contacts = @customer_contacts.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @customer_contact = CustomerContact.find(params[:id])
  end


  def new
    @customer_contact = CustomerContact.new
  end

  def edit
    @customer_contact = CustomerContact.find(params[:id])
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
    @customer_contact = CustomerContact.find(params[:id])
    if @customer_contact.update(customer_params)
      redirect_to customer_contacts_path
    else
      redirect_to "edit"
    end
  end

  def destroy
    @customer_contact = CustomerContact.find(params[:id])
    @customer_contact.destroy
    redirect_to customer_contacts_path
  end

  def find_unit_name
    @customer_contact = CustomerContact.where(name: '新华集团').first
    redirect_to approving_flow_apply_projects_path(@customer_contact)
  end

  def customer_params
    params.require(:customer).permit(:name)
  end

  def customer_contacts_params
    params.require(:customer).require(:customer_contacts).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position)
  end



end
