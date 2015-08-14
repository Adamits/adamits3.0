class AddIdToPostsTags < ActiveRecord::Migration
  def change
    add_column :posts_tags, :id, :primary_key
  end
end
