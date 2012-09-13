Given /^that I am starting a new Pomodoro$/ do
  @a = Pomodoro.new(:length => 10)
end

When /^I start a new tomato$/ do
  @a.start
end

Then /^I should see "(.*?)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end
