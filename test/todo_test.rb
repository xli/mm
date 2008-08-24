require File.dirname(__FILE__) + '/expectation_helper'

#Tags: todo
Expectations do
  expect '! > Nothing.' do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo').to_s
  end

  expect "\n0) \e[1;33mStart Work: this is important\e[0m\n\n! > Type index number to select item from list.\n " do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important').to_s
  end
  
  expect true do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('todo').to_s.include?('this is important')
  end
  
  expect "\n0) \e[1;33mStart Work: this is important\e[0m\n\n! > Type index number to select item from list.\n " do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('list').to_s
  end
end