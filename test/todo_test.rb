require File.dirname(__FILE__) + '/expectation_helper'

#Tags: card
Expectations do
  expect '! > Nothing.' do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo').to_s
  end

  expect '' do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important').to_s
  end
end