#Rails API Starter
[![Build Status](https://semaphoreci.com/api/v1/rahdio/rails-api-starter/branches/master/badge.svg)](https://semaphoreci.com/rahdio/rails-api-starter) [![Code Climate](https://codeclimate.com/github/rahdio/rails-api-starter/badges/gpa.svg)](https://codeclimate.com/github/rahdio/rails-api-starter) [![Test Coverage](https://codeclimate.com/github/rahdio/rails-api-starter/badges/coverage.svg)](https://codeclimate.com/github/rahdio/rails-api-starter/coverage)


Rails starter template for bootstrapping Rails API projects.

# How To Use
Firstly, you need to change the values of the development and test keys in secrets.yml. This file is accessible at `APP_ROOT/config/secrets.yml`

To generate new secret values run:

        $ bundle exec rake secret

You'd need to run this twice to generate replacements for both development and test keys in the secrets.yml file

Once secrets are changed, run:

        $ bundle install

This installs dependencies present in the Gemfile.


##User Authentication
User Authentication is handled through JSON web tokens. The authentication flow is as follows:
  1. Create an account
  2. Log into your account to obtain JSON web token
  3. Pass token in Authorization Header/Request Parameters for subsequent requests.
  4. Log out once done (optional)

An example of a token passed in with the Authorization Header is as follows:

  `Authorization: token <api-token>`

An example of a token passed in through request parameters is as follows:

  `GET /auth/logout?token=<api-token>`

where

  `<api-token>` in both cases should be replaced by actual token assigned
  

####Creating an Account
To create an account, you'll need to send in user attributes in JSON format. Required attributes to create an account are:

  `name`, `email`, `password`, `password_confirmation`

If arguments are incorrect, a message is returned stating which entry was incorrect

####Logging in with a valid Account
To log in to an account, you'll need to send in account attributes in JSON format. Required attributes to login to your account are:

  `email`, `password`  

A successful response to the Login request contains the JSON web token assigned, and its expiry date.

##API endpoints.

| EndPoint                                |   Functionality                      |
| --------------------------------------- | ------------------------------------:|
| POST /auth/login                        | Logs a user in                       |
| GET /auth/logout                        | Logs a user out                      |
| POST /users/new                         | Create a new user                    |

# Dependencies
User authentication is implemented with the JWT gem. For more information, see https://github.com/jwt/ruby-jwt for more information.

Service objects were implemented by extending the SimpleCommand gem. See https://github.com/nebulab/simple_command for more information.

Faker and FactoryGirlRails were used to generate random data/random models used while testing. See https://github.com/stympy/faker and https://github.com/thoughtbot/factory_girl_rails for more information.

# Tests

The default testing framework used is Minitest. To run all tests, run:

        $ bundle exec rake

## Contributing

1. Fork it by visiting - https://github.com/rahdio/rails-api-starter/fork

2. Create your feature branch

        $ git checkout -b new_feature
    
3. Contribute to code

4. Commit changes made

        $ git commit -a -m 'descriptive_message_about_change'
    
5. Push to branch created

        $ git push origin new_feature
    
6. Then, create a new Pull Request
