class Playlist < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
end
