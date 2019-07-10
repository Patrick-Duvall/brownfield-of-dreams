class User::ActivationController < ApplicationController

  def update
    user = User.find(params['user_id'])
    user.activate
    flash[:message] = "Thank you! Your account is now activated."
    #Possible refactor for N+1 User.where(id: params['user_id']).update(active: true)
    redirect_to dashboard_path
  end

end
