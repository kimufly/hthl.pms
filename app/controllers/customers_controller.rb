class CustomersController < ApplicationController
  def index
    @customerContacts = CustomerContact.all
  end
end
