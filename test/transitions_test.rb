require File.dirname(__FILE__) + '/expectation_helper'

Expectations do
  expect 'card transition executed' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Start fix', :card => 1, :properties => nil, :comment => nil}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('Start fix #1')
  end
  
  expect 'card transition executed' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'start fix', :card => 1, :properties => nil, :comment => nil}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('start fix #1')
  end
  
  expect 'card transition executed' do
    @runtime = $helper.runtime
    card = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_card_by_number, 1] = card
    @runtime[:api][:card_transitions, card] = ['Start fix']
    @runtime[:api][:create_transition_execution, {:transition => 'start fix', :card => 1, :properties => nil, :comment => nil}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('start fix')
  end
  
  expect 'story 1' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Start fix', :card => 1, :properties => nil, :comment => nil}] = 'card transition executed successfully'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('Start fix #1')
    @runtime[:context].to_s
  end

  expect 'card transition executed' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Start fix', :card => 1, :properties => [{:name => 'p', :value => 'v'}], :comment => 'comment'}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('Start fix with p => v (comment)')
  end
  
  expect MM::Console::SelectingList.new(['Complete', 'Close'], MM::Console::CardTransition) do
    @runtime = $helper.runtime
    card = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_card_by_number, 1] = card
    @runtime[:api][:card_transitions, card] = ['Complete', 'Close']

    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('transitions')
  end

  expect 'card transition executed' do
    @runtime = $helper.runtime
    card = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:find_card_by_number, 1] = card
    @runtime[:api][:card_transitions, card] = ['Complete', 'Close']
    @runtime[:api][:create_transition_execution, {:transition => 'Complete', :card => 1, :properties=>nil, :comment=>nil}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('transitions')
    processor.process('0')
  end
  
  expect "card transition executed" do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Complete fix', :card => 1, :properties => [{:name => 'resolution', :value => 'fixed'}], :comment => nil}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('fixed = \'Complete fix with resolution => fixed\'')
    processor.process("#1")
    processor.process('fixed')
  end

  expect "card transition executed" do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Complete fix', :card => 1, :properties => [{:name => 'resolution', :value => 'fixed'}], :comment => nil}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('fixed = \'Complete fix #1 with resolution => fixed\'')
    processor.process('fixed')
  end

  expect 'card transition executed' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Complete fix', :card => 1, :properties => [{:name => 'revision', :value => '2'}], :comment => nil}] = 'card transition executed'

    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('revision = 2')
    processor.process('Complete fix with revision => #{revision}')
  end
end