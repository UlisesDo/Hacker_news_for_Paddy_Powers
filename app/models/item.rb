class Item < ActiveRecord::Base
  attr_accessible :commentCount, :id, :points, :postedAgo, :postedBy, :title, :url
end
