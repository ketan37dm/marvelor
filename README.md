# Marvelor

This is a WIP wrapper gem for Marvel's API

## Installation

You can clone the directory and manually install it for your application as of now.
I will publish this once it is ready. Following step would be helpful -

1. Clone the Git repository.
`$ git clone git@github.com:ketan37dm/marvelor.git`

2. Change to the new directory.
`cd marvelor`

3. Build the gem
`$ rake build `

4. Install the gem.
`$ gem install pkg/marvelor-0.1.0.gem`

and Done ! Now you can simply do `require 'marvelor'` in IRB session and play with the gem !

## Usage

Please register first in the [Marvel Comics Developer
Portal](http://developer.marvel.com/) to get your API credentials (a public key
and a private key, you'll need them both to configure and instantiate a client).

### Instantiate a client

```ruby
client = Marvelor::API::Client.new(public_key: 'your_public_key', private_key: 'your_private_key')

# fetch a list of characters
client.characters

# find a specific character by name
client.characters(name: 'hulk')

# use limit and offset for pagination behavior
client.characters(limit: 10, offset: 400)

# fetch a single character by ID
client.character(id: 1009610)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/marvelor.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
