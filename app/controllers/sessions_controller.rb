class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      @title = 'Please try to Sign in again'
      flash.now[:error] = "Invalid email / password combination"
      render :new
    else
      flash[:success] = "Welcome back, #{user[:name]}!"
      sign_in user
      redirect_back_or(user)
    end
  end

  def destroy
    flash[:success] = "Good bye, #{current_user[:name]}!"
    sign_out
    redirect_to root_path
  end

end

