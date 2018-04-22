# Marvelor

This is a WIP wrapper gem for Marvel's API

## Installation

You can clone the directory and manually install it for your application as of now.
I will publish this once it is ready.

## Usage

Please register first in the [Marvel Comics Developer
Portal](http://developer.marvel.com/) to get your API credentials (a public key
and a private key, you'll need them both to configure and instantiate a client).

### Instantiate a client

```ruby
client = Marvelite::API::Client.new(public_key: 'your_public_key', private_key: 'your_private_key')

# fetch a list of characters
client.characters

# find a specific character by name
client.characters(name: 'hulk')

# use limit and offset for pagination behavior
client.characters(limit: 10, offset: 400)

# fetch a single character by ID
client.character(id: 1009610)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/marvelor.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
