module Rjiffy
  module CLI
    class Base < Thor
      #include Thor::Actions

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

      require 'rjiffy/cli/box'
      desc "box SUBCOMMAND ...ARGS", "manage a box"
      subcommand "box", CLI::Box

    end
  end
end