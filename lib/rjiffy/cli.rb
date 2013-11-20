require 'rjiffy'
require 'thor'
require 'pp'

require 'rjiffy/cli/version'
require 'rjiffy/cli/base'

module Rjiffy
  module CLI

    def self.start(*args)
      Base.start(*args)
    end

    def self.wait_for(status, &block)
      box = yield

      if box.status == status.to_s
        puts "Box is already #{status}"
      else
        sleep(5)
        transition_status = box.reload.status
        # wait till status changes
        while box.status == transition_status
          sleep(5)
          box.reload
          puts "Box status: #{box.status}"
        end
        # is result status expected status?
        if box.status == status.to_s
          puts "Transition complete, box is now #{box.status}"
        else
          puts "Transition failed, box is now #{box.status}"
        end
      end
    end

  end
end

