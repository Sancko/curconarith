# Curconarith

Welcome to Curconarith gem! It provide a lot of functionalyty connected with money. That incudes currency change to the given rate and to the default currency of the system.
Using this gem allows you to do any kind of arithmetics action with money that you can just imagine! (if you know that isnt covered by this gem feel free to contact me!).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'curconarith'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install curconarith

## Usage

# Configure the currency rates with respect to a base currency (here EUR):
``` ruby
Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'CAN'     => 2.22 } )
``` 
  
# Instantiate money objects:
``` ruby
money = Money.new(1000, "USD")
``` 

# Get amount and currency:
``` ruby
money.anount    #=> 1000
money.currency  #=> "USD"
money.inspect   # => "1000 EUR"
``` 
# Convert to a different currency
``` ruby
Money.new(1000, "EUR").convert_to('USD')   # => 1110 USD    #return Money object
``` 
# Comparisons (also in different currencies)
``` ruby
Money.new(1000, "USD") == Money.new(1000, "USD")   #=> true
Money.new(1000, "USD") == Money.new(100,  "USD")   #=> false
Money.new(1000, "USD") == Money.new(1000, "EUR")   #=> false
Money.new(1000, "USD") <  Money.new(1000, "EUR")   #=> true
Money.new(1000, "USD") <= Money.new(1000, "USD")   #=> true
Money.new(100,  "USD") >= Money.new(100,  "USD")   #=> true
Money.new(1000, "USD") >  Money.new(1000, "EUR")   #=> false
Money.new(0,    "EUR") == Money.new(0,    "EUR")   #=> true
```

# Arithmetic (perform operations in different currencies)
``` ruby
Money.new(1000, "EUR") + Money.new(222, "CAN") == Money.new(1100, "EUR")
Money.new(1000, "USD") + Money.new(200, "CAN") == Money.new(1200, "USD")
Money.new(1000, "EUR") - Money.new(111, "USD") == Money.new(900,  "EUR")
Money.new(1000, "USD") - Money.new(150, "CAN") == Money.new(850,  "USD")
Money.new(1000, "USD") / 5                     == Money.new(200,  "USD")
Money.new(1000, "USD") * 5                     == Money.new(5000, "USD")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sancko/curconarith This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Curconarith project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Sancko/curconarith/blob/master/CODE_OF_CONDUCT.md).
