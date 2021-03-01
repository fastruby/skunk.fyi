# skunk.fyi

This project is a place to share [skunk](https://github.com/fastruby/skunk) data for all your projects

## Getting Started

You can locally setup this Rails application by calling this command:

```
./bin/setup
```

## Environment Variables

You will be able to configure the application by changing the variables in the
`.env` file:

- ADMIN_USERNAME: Username for basic http authentication
- ADMIN_PASSWORD: Password for basic http authentication

## Submitting Data

In order to submit data to your local instance, you can do it like this:

```
SHARE_URL=http://localhost:3000 bundle exec skunk
```

## Start the server

Run the command:

```
rails s
```

If gems or node packages are missing, run:

```
bundle install
yarn install
```

## Sponsorship

![FastRuby.io | Rails Upgrade Services](https://github.com/fastruby/skunk.fyi/raw/main/app/assets/images/fastruby-logo.png)


`Skunk.fyi` is maintained and funded by [FastRuby.io](https://fastruby.io). The names and logos for FastRuby.io are trademarks of The Lean Software Boutique LLC.
