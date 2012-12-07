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
    # I assume that only the first page of items of the HN front page is relevant each time, so an user will
    # not have intention to specify a {nextId} to see older items.
    begin
      parsed_response = JSON.parse HTTParty.get('http://api.ihackernews.com/page').response.body
      @items = parsed_response["items"]
    rescue Exception => e
      flash[:error] = "We are sorry, but the Hacker News API is not responding at the moment. Please, try again."
      redirect_to root_path
    end  
 
  end
  
  
  private
  
  def make_calculations_for_HN_items
    
  end
  
end
