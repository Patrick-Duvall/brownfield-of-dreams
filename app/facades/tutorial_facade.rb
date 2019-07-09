class TutorialFacade < SimpleDelegator
  def initialize(tutorial, video_id = nil, current_user)
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
    elsif self.videos.empty?
      Video.new(description: "Video Missing")
    else
      videos.first
    end
  end

  def next_video
    if self.videos.empty?
      Video.new
    else
      videos[current_video_index + 1] || current_video
    end
  end

  def play_next_video?
    !(current_video.position >= maximum_video_position)
  end

  private

  def current_video_index
    videos.index(current_video)
  end

  def maximum_video_position
    if self.videos.empty?
      0
    else
      videos.max_by { |video| video.position }.position
    end
  end
end
