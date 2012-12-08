require "spec_helper"

describe ItemsController do
  describe "POST /items/send_HN_by_email" do
    it "sends an email." do
      @destination_email = "test@paddy_powers.com"
      @mean_value = 110.2
      @median_value = 87
      @mode_value = 52
      @items_to_send = [{"title"=>"Pokemon Yellow hack recodes the game from within","url"=>"http://tasvideos.org/forum/viewtopic.php?p=332488&sid=1d8670bd80327418d202b6608e5cd2a9#332488","HN_id"=>4891879,"commentCount"=>18,"points"=>136,"postedAgo"=>"3 hours ago","postedBy"=>"Luc"},{"title"=>"Exploring Emacs","url"=>"https://www.hackerschool.com/blog/11-exploring-emacs","HN_id"=>4892109,"commentCount"=>21,"points"=>52,"postedAgo"=>"2 hours ago","postedBy"=>"happy4crazy"}]
      
      post :send_HN_by_email, email: @destination_email
      expect_email ItemMailer.send_hacker_news_email(@items_to_send, @destination_email, @mean_value, @median_value, @mode_value)
      #expect_email ItemMailer.send_hacker_news_email(@destination_email)
    end
  end
end