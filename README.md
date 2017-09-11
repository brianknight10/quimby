# Quimby

[![Travis CI](https://travis-ci.org/brianknight10/quimby.svg?branch=master)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/brianknight10/quimby.svg)]()

A simple, secure, self-destructing message service, featuring [HashiCorp Vault](https://www.vaultproject.io/).

<img src="https://vignette.wikia.nocookie.net/inspectorgadget/images/f/f3/Quimby.png/revision/latest/scale-to-width-down/225?cb=20140311000839" alt="Chief Quimby" style="height: 300px;"/>  <img src="quimby.png?raw=true" alt="Quimby" style="width: 300px;"/>

## What does it do?

Quimby creates self-destructing secret messages for you to share with your colleagues. Using Vault's response wrapping, Quimby stores your secret in Vault's [cubbyhole](https://www.vaultproject.io/docs/secrets/cubbyhole/index.html) and wraps it with a one-time-use token that expires one hour after creation.

After creating your secret message, Quimby gives you a URL to share with your colleague. The URL will show the secret message one time only. After accessing the secret, or after one hour, the secret is destroyed.

## Docker

It's easiest to run Quimby with Docker. Simply run the container like this:

    $ docker run \
      -e "VAULT_ADDR=$VAULT_ADDR" \
      -e "VAULT_TOKEN=$VAULT_TOKEN" \
      -p 3000:3000 \
      brianknight10/quimby

The Quimby image is stored in the [Docker Hub repository](https://hub.docker.com/r/brianknight10/quimby/)

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
