# RJiffy::Cli

CLI for the [Jiffybox Cloudserver](http://jiffybox.de) API, extending the [rjiffy](http://suchasurge.github.com/rjiffy/) library.

## Installation

Add this line to your application's Gemfile:

    gem 'rjiffy-cli'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rjiffy-cli

## Usage

Set environment variable `JIFFY_TOKEN` (i.e. `export JIFFY_TOKEN=my_token`) to be able to access the API

### Show usage instructions

`bundle exec jiffy`

### Get a short status of all your boxes

`bundle exec jiffy status`

### Start|stop|freeze|thaw boxes

`bundle exec jiffy {start|stop|freeze|thaw} BOX_ID`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
