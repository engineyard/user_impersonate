When /^I visit the home page$/ do
  visit "/"
end

When /^I visit the takeover page$/ do
  # TODO should take a secret token of some sort?
  visit "/takeover"
end

Then /^I am told that page does not exist$/ do
  # save_and_open_page
  assert page.has_content?("The page you were looking for doesn't exist (404)")
  
  assert_response 404
end

When /^I search for a user "(.*?)"$/ do |name|
  fill_in "Search user", with: name
  click "Search"
end

When /^I click "(.*?)"$/ do |button|
  click button
end

Then /^I see "(.*?)"$/ do |text|
  assert page.has_content?(text)
end

Then /^I do not see "(.*?)"$/ do |text|
  assert ! page.has_content?(text)
end

