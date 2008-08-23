require File.dirname(__FILE__) + '/expectation_helper'

#Tags: history
Expectations do
  expect '! > Nothing.' do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('history').to_s
  end
  
  expect "\n0) story 1\n\n! > Type index number to select item from list.\n " do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('history').to_s
  end
  
  expect "\n0) My Work\n1) story 1\n\n! > Type index number to select item from list.\n " do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('#1')
    processor.process('history').to_s
  end
  
  expect true do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('#1')
    processor.process('history')
    @runtime[:list] == @runtime[:history]
  end
  
  expect "\n0) #1 first card\n\n! > Type index number to select item from list.\n " do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('#1')
    processor.process('history')
    processor.process('0').to_s
  end

  expect MM::Console::SelectingList.new(['#1 first card'], MM::Console::Card) do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('#1')
    processor.process('history')
    processor.process('0')
    @runtime[:list]
  end

  expect MM::Console::SelectingList.new(['#1 first card'], MM::Console::Card) do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('#1')
    processor.process('history')
    processor.process('0')
    processor.process('list')
  end

  expect '#1 first card' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('#1')
    processor.process('history')
    processor.process('1').to_s
  end

  expect 'story 1' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('#1')
    processor.process('history')
    processor.process('1')
    @runtime[:context].to_s
  end

end