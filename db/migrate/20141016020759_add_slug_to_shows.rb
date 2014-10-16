class AddSlugToShows < ActiveRecord::Migration
  def change
  	add_column :shows, :slug, :string, unique: true
  	add_index :shows, :slug
  end
end
