namespace :videos do
  desc 'Set nil video positions to 1'
  task update_nil_position: :environment do
    Video.all.each do |video|
      video.update(position: 1) if video.position.nil?
    end
  end
end
