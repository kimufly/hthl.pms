class HelloController < ApplicationController
  def index
    respond_to do |format|
      format.any { render json: { message: :hello } }
    end
  end
end
