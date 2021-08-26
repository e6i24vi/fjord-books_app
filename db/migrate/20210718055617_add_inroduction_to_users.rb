# frozen_string_literal: true

class AddInroductionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduction, :text
  end
end
