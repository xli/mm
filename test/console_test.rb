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
    @runtime[:api][:property_definitions] = [$helper.property_definition(:name => 'status', :column_name => 'cp_status', :data_type => 'string')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('status')
  end
  
  expect 'new' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story', :cp_status => 'new')
    @runtime[:api][:property_definitions] = [$helper.property_definition(:name => 'status', :column_name => 'cp_status', :data_type => 'string')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 status')
  end
  
  expect 'first card' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 name')
  end
  
  expect({:name => 'first card', :card_type_name => 'story'}) do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 name card_type_name')
  end
  
  expect 'Li Xiao' do
    @runtime = $helper.runtime
    @runtime[:api][:team_members] = [$helper.user(:id => 2, :login => 'xli', :name => 'Li Xiao')]
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :cp_owner_user_id => 2)
    @runtime[:api][:property_definitions] = [$helper.property_definition(:name => 'owner', :column_name => 'cp_owner_user_id', :data_type => 'user')]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 owner')
  end
  
  expect 'iteration 1' do
    @runtime = $helper.runtime
    @runtime[:api][:team_members] = [$helper.user(:id => 2, :login => 'xli', :name => 'Li Xiao')]
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :cp_iteration_card_id => 2)
    @runtime[:api][:find_card_by_number, 2] = $helper.card(:number => 2, :name => 'iteration 1', :cp_iteration_card_id => nil)
    @runtime[:api][:property_definitions] = [$helper.property_definition(:name => 'iteration', :column_name => 'cp_iteration_card_id', :data_type => 'card')]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 iteration')
  end
  
  expect :status => 'new' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story', :cp_status => 'new', :cp_owner_user_id => nil, :description => 'card description')
    @runtime[:api][:property_definitions] = [
      $helper.property_definition(:name => 'status', :column_name => 'cp_status', :data_type => 'string'),
      $helper.property_definition(:name => 'owner', :column_name => 'cp_owner_user_id', :data_type => 'user')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1')
    processor.process('properties')
  end

  expect :status => 'new' do
    @runtime = $helper.runtime
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story', :cp_status => 'new', :cp_owner_user_id => nil, :description => 'card description')
    @runtime[:api][:property_definitions] = [
      $helper.property_definition(:name => 'status', :column_name => 'cp_status', :data_type => 'string'),
      $helper.property_definition(:name => 'owner', :column_name => 'cp_owner_user_id', :data_type => 'user')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('#1 properties')
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

#runtime
Expectations do
  expect '2' do
    @runtime = $helper.runtime
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('revision = 2')
    @runtime[:revision]
  end
  
  expect false do
    @runtime = $helper.runtime
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process('revision = \'\'')
    @runtime.has_key? :revision
  end
  
  expect 'new api obj' do
    @runtime = $helper.runtime
    @runtime[:api][:renew] = 'new api obj'
    processor = MM::Console::Processor.new(@runtime)
    processor.process('clean_cache')
    @runtime[:api]
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
  expect "" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "svn st"] = [0, ""]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("`svn st`")
  end
  
  expect "M   file.txt" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "svn st"] = [0, "M   file.txt"]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("`svn st")
  end
  
  expect "revision: 4" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "svn ci -m '[not_variable_or_command]'"] = [0, "revision: 4"]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("`svn ci -m '[not_variable_or_command]'")
  end
  
  expect "revision: 4" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "svn ci -m '[#]'"] = [0, "revision: 4"]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("`svn ci -m '[#]'")
  end
  
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
    processor.process("`svn ci -m '[Complete fix #1 with resolution => fixed, \"revision\" => \#{revision}]: details'`")
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
  expect MM::Console::SelectingList.new(['My Work'], MM::Console::View) do
    @runtime = $helper.runtime
    @runtime[:api][:favorites] = [$helper.favorite(:name => 'My Work', :tab_view => true)]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('tabs')
  end

  expect MM::Console::SelectingList.new(['#1 first card'], MM::Console::Card) do
    @runtime = $helper.runtime
    @runtime[:api][:favorites] = [$helper.favorite(:name => 'My Work', :tab_view => true)]
    @runtime[:api][:find_cards, {:view => 'My Work'}] = [$helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')]
    processor = MM::Console::Processor.new(@runtime)
    processor.process('tabs')
    processor.process('0')
  end
end

#variables
Expectations do
  expect MM::Console::SelectingList.new([:api, :context], MM::Console::RuntimeVariables::Value) do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('variables')
  end

  expect MM::Console::SelectingList.new([:api, :context], MM::Console::RuntimeVariables::Value) do
    @runtime = $helper.runtime
    processor = MM::Console::Processor.new(@runtime)
    processor.process('v')
  end

  expect 'value' do
    @runtime = {}
    @runtime[:a_name] = 'value'
    processor = MM::Console::Processor.new(@runtime)
    processor.process('variables')
    processor.process('0')
  end
end

#selecting list
Expectations do
  expect "0) 1\n1) 2\n\n! > Type index number to select item from list.\n " do
    MM::Console::SelectingList.new(['1', '2'], Class).to_s
  end
end
