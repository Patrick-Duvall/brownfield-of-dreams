# frozen_string_literal: true

class AddFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.timestamps
      t.belongs_to :user
      t.belongs_to :friended_user
      t.index %i[user_id friended_user_id], unique: true
    end
  end
end
