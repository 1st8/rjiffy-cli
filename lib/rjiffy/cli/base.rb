module Rjiffy
  module CLI
    class Base < Thor
      #include Thor::Actions

      def self.show_wait_cursor(seconds,fps=8)
        #chars = %w[⣾⣿ ⣽⣿ ⣻⣿ ⢿⣿ ⡿⣿ ⣿⢿ ⣿⡿ ⣿⣟ ⣿⣯ ⣿⣷ ⣿⣾ ⣷⣿]
        #chars = %w[⠁⠂⠄⡀⢀⠠⠐⠈]
        #chars = %w{⠙ ⠸ ⢰ ⣠ ⣄ ⡆ ⠇ ⠋}
        chars = []
        #chars << '⠉⠁'
        #chars << '⠈⠙'
        #chars << ' ⠙'
        #chars << ' ⠸'
        #chars << ' ⢰'
        #chars << ' ⣠'
        #chars << '⢀⣀'
        #chars << '⣀⡀'
        #chars << '⣄ '
        #chars << '⡆ '
        #chars << '⠇ '
        #chars << '⠇ '
        #chars << '⠋ '
        chars << '⠈⠑'
        chars << ' ⠱'
        chars << ' ⡰'
        chars << '⢀⡠'
        chars << '⢄⡀'
        chars << '⢆ '
        chars << '⠎ '
        chars << '⠊⠁'

        delay = 1.0/fps
        (seconds*fps).round.times{ |i|
          str = "#{chars[i % chars.length]} "
          print str
          sleep delay
          print "\b" * str.length
        }
      end

      def initialize(*)
        super
        Wrest.logger.level = Logger::INFO
        Rjiffy::Configuration.configure do |conf|
          if ENV['JIFFY_TOKEN'].blank?
            puts "Set JIFFY_TOKEN environment variable to your api token\nexample: JIFFY_TOKEN=my_token jiffy status"
            exit(-1)
          end
          conf.token = ENV['JIFFY_TOKEN']
        end
      end

      desc "status", "List boxes"
      def status
        Rjiffy::Box.all.each do |box|
          puts "%6d %-25s %10s" % [box.id, box.name, box.status]
        end
      end

      desc 'test', 'test'
      def test
        print "Loading... "
        self.class.show_wait_cursor 10
      end

      require 'rjiffy/cli/box'
      desc "box SUBCOMMAND ...ARGS", "manage a box"
      subcommand "box", CLI::Box

    end
  end
end