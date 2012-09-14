Given /^I am a normal user "(.*?)"$/ do |name|
  unless user = User.find_by_name(name)
    raise "Unknown User with name '#{name}'"
  end
  visit "/users/sign_in"
  fill_in "Email", with: user.email
  fill_in "Password", with: "abc123"
  click "Sign in"
end

Given /^I am a staff user "(.*?)"$/ do |name|
  @user = name
  @is_staff = true
end
