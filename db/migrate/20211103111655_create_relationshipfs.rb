class CreateRelationshipfs < ActiveRecord::Migration[6.1]
  def change
    create_table :relationshipfs do |t|
      t.integer :following_id, null: false
      t.integer :follower_id, null: false

      t.timestamps
    end
    add_index :relationshipfs, :follower_id
    add_index :relationshipfs, :follower_id
    add_index :relationshipfs, %i[follower_id following_id],unique: true

  end
end
