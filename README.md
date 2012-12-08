# This is an example application for Paddy Power, the "Paddy Power - Hacker news app"

The specifications for this example app are the following:

Use the Hacker News API (http://api.ihackernews.com/) to pull the HN home page
news using Ruby. Calculate the mean, median, and mode score for the news items.
Extend your program to send an email with these calculated values, along with all
stories above the median.

# My personal comments:

* I have created a controller with the actions for this app: Welcome, pull_HN_front_page and send_HN_by_email
* I have created a module (HandleAPI) with the methods that process the response received from the HN API
* I have also created a model, to keep in our DB the stories received from the API call, until we send them by email
* The necessary routes have been added.
* Views and styles for a nice looking app have been created. I also used Bootstrap a little for quick styling.
* I created a mailer to send the email with the calculated figures and the most interesting stories.
* I have also added some tests (integration, controller and mailer tests). However, I did not complete the testing of the email sending, as my first attempt was not working correctly and I was running out of time. I also saw in the development log that the email is being sent correctly.
* I have noticed that the servers hosting the Hacker News API are not stable. They response with "Runtime Error" quite often. Therefore I have dealt with that error in our application so that it shows a message to the user.
