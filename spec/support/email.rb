def expect_email(items_to_send, destination_email, mean_value, median_value, mode_value)
#def expect_email(destination_email)
  delivered = ActionMailer::Base.deliveries.last
  expected =  destination_email.deliver

  delivered.multipart?.should == expected.multipart?
  delivered.headers.except("Message-Id").should == expected.headers.except("Message-Id")
end