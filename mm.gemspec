Gem::Specification.new do |spec|
  spec.name = 'mm'
  spec.version = "0.0.3"
  spec.summary = "MM is a development console integrating with Mingle(http://studios.thoughtworks.com/) by Mingle REST API."

  #### Dependencies and requirements.

  spec.add_dependency('activeresource', '> 2.0.1')
  #s.requirements << ""
  # p Dir.glob("lib/**/*.rb") + Dir.glob("test/**/*.rb")
  spec.files = ["lib/mm/api/mingle.rb", "lib/mm/api.rb", "lib/mm/command/console.rb", "lib/mm/console/card.rb", "lib/mm/console/card_resource_command.rb", "lib/mm/console/no_resource_command.rb", "lib/mm/console/processor.rb", "lib/mm/console/runtime_variable.rb", "lib/mm/console/select_index_command.rb", "lib/mm/console/selecting_list.rb", "lib/mm/console/simple_command/base.rb", "lib/mm/console/simple_command/clean_cache.rb", "lib/mm/console/simple_command/help.rb", "lib/mm/console/simple_command/open.rb", "lib/mm/console/simple_command/runtime_variables.rb", "lib/mm/console/simple_command/tabs.rb", "lib/mm/console/simple_command/todo.rb", "lib/mm/console/simple_command.rb", "lib/mm/console/system_cmd.rb", "lib/mm/console/transition.rb", "lib/mm/console/view.rb", "lib/mm/mml.tab.rb", "lib/mm/repository.rb", "lib/mm/resource/mingle.rb", "lib/mm/resource.rb", "lib/mm/utils.rb", "lib/mm.rb", "test/api_test.rb", "test/console_test.rb", "test/console_view_test.rb", "test/expectation_helper.rb", "test/help_test.rb", "test/history_test.rb", "test/open_test.rb", "test/selecting_list_test.rb", "test/system_command_test.rb", "test/todo_test.rb", "test/transitions_test.rb"] + ["bin/mm", "bin", "CHANGES", "install.rb", "lib", "LICENSE.TXT", "Rakefile", "README", "TODO", 'mm.gemspec']

  #### Load-time details: library and application (you will need one or both).

  spec.require_path = 'lib'                         # Use these for libraries.

  spec.bindir = "bin"                               # Use these for applications.
  spec.executables = ["mm"]
  spec.default_executable = "mm"

  #### Documentation and testing.

  spec.has_rdoc = false

  #### Author and project details.

  spec.author = "Li Xiao"
  spec.email = "iam@li-xiao.com"
  spec.homepage = "http://github.com/xli/mm/tree/master"
end