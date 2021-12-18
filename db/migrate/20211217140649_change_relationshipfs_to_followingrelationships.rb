class ChangeRelationshipfsToFollowingrelationships < ActiveRecord::Migration[6.1]
  def change
    rename_table :relationshipfs, :followingrelationships
  end
end
