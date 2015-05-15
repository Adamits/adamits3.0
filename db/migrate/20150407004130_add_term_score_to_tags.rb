class AddTermScoreToTags < ActiveRecord::Migration
  def change
  		add_column :tags, :term_score, :float
  end
end
