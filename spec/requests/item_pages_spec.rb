require 'spec_helper'

describe "Item pages" do

  subject { page }
  
  describe "Visiting the home page" do
    before { visit root_path }
    it { should have_link('Pull the HN front page now!', href: pull_HN_front_page_items_path) }
    
    describe "Pulling the Hacker News home page stories should store items in the DB" do
      after(:all) { Item.delete_all }
      it "should change the number of records in the DB" do
         expect { click_link('Pull the HN front page now!') }.to change(Item, :count)
      end
    end

    describe "Visiting the pull Hacker News page" do
      before { click_link "Pull the HN front page now!" }
  
        describe "should take me to the pull_HN_front_page" do
          it { should have_selector('h3', text: "These are the statistics scores for this set of Hacker News:") } 
          it { should have_selector('h3', text: "Do you want to send these figures along with the most interesting stories to someone ?") }
          it { should have_selector('th', text: "Title") }
          it { should have_selector('div', class: "value") }
        end
    end
  end

  describe "Sending an email with the figures and most interesting stories" do
    it "This is tested somewhere else" do
      pending("The email sending is tested with controller and mailer tests")
      this_should_not_get_executed
    end   
  end  
  
end