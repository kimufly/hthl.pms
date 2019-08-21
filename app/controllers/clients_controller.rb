class ClientsController < ApplicationController
  def index
    @customerContacts = CustomerContact.all
  end
end
