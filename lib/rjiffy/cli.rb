require 'rjiffy'
require 'thor'
require 'pp'

require 'rjiffy/cli/version'
require 'rjiffy/cli/base'

module Rjiffy
  module CLI

    SPINNER_CHARS = [].tap do |chars|
      chars << '⠈⠑'
      chars << ' ⠱'
      chars << ' ⡰'
      chars << '⢀⡠'
      chars << '⢄⡀'
      chars << '⢆ '
      chars << '⠎ '
      chars << '⠊⠁'
    end.freeze

    def self.start(*args)
      Base.start(*args)
    end

    # http://stackoverflow.com/a/10263337/1113440
    def self.show_wait_spinner(fps=8, &block)
      delay = 1.0/fps
      iter = 0

      spinner = Thread.new do
        while iter do # Keep spinning until told otherwise
          str = " #{SPINNER_CHARS[(iter+=1) % SPINNER_CHARS.length]} "
          print str
          sleep delay
          print "\b" * str.length
        end
      end

      yield.tap do     # After yielding to the block, save the return value
        iter = false   # Tell the thread to exit, cleaning up after itself…
        spinner.join   # …and wait for it to do so.
      end
    end

    def self.wait_for(status, &block)
      start = Time.now
      box = yield

      if box.status == status.to_s
        puts "Box is already #{status}"
      else
        sleep(5)
        transition_status = box.reload.status
        # wait till status changes
        while box.status == transition_status
          print "\rBox status: #{box.status}"
          show_wait_spinner do
            sleep(5)
            box.reload
          end
        end
        print "\r"
        # is result status expected status?
        if box.status == status.to_s
          puts "Transition complete, box is now #{box.status}. Took: #{Time.now - start}s"
        else
          puts "Transition failed, box is now #{box.status}"
        end
      end
    end

  end
end

