require File.dirname(__FILE__) + '/expectation_helper'

Expectations do
  expect MM::Console::SelectingList.new(['#1 first card'], MM::Console::Card) do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
  end
  
  expect 'My Work' do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    @runtime[:context].to_s
  end
  
  expect MM::Console::SelectingList.new(['#1 first card'], MM::Console::Card) do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('view My Work')
  end

  expect 'My Work' do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('view My Work')
    @runtime[:context].to_s
  end

  expect 'card transition executed' do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Start fix', :card => 1, :properties => nil, :comment => nil}] = 'card transition executed'
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('Start fix #1')
  end
end

#select item from view list
Expectations do
  expect '#1 first card' do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('0').to_s
  end

  expect RuntimeError do
    @runtime = $helper.runtime
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('view My Work')
    processor.process('1')
  end
end