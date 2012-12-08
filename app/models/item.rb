class Item < ActiveRecord::Base
  attr_accessible :commentCount, :HN_id, :points, :postedAgo, :postedBy, :title, :url
  
  validates :commentCount, presence: true
  validates :HN_id, presence: true, uniqueness: true
  validates :points, presence: true
  validates :postedAgo, presence: true
  validates :postedBy, presence: true
  validates :title, presence: true
  validates :url, presence: true
end
