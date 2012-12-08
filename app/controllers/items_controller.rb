# We will use HTTParty to handle the API calls
require 'httparty'
# Using Json to parser the API response
require 'json'

class ItemsController < ApplicationController
  def create
    
  end
  
  def destroy
    
  end
  
  def welcome
    
  end
  
  def pull_HN_front_page
    # When developing this, I could not get any response when calling the HN API with a nextId param. The server always
    # responded with a "Runtime error", so as those pages are not reliable, I decided that only the first page of 
    # items of the HN front page is relevant each time, and we will ignore the older items (no nextId parameter).
    begin
      parsed_response = JSON.parse HTTParty.get('http://api.ihackernews.com/page').response.body
      @items = parsed_response["items"]
      # We store the items received in the DB, for future reference or long-term figures / statistics
      @items.each do |item|
        unless Item.find_by_HN_id(item["id"])
          Item.create(:commentCount => item["commentCount"], :HN_id => item["id"], :points => item["points"], 
            :postedAgo => item["postedAgo"], :postedBy => item["postedBy"], :title => item["title"], :url => item["url"])
        end
      end   
      # We need and array with the points values in order to calculate the mean, median and mode
      @points_array = get_array_with_points(@items)
      @mean_value = calculate_mean_for_HN_items(@points_array)
      @median_value = calculate_median_for_HN_items(@points_array)
      @mode_value = calculate_mode_for_HN_items(@points_array)
      
      
      
    rescue Exception => e
      flash[:error] = "We are sorry, but the Hacker News API is not responding at the moment. Please, try again."
      redirect_to root_path
    end  
    
 
  end
  
  
  private
  
  def get_array_with_points(items)
    points_array = items.collect do |item|
                      item.values[4]
                   end
    return points_array
  end
  
  def calculate_mean_for_HN_items(points_array)
    return points_array.inject{ |sum, element| sum + element }.to_f / points_array.size
  end
  
  def calculate_median_for_HN_items(points_array)
    sorted = points_array.sort
    mid = points_array.size/2
    sorted[mid]
  end
  
  def calculate_mode_for_HN_items(points_array)
    freq = points_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    points_array.sort_by { |v| freq[v] }.last
  end
  
end
