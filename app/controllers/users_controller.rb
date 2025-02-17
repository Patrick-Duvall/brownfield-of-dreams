# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user
      render locals: {
        user: UserShowFacade.new(current_user)
      }
    else
      redirect_to login_path
      flash[:failure] = "Please Login to Visit your Profile"
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:message1] = "Logged in as #{user['first_name']} #{user['last_name']}"
      flash[:message2] = 'This account has not yet been activated. Please check your email'
      ActivationMailer.activate(user, user.email).deliver_now
      redirect_to dashboard_path
    else
      err = user_exist? ? 'That Email is already in use' : 'Missing Credentials'
      flash[:error] = err
      @user = User.new
      render :new
    end
  end

  private

  def user_exist?
    User.find_by(email: user_params['email'])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
