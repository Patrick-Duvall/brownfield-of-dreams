class Github::SessionsController < ApplicationController
  def update
    token = request.env['omniauth.auth']['credentials']['token']
    github_id = request.env['omniauth.auth']['uid']
    github_name = request.env['omniauth.auth']['info']['name']
    current_user.update(token: token, github_id: github_id, github_name: github_name )
    redirect_to dashboard_path
  end
end
