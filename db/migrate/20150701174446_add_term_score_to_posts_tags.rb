class AddTermScoreToPostsTags < ActiveRecord::Migration
  def change
    add_column :posts_tags, :term_score, :float
  end
end
