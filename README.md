To use this repo: clone, start up Redis and Postgres, run migrations. Make sure Postgres is version 9.3, the latest. If you're going to use Rails' development environment, replace the fake S3 access and secret access keys with real ones in carrierwave_init.rb. Otherwise, it will work straight out of the box for Rails' test environment. For the client, change directory into the client/boltweb folder, run Bower & Grunt `install`, and fire up Angular with `grunt serve`. Make sure you have the Rails server running on port 3000. The iOS app runs via Ionic, but it hasn't been built yet. After the web client is done, it should be a really fast build for iOS, Android, and Windows Phone thanks to Ionic. Read the Readme.rdoc raw for more details on the server.



Updates:

The server is now running solely on the sub-frameworks ActiveRecord and ActionController with the intention of bringing ActionMailer on board at a later date. This is because the server is agnostic towards clients, only spitting out a JSON API.

Was almost successful at implementing Faye in Rails and Angular. Everything was working nicely, then I did something that started throwing some weird JS errors involving null databinding and insertBefore functions. I belive the problem started happening when I switched from Webrick to Thin. Sigh... unfortunately I will pull from my last push and wipe the errors along with the Faye progress.

The Rails/PG/Redis query response time are extraordinary. I'm clocking -on average- 3-4 ms response time from the SERVER for getting arrays of objects (users, posts, events, etc.). That's not the response time from just the databases, but for the entire backend. And I'm running a humble dual-core MacBook Air (2013). So happy right now.

It appears Heroku just added true support for websockets a week ago. Interesting...
