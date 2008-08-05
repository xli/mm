require File.dirname(__FILE__) + '/expectation_helper'

#Tags: card
Expectations do
  expect '#1 first card' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1').to_s
  end
  
  expect RuntimeError do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
  end
  
  expect 'story 1' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    @runtime[:context].to_s
  end
  
  expect RuntimeError do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#')
  end
  
  expect 'first card' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('name')
  end
  
  expect 'new' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story', :cp_status => 'new')
    @runtime[:api][:property_definitions] = [$helper.property_definition(:name => 'status', :column_name => 'cp_status')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('status')
  end
  
  expect :status => 'new' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story', :cp_status => 'new')
    @runtime[:api][:property_definitions] = [$helper.property_definition(:name => 'status', :column_name => 'cp_status')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 status')
  end
  
  expect :name => 'first card' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 name')
  end
end

#Tags: transition
Expectations do
  expect 'card transition executed' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:create_transition_execution, {:transition => 'Start fix', :card => 1, :properties => nil, :comment => nil}] = 'card transition executed'
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('Start fix #1')
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

#runtime variable
Expectations do
  expect '2' do
    @runtime = $helper.runtime
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('revision = 2')
    @runtime[:revision]
  end
  
  expect 'Complete fix with resolution => fixed, "revision fixed" => #{revision}' do
    @runtime = $helper.runtime
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('fixed = \'Complete fix with resolution => fixed, "revision fixed" => #{revision}\'')
    @runtime[:fixed]
  end
end

#integrate with svn
Expectations do
  expect "revision 2" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "svn ci -m 'message'"] = [0, "revision 2"]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("`svn ci -m 'message'`")
  end
  
  expect "svn commit failed" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "svn ci -m 'Complete fix #1: details'"] = [1, "svn commit failed"]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('fixed = \'Complete fix #1 with resolution => fixed\'')
    processor.process("`svn ci -m '[fixed]: details'`")
  end
  
  expect "card transition executed" do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    @runtime[:api][:execute_cmd, "svn ci -m 'Complete fix #1: details'"] = [0, "revision 2"]
    @runtime[:api][:create_transition_execution, {:transition => 'Complete fix', :card => 1, :properties => [{:name => 'resolution', :value => 'fixed'}, {:name => 'revision', :value => '2'}], :comment => nil}] = 'card transition executed'
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('fixed = \'Complete fix #1 with resolution => fixed, "revision" => #{revision}\'')
    processor.process("`svn ci -m '[fixed]: details'`")
  end
end

#tabs
Expectations do
  expect ['My Work'] do
    @runtime = $helper.runtime
    @runtime[:api][:favorites] = [$helper.favorite(:name => 'My Work', :tab_view => true)]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('tabs')
  end

  expect ['#1 first card'] do
    @runtime = $helper.runtime
    @runtime[:api][:favorites] = [$helper.favorite(:name => 'My Work', :tab_view => true)]
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('tabs')
    processor.process('0')
  end
end  