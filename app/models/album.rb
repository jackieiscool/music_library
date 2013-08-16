class Album < ActiveRecord::Base
  attr_accessible :title, :genre, :release_date, :img_url

  belongs_to :artist

end
