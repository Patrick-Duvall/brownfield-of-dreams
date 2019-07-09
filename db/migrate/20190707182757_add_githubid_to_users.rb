# frozen_string_literal: true

class AddGithubidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_id, :integer
  end
end
