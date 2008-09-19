require File.dirname(__FILE__) + '/expectation_helper'

Expectations do
  expect [0, 'open card 1'] do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:execute_cmd, "open \"http://login:pass@domain.com/projects/mingle/cards/1\""] = [0, "open card 1"]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('site = \'http://login:pass@domain.com/projects/mingle\'')
    processor.process('#1')
    processor.process('open')
  end
  
  expect [0, 'open card 1'] do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:execute_cmd, "open \"http://login:pass@domain.com/projects/mingle/cards/1\""] = [0, "open card 1"]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('site = \'http://login:pass@domain.com/projects/mingle\'')
    processor.process('open #1')
  end

  expect 'story 1' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_card_by_number, 2] = $helper.card(:number => 2, :name => 'second card', :card_type_name => 'story')
    @runtime[:api][:execute_cmd, "open \"http://login:pass@domain.com/projects/mingle/cards/1\""] = [0, "open card 1"]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('site = \'http://login:pass@domain.com/projects/mingle\'')
    processor.process('#2')
    processor.process('open #1')
    @runtime[:context].to_s
  end

  expect [0, 'open view My Work'] do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    @runtime[:api][:execute_cmd, "open \"http://login:pass@domain.com/projects/mingle/cards?view=My Work\""] = [0, "open view My Work"]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('site = \'http://login:pass@domain.com/projects/mingle\'')
    processor.process('view My Work')
    processor.process('open')
  end
  
  expect [0, 'open view My Work'] do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    @runtime[:api][:execute_cmd, "open \"http://login:pass@domain.com/projects/mingle/cards?view=My Work\""] = [0, "open view My Work"]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('site = \'http://login:pass@domain.com/projects/mingle\'')
    processor.process('open My Work')
  end
  
end
