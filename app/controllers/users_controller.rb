# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: {
      user: UserShowFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
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
