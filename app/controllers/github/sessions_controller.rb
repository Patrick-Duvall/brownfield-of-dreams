class Github::SessionsController < ApplicationController
  def update
    token = request.env['omniauth.auth']['credentials']['token']
    current_user.update(token: token)
    redirect_to dashboard_path
  end
end
