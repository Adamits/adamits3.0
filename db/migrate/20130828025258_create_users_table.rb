class CreateUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.timestamps
    end
  end

  def down
  end
end