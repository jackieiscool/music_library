class Song < ActiveRecord::Base
  attr_accessible :title, :duration, :track, :mp3_url

  belongs_to :artist
  belongs_to :album

  has_many :user_songs
  has_many :users, through: :user_songs
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
end
