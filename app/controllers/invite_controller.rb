class InviteController < ApplicationController
  def new
  end

  def create
    service = GithubService.new(current_user)
    new_user = service.single_user(params['q']['Github Handle'])
    if new_user[:message] == "Not Found"
      flash[:failure] = "Invalid Github Handle, please try again"
      render :new
    else
      email_if_possible(new_user)
    end
  end

  private
  def email_if_possible(new_user)
    if new_user[:email]
      InviteMailer.invite(current_user.github_name, new_user[:email], params['q']['Github Handle']).deliver_now
      flash[:success] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash[:failure] = "That user does not have an email account associated with their github."
      redirect_to dashboard_path
    end
  end

end
