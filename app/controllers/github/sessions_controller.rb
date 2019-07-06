class Github::SessionsController < ApplicationController
  def update
    # require "pry"; binding.pry
    user_info = request.env['omniauth.auth']
    user = current_user
    require "pry"; binding.pry
    token = user_info['credentials']['token']
    user.update(token: token)
    redirect_to dashboard_path
  end
end
