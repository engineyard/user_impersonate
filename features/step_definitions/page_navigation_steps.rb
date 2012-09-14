When /^I visit the takeover page$/ do
  visit "/takeover"
end

Then /^I told that page does not exist$/ do
  response.response_code.must_equal 404
end

When /^I search for a user "(.*?)"$/ do |name|
  fill_in "Search user", name
  click "Search"
end

When /^I click "(.*?)"$/ do |button|
  click button
end

Then /^I see "(.*?)"$/ do |text|
  pending # express the regexp above with the code you wish you had
end

Then /^I do not see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

