class CreateEpisodeViews < ActiveRecord::Migration
  def change
    create_table :episode_views do |t|
    	t.integer :episode_id, null: false
    	t.integer :user_id, null: false
    	t.integer :view_count, null: false, default: 1

      t.timestamps
    end

    add_index :episode_views, :episode_id
    add_index :episode_views, :user_id
  end
end
