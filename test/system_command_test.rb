require File.dirname(__FILE__) + '/expectation_helper'

Expectations do
  expect [0, "svn status result"] do
    @runtime = $helper.runtime
    @runtime[:api][:execute_cmd, "which \"svn\""] = [0, "/usr/bin/svn\n"]
    @runtime[:api][:execute_cmd, "svn status"] = [0, "svn status result"]
    
    processor = MM::Console::Processor.new(@runtime)
    processor.process("svn status")
  end
  
end
