# frozen_string_literal: true

class TutorialFacade < SimpleDelegator
  def initialize(tutorial, current_user, video_id = nil)
    @user = current_user
    super(tutorial)
    @video_id = video_id
  end

  def videos_should_be_visible?
    classroom == false || @user && classroom == true
  end

  def current_video
    if @video_id
      videos.find(@video_id)
    elsif no_videos?
      Video.new(description: 'Video Missing')
    else
      videos.first
    end
  end

  def next_video
    no_videos? ? Video.new : videos[current_video_index + 1] || current_video
  end

  def play_next_video?
    current_video.position < maximum_video_position
  end

  private

  def current_video_index
    videos.index(current_video)
  end

  def no_videos?
    videos.empty?
  end

  def maximum_video_position
    no_videos? ? 0 : videos.max_by(&:position).position
  end
end
