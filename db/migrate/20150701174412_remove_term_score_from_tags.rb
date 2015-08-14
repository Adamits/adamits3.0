class RemoveTermScoreFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :term_score, :float
  end
end
