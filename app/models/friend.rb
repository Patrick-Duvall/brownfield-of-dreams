class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friended_user, class_name: 'User'
end
