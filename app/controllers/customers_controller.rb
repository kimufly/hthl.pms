class CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end 

  def new
      @customer = Customer.new
  end


  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      respond_to do |format|
        format.html
        format.js
      end 

      # redirect_to new_project_path
    end
  end

  def update
    Project.transaction do 
      @customer = Customer.find(params[:id])
      if @customer
        @customer.update(customer_params)
        @customer_contact = @customer.customer_contacts
        @customer_contact.update(customer_contacts_params)
        redirect_to customer_contacts_path
      else
        redirect_to "edit"
      end
    end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:name)
  end

  def customer_contacts
    @customer_contact = CustomerContact.find(params[:id])
  end

  def customer_contacts_params
    params.require(:customer).require(:customer_contacts_attributes).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position)
  end





end
