# frozen_string_literal: true

class Github::SessionsController < ApplicationController
  def update
    response = request.env['omniauth.auth']
    # token = request.env['omniauth.auth']['credentials']['token']
    # github_id = request.env['omniauth.auth']['uid']
    # github_name = request.env['omniauth.auth']['info']['name']
    current_user.update(token: response['credentials']['token'],
                        github_id: response['uid'],
                        github_name: response['info']['name'])
    redirect_to dashboard_path
  end
end
