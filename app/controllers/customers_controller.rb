class CustomersController < ApplicationController
  def index
    @customerContacts = CustomerContact.all
  end

  def edit_customer
  end
end
