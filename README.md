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

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/fastruby/skunk.fyi](https://github.com/fastruby/skunk.fyi). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://github.com/fastruby/skunk.fyi/blob/main/CODE_OF_CONDUCT.md) code of conduct.

When Submitting a Pull Request:

* If your PR closes any open GitHub issues, please include `Closes #XXXX` in your comment

* Please include a summary of the change and which issue is fixed or which feature is introduced.

* If changes to the behavior are made, clearly describe what changes.

* If changes to the UI are made, please include screenshots of the before and after.

## Sponsorship

![FastRuby.io | Rails Upgrade Services](https://github.com/fastruby/skunk.fyi/raw/main/app/assets/images/fastruby-logo.png)


`Skunk.fyi` is maintained and funded by [FastRuby.io](https://fastruby.io). The names and logos for FastRuby.io are trademarks of The Lean Software Boutique LLC.
