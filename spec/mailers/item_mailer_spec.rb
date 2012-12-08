require "spec_helper"

describe ItemMailer do
  describe "send_hacker_news_email" do
    @recipient = "test@paddy_powers.com"
    @mean_value = 110.2
    @median_value = 87
    @mode_value = 52
    @items_to_send = [{"title"=>"Pokemon Yellow hack recodes the game from within","url"=>"http://tasvideos.org/forum/viewtopic.php?p=332488&sid=1d8670bd80327418d202b6608e5cd2a9#332488","HN_id"=>4891879,"commentCount"=>18,"points"=>136,"postedAgo"=>"3 hours ago","postedBy"=>"Luc"},{"title"=>"Exploring Emacs","url"=>"https://www.hackerschool.com/blog/11-exploring-emacs","HN_id"=>4892109,"commentCount"=>21,"points"=>52,"postedAgo"=>"2 hours ago","postedBy"=>"happy4crazy"}]
      
    let(:email) { ItemMailer.send_hacker_news_email(@items_to_send, @recipient, @mean_value, @median_value, @mode_value) }

    it { email.from.should == [ "hacker_news@paddy_powers.com" ] }
    it { email.to.should == [ @recipient ] }
    it { email.subject.should == "Most interesting hacker news" }
  end
end