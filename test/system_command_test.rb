require File.dirname(__FILE__) + '/expectation_helper'

Expectations do
  expect "svn status result" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "which \"svn\""] = [0, "/usr/bin/svn\n"]
    @runtime[:api][:execute_cmd, "svn status"] = [0, "svn status result"]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("svn status")
  end
  
  expect "svn status result" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "which \"svn\""] = [0, "/usr/bin/svn\n"]
    @runtime[:api][:execute_cmd, "svn status"] = [0, "svn status result"]
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("#1")
    processor.process("svn status")
  end
  
  expect "svn ci result" do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "which \"svn\""] = [0, "/usr/bin/svn\n"]
    @runtime[:api][:execute_cmd, "svn ci -m 'cant parsed'"] = [0, "svn ci result"]
    @runtime[:api][:find_card_by_number, 1] = $helper.card(:number => 1, :name => 'first card', :card_type_name => 'story')
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("#1")
    processor.process("svn ci -m 'cant parsed'")
  end
end
