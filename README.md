To use this repo: clone, start up Redis and Postgres, run migrations. Make sure Postgres is version 9.3, the latest. If you're going to use Rails' development environment, replace the fake S3 access and secret access keys with real ones in carrierwave_init.rb.  The iOS app runs via Ionic, but it hasn't been built yet. After the web client is done, it should be a really fast build for iOS, Android, and Windows Phone thanks to Ionic. The client is launched via `grunt serve`.Read the Readme.rdoc raw for more details on the server and how it works. And thanks to https://github.com/davidcelis for some Redis wisdom!
