# Ahshok [![Build Status](https://img.shields.io/travis/unindented/ahshok-sinatra.svg)](http://travis-ci.org/unindented/ahshok-sinatra) ![Abandoned](https://img.shields.io/badge/status-abandoned-red.svg)

Small Sinatra app that masks Amazon associate links, so that when the client makes the following request:

```
GET /1937785491 HTTP/1.1
Host: ahshok.example.org
```

The server responds with:

```
HTTP/1.1 301 Moved Permanently
Location: http://www.amazon.com/Programming-Ruby-1-9-2-0-Programmers/dp/1937785491?tag=sometag-20
```

It can also serve the product image by adding `.jpg` to the URL:

```
GET /1937785491.jpg HTTP/1.1
Host: ahshok.example.org
```

The server responds with:

```
HTTP/1.1 301 Moved Permanently
Location: http://ecx.images-amazon.com/images/I/51grBo2vQuL._SL160_.jpg
```

## Installing

If you have `bundler` installed, just run:

```sh
bundle install
```

## Testing

To run the tests, run the default `rake` task:

```sh
rake
```

## Running locally

To run the app locally, you will need to declare some environment variables first.

You can do this two ways:

1. Modify the `config/config.yml` file.
2. Create a `.env` file with something similar to this:

```sh
DATABASE_URL=sqlite:db/app.db
AMAZON_TAG=realtag-20
AMAZON_KEY=REALACCESSKEYID
AMAZON_SECRET=REALSECRETACCESSKEY
```

Now you can start the app by executing:

```sh
foreman start
```

## Deploying to Heroku

To deploy to Heroku, first create an app:

```sh
heroku create --stack cedar <app name>
```

Then set the necessary environment variables:

```sh
heroku config:add \
  AMAZON_TAG=realtag-20 \
  AMAZON_KEY=REALACCESSKEYID \
  AMAZON_SECRET=REALSECRETACCESSKEY
```

And push the code:

```sh
git push heroku master
```

The app needs a database, but you can go with the shared one:

```sh
heroku addons:add shared-database
```

And the app will be ready to go!

## Meta

* Code: `git clone git://github.com/unindented/ahshok-sinatra.git`
* Home: <https://github.com/unindented/ahshok-sinatra/>

## Contributors

Daniel Perez Alvarez ([unindented@gmail.com](mailto:unindented@gmail.com))

## License

Copyright (c) 2013 Daniel Perez Alvarez ([unindented.org](https://unindented.org/)). This is free software, and may be redistributed under the terms specified in the LICENSE file.
