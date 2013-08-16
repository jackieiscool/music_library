class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :playlists
  has_many :user_songs
  has_many :songs, through: :user_songs
end
