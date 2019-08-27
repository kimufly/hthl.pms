class CustomerContactsController < ApplicationController
  def index
    @customer_contacts = CustomerContact.all
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
    @customer_contact = CustomerContact.new(customer_params)
    #todo.....保存父类返回
    @customer_contact.customer_id=2
    if @customer_contact.save
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




  private
  def customer_params
      params.require(:customer_contact).permit(:unit_name, :project_name, :name, :telephone, :phone_number, :other_phone, :position, :email, :address, :customer_id)
  end



end
