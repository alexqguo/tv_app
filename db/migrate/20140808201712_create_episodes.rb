class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
    	t.string :name, null: false
    	t.integer :season_id, null: false
    	t.integer :season_number, null: false
    	t.integer :tmdb_id, null: false
    	t.integer :show_tmdb_id, null: false
    	t.text :description
    	t.date :air_date

      t.timestamps
    end

    add_index :episodes, :season_id
    add_index :episodes, :tmdb_id
  end
end
