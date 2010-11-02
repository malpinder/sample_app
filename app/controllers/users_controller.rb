class UsersController < ApplicationController

  def new
    @user = User.new
    @title = 'Sign up'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome, #{@user.name}!"
      sign_in @user
      redirect_to @user
    else
      @title = "Please try to Sign up again"
      @user.password = ''
      @user.password_confirmation = ''
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

end

