class CustomersController < ApplicationController
  def index
    @customerContacts = CustomerContact.all
  end


  def create
    @customerContact = CustomerContact.new(customer_contact_params)
    print("进入接口方法11111111111111111111111111.\n\n\n\n\n\n\n")
    if @customerContact.save
      redirect_to customers_path
    else
      redirect_to  new_customer_customers_path
    end
  end

  def new_customer
  end

  private
  def customer_contact_params
      params.require(:customer_contact).permit(:unit_name, :project_name, :name, :telephone, :phone_number, :other_phone, :position, :email, :address)
  end




end
