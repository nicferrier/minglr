require File.join(File.dirname(__FILE__), "shared_steps")

Given /^the project "([^\"]*)"$/ do |project|
  @project = project
end

Given /^the card number "([^\"]*)"$/ do |card_number|
  if @options
    @options << [card_number]
  else
    @options = [card_number]
  end
end

Given /^a keyword of "([^\"]*)"$/ do |keyword|
  if @options
    @options << [keyword]
  else
    @options = [keyword]
  end
end

When /^I issue the "([^\"]*)" action$/ do |action|
  @action = action
  @response = execute_minglr_command(@project, @action, @options)
end

Then /^the result should have "([^\"]*)" in it$/ do |string|
  assert @response.split("\n").join(" ").include?(string), "Expected #{@response.inspect} to contain '#{string}'"
end

Then /^the result should not have "([^\"]*)" in it$/ do |string|
  assert !@response.split("\n").join(" ").include?(string), "Expected #{@response.inspect} to not contain '#{string}'"
end