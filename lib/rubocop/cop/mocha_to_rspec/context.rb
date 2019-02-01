module RuboCop
  module Cop
    module MochaToRSpec
      class Context < Cop
        MSG = "Stubbing not allowed here".freeze

          # $(send (send nil? ...) :stubs ...)
        def_node_matcher :candidate?, <<-CODE
          (send _ {:stubs :expects} ...)
CODE

        def on_send(node)
          candidate?(node) do
            return unless node.parent&.source&.include?("before(:all)") == true
            add_offense(node, location: :selector)
          end
        end
      end
    end
  end
end
