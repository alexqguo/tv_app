class CreateUserShows < ActiveRecord::Migration
  def change
    create_table :user_shows do |t|
    	t.integer :user_id
    	t.integer :show_id

      t.timestamps
    end

    add_index :user_shows, :user_id
    add_index :user_shows, :show_id
  end
end
