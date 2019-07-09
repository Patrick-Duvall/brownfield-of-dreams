# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @tutorials = tagged_tutorial
  end

  private

  def tagged_tutorial
    if params[:tag]
      Tutorial.tagged_with(tag).paginate(page: page, per_page: 5)
    else
      Tutorial.all.paginate(page: page, per_page: 5)
    end
  end

  def tag
    params[:tag]
  end

  def page
    params[:page]
  end
end
