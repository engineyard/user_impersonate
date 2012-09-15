When /^I visit the home page$/ do
  visit "/"
end

When /^I visit the takeover page$/ do
  # TODO should take a secret token of some sort?
  visit "/takeover"
end

Then /^I am told that page does not exist$/ do
  assert page.has_content?("You don't have access to this section.")
end

When /^I search for a user "(.*?)"$/ do |name|
  fill_in "search", with: name
  click_button "Search"
end

When /^I click link "(.*?)"$/ do |button|
  click_link button
end

Then /^I see "(.*?)"$/ do |text|
  assert page.has_content?(text)
end

Then /^I do not see "(.*?)"$/ do |text|
  assert ! page.has_content?(text)
end

