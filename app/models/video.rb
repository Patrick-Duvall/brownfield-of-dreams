class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  validates :position, presence: true

  def self.update_positions
    all.each do |video|
      video.update(position:  1) if video.position == nil
    end
  end
end
