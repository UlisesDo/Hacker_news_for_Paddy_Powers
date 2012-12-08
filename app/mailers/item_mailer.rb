class ItemMailer < ActionMailer::Base
  default from: "hacker_news@paddy_powers.com"
  
  def send_hacker_news_email(items_to_send, destination_email, mean_value, median_value, mode_value)
    @items_to_send = items_to_send
    @mean_value = mean_value
    @median_value = median_value
    @mode_value = mode_value
    mail(:to => destination_email, :subject => "Most interesting hacker news")
  end
  
end
