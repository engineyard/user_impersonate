Given /^I am a normal user "(.*?)"$/ do |name|
  @user = name
  @is_staff = false
end

Given /^I am a staff user "(.*?)"$/ do |name|
  @user = name
  @is_staff = true
end
