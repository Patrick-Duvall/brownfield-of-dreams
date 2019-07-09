# frozen_string_literal: true

class Admin::VideosController < Admin::BaseController
  before_action :fetch_tutorial, only: :create
  before_action :fetch_thumbnail, only: :create
  before_action :fetch_video, only: %i[edit update]

  def edit; end

  def update
    @video.update(video_params)
  end

  def create
    begin
      @tutorial.videos.create(new_video_params.merge(thumbnail: @thumbnail))

      flash[:success] = 'Successfully created video.'
    rescue StandardError
      flash[:error] = 'Unable to create video.'
    end
    redirect_to edit_admin_tutorial_path(id: @tutorial.id)
  end

  private

  def fetch_tutorial
    @tutorial = Tutorial.find(params[:tutorial_id])
  end

  def fetch_thumbnail
    @thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
  end

  def fetch_video
    @video = Video.find(params[:video_id])
  end

  def video_params
    params.permit(:position)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
