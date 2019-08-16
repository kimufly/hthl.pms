class HelloController < ApplicationController
  def index
    if user_signed_in?
      render "hello/index"
    else
      redirect_to new_user_session_url
    end
  end
end
