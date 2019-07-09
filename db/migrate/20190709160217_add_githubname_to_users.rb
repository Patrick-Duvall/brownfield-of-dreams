# frozen_string_literal: true

class AddGithubnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_name, :string
  end
end
