# frozen_string_literal: true

class TutorialSequencer
  def initialize(tutorial, sequenced_video_ids)
    @tutorial = tutorial
    @sequenced_video_ids = sequenced_video_ids
  end

  def run!
    update_position_if_changed!
  end

  private

  attr_reader :tutorial, :sequenced_video_ids

  def videos
    tutorial.videos.to_a
  end

  def update_position_if_changed!
    sequenced_video_ids.each.with_index(1) do |video_id, index|
      vid_to_update = videos.find do |video|
        video.id == video_id.to_i
      end

      vid_to_update.update(position: index) if vid_to_update.position != index
    end
  end
end
