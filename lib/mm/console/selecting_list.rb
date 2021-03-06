module MM
  module Console
    class SelectingList
      def initialize(list, handle_item_class)
        @list = list
        @handle_item_class = handle_item_class
      end
      
      def <<(item)
        @list << item
      end
      
      def unshift(item)
        @list.unshift(item)
      end
      
      def uniq!
        @list.uniq!
      end
      
      def delete(item)
        @list.delete(item)
      end
      
      def size
        @list.size
      end
      
      def select_by_index(runtime, index)
        if @list[index]
          @handle_item_class.new(@list[index]).execute(runtime)
        else
          raise "Did I surppose you to select #{index}?"
        end
      end
      
      def ==(obj)
        return false unless obj
        obj.to_s == to_s && obj.instance_variable_get(:@handle_item_class) == @handle_item_class
      end
      
      def to_s
        if @list.blank?
          '! > Nothing.'
        else
          ret = ['']
          @list.each_with_index do |obj, index|
            ret << "#{index}) #{obj}"
          end
          ret << ''
          ret << "! > Type index number to select item from list.\n " #added one space at the end line so that it can be print out
          ret.join("\n")
        end
      end
    end
  end
end