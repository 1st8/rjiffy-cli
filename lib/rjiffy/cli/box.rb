module Rjiffy
  module CLI
    class Box < Thor
      #include Thor::Actions

      desc 'show BOX_ID', 'Show box details'
      def show(box_id)
        box = Rjiffy::Box.find(box_id)
        pp box
      end

      desc 'shutdown BOX_ID', 'Shut a box down'
      def shutdown(box_id)
        box = Rjiffy::Box.find(box_id)

        if box.running
          puts "Shutting box '#{box.name}' down..."
          CLI.wait_for :READY do
            box.shutdown
          end
        else
          puts "This box is not running"
        end
      end

      desc 'start BOX_ID', 'Start a box'
      def start(box_id)
        box = Rjiffy::Box.find(box_id)

        if box.running
          puts "This box is already running"
        else
          puts "Starting box '#{box.name}'..."
          CLI.wait_for :READY do
            box.start
          end
        end
      end

      desc 'freeze BOX_ID', 'Transition box to FROZEN'
      def freeze(box_id)
        box = Rjiffy::Box.find(box_id)

        puts "Freezing box '#{box.name}'..."
        CLI.wait_for :FROZEN do
          box.freeze
        end
      end

      desc 'thaw BOX_ID', 'Thaw a box'
      def thaw(box_id, plan_id = nil)
        box = Rjiffy::Box.find(box_id)
        plan_id ||= box.plan.id

        puts "Thawing box '#{box.name}'..."
        CLI.wait_for :READY do
          box.thaw(plan_id)
        end
      end

    end
  end
end