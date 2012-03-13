Chargify Direct Example
=======================

This is a small [Sinatra](http://www.sinatrarb.com/) app that demonstrates how to use [Chargify Direct](http://docs.chargify.com/chargify-direct-introduction) for
Signups.  It leverages the new [Chargify2 gem](https://github.com/chargify/chargify2) to create the Direct secure form inputs and signature, verify the redirect response, and fetch the call response.

Getting Started
---------------

1. Clone this repo to your local machine
2. Run `bundle install`
3. Copy `config/config.example.yml` to `config/config.yml`
4. Edit `config/config.yml` to add your own API User credentials (Note: this is a "V2" API User that is not generally available yet.  You may request one to be created by contacting [Michael Klett](https://github.com/moklett))
5. Create products on your API User's Site with handles 'basic' and 'pro' (or edit the example to match product handles you have)
6. Invoke the app with `rackup` and play at <http://localhost:9292>
