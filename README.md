# Sample App for PaaS verification

## Components

- websocket

## Setup

```
$ yarn install
$ bundle install
$ bin/rails db:create
$ bin/rails db:schema:load
$ forman start -f Procfile.local
```

## Check GraphQL definitions

```
bin/rails runner 'puts ApplicationSchema.to_definition'
```
