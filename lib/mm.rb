# Copyright (c) 2008 Li Xiao
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'mm/repository'
require 'mm/resource'
require 'mm/api'

require 'mm/command/console'
require 'mm/command/help'

require 'mm/mml.tab.rb'
require 'mm/console/processor'
require 'mm/console/site'
require 'mm/console/runtime_variables'
require 'mm/console/runtime_variable'
require 'mm/console/system_cmd'
require 'mm/console/card'
require 'mm/console/card_resource_command'
require 'mm/console/transition'
require 'mm/console/view'
require 'mm/console/tabs'
require 'mm/console/no_resource_command'
require 'mm/console/select_index_command'

module MM
  VERSION="0.0.3"
end
