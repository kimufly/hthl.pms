class CustomerContactsController < ApplicationController
  def index
    @customer_contacts = CustomerContact.all
  end

  def new
    @customer = CustomerContact.new
  end

  private
  def contact_params
  end
end
