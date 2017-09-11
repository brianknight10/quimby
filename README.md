# Quimby

![Travis CI](https://travis-ci.org/brianknight10/quimby.svg?branch=master)
[![Docker Pulls](https://img.shields.io/docker/pulls/brianknight10/quimby.svg)]()

A simple, secure, self-destructing message service, featuring [HashiCorp Vault](https://www.vaultproject.io/).

![Chief Quimby](https://vignette.wikia.nocookie.net/inspectorgadget/images/f/f3/Quimby.png/revision/latest/scale-to-width-down/225?cb=20140311000839)

## What does it do?

![Quimby](/quimby.png?raw=true)

## Docker

It's easiest to run Quimby with Docker. Simply run the container like this:

    $ docker run \
      -e "VAULT_ADDR=$VAULT_ADDR" \
      -e "VAULT_TOKEN=$VAULT_TOKEN" \
      -p 3000:3000 \
      brianknight10/quimby

## Development

To develop, you'll first need to install [Ruby][https://www.ruby-lang.org/].

Install the dependencies by running: `bundle install`.

Running the Rails server with: `rails s`.

Run tests with: `rake spec`

## Contributing

Contributions are welcome!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
