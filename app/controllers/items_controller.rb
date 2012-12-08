# We will use HTTParty to handle the API calls
require 'httparty'
# Using Json to parser the API response
require 'json'

class ItemsController < ApplicationController
  # We include the module where the methods to deal with the HN API are contained.
  include Handleapi
  
  def create
    # Not implemented for the moment, as we will not create Hacker news manually.
  end
  
  # GET /items/welcome
  def welcome  
  end
  
  # GET /items/pull_HN_front_page
  def pull_HN_front_page
    # When developing this, I could not get any response when calling the HN API with a nextId param. The server always
    # responded with a "Runtime error", so as those pages are not reliable, I decided that only the first page of 
    # items of the HN front page is relevant each time, and we will ignore the older items (no nextId parameter).
    begin
      parsed_response = JSON.parse HTTParty.get('http://api.ihackernews.com/page').response.body
      @items = parsed_response["items"]
      # We store the items received in the DB, in order to keep them and send them by email whenever we want
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
  
  # POST /items/send_HN_by_email
  def send_HN_by_email
    @email_address = params[:email]
    @mean_value = params[:mean].to_f
    @median_value = params[:median].to_i
    @mode_value = params[:mode].to_i
    @items_to_send = Item.where("points > ?", @median_value)
    
    ItemMailer.send_hacker_news_email(@items_to_send, @email_address, @mean_value, @median_value, @mode_value).deliver
    
    # Once we have sent the email with the stories and their figures, we delete all those stories from our DB, to
    # leave it clear and ready for the next pull. I decided this, as there is no requirement to keep the stories nor
    # to do anything with them in the future. We are interested in the CURRENT stories only.
    Item.all.each { |item| item.destroy }
  end
  
end
