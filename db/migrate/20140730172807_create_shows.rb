class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
    	t.string :name, null: false
    	t.text :description
    	t.boolean :in_production, null: false
    	t.date :release_date
    	t.string :poster_image_path
    	t.string :created_by
    	t.integer :tmdb_id, null: false

      t.timestamps
    end
  end
end
