To use this repo: clone, start up Redis and Postgres, run migrations. Make sure Postgres is version 9.3, the latest. If you're going to use Rails' development environment, replace the fake S3 access and secret access keys with real ones in carrierwave_init.rb. Otherwise, it will work straight out of the box for Rails' test environment. Read the Readme.rdoc raw for more details.

The server is now running solely on the sub-frameworks ActiveRecord and ActionController with the intention of bringing ActionMailer on board at a later date. This is because the server is supposed to be agnostic towards clients, only spitting out a JSON API.

Currently debugging Angular. Restangular seems to be a little troublesome concerning usage in factories.
