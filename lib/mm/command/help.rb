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

module MM
  module Command
    class Help
      def doc
%{
mm, version #{MM::VERSION}

Queck start part 1:

MM is a tool for integrating Mingle(http://studios.thoughtworks.com/) with command-line
For additional information, see http://mm.rubyforge.org
Notes: 
  * There would be a '.mm_pstore' file created for cache in the mm working directory.
}
      end
    end
  end
end