require File.dirname(__FILE__) + '/expectation_helper'

Expectations do
  expect [0, "output\n"] do
    MM::API.new.execute_cmd('echo "output"')
  end
end
