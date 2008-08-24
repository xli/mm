require File.dirname(__FILE__) + '/expectation_helper'

#Tags: todo
Expectations do
  expect '! > Nothing.' do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo').to_s
  end

  expect %Q{
0) \e[0;33mStart Work: this is important\e[0m

! > Type index number to select item from list.
 } do
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
  
  expect %Q{
0) \e[0;33mStart Work: this is important\e[0m

! > Type index number to select item from list.
 } do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('list').to_s
  end

  expect %Q{
0) \e[1;31mComplete: this is important\e[0m

! > Type index number to select item from list.
 } do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('0').to_s
  end

  expect %Q{
0) \e[0;90mDelete: this is important\e[0m

! > Type index number to select item from list.
 } do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('0')
    processor.process('0').to_s
  end

  expect %Q{
0) \e[0;33mStart Work: this should be index 0\e[0m
1) \e[0;33mStart Work: this is important\e[0m

! > Type index number to select item from list.
 } do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('todo this should be index 0').to_s
  end

  expect %Q{
0) \e[1;31mComplete: this is important\e[0m
1) \e[0;33mStart Work: this should be index 0\e[0m

! > Type index number to select item from list.
 } do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('todo this should be index 0')
    processor.process('1').to_s
  end

  expect %Q{
0) \e[0;33mStart Work: this should be index 0\e[0m
1) \e[0;90mDelete: this is important\e[0m

! > Type index number to select item from list.
 } do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('todo this is important')
    processor.process('todo this should be index 0')
    processor.process('1')
    processor.process('0').to_s
  end
end
