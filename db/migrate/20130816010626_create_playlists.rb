class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
    	t.string :title
    	t.integer :user_id
      t.timestamps
    end
  end
end
