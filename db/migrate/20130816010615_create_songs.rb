class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
    	t.string :title
    	t.string :duration
    	t.integer :track
    	t.string :mp3_url
    	t.integer :artist_id
    	t.integer :album_id
      t.timestamps
    end
  end
end
