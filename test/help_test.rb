require File.dirname(__FILE__) + '/expectation_helper'

#help
Expectations do
  expect true do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('help')
    processor.process('0').to_s.size > 0
  end
end
