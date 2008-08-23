require File.dirname(__FILE__) + '/expectation_helper'

Expectations do
  expect "\n0) 1\n1) 2\n\n! > Type index number to select item from list.\n " do
    MM::Console::SelectingList.new(['1', '2'], Class).to_s
  end
end