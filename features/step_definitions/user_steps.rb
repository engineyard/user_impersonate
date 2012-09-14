Given /^I am a (normal|staff) user "(.*?)"$/ do |type, name|
  unless user = User.find_by_name(name)
    raise "Unknown User with name '#{name}'"
  end
  visit "/users/sign_in"
  fill_in "Email", with: user.email
  fill_in "Password", with: "abc123"
  click_button "Sign in"
  assert page.has_content?("Welcome #{name}!")
end
