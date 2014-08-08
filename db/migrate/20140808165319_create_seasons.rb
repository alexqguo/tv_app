class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
    	t.integer :season_number, null: false
    	t.integer :show_id, null: false
    	t.integer :tmdb_id, null: false
      t.integer :show_tmdb_id, null: false
    	t.string :poster_path
    	t.text :description

      t.timestamps
    end

    add_index :seasons, :show_id
    add_index :seasons, :tmdb_id
  end
end
