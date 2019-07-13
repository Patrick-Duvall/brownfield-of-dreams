# Brownfield Of Dreams

Brownfield is Ruby on Rails application used to organize YouTube content used for online learning.

Brown Field of Dreams was modified by [Patrick Duvall](https://github.com/Patrick-Duvall) and [Trevor Nodland](https://github.com/tnodland) over two weeks off [This Repository](https://github.com/turingschool-examples/brownfield-of-dreams) using [This Project Board](https://github.com/turingschool-examples/brownfield-of-dreams/projects/1)

[You can visit a working version of the project here](https://brownfield-of-sorrow.herokuapp.com/)

**Learning Goals**

Through this project we learned

  * Working with an existing codebase
  * Making verified API calls
  * Consuming external APIs
  * Oauth 
  * Generating and sending Email data with Rails
  * Using enviromental variables to sanitize data

## Local Setup

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

The following API keys are needed in `app/config/application.yml`

  * [YOUTUBE_API_KEY](https://console.developers.google.com/apis/library?project=event-manager-230318&folder&organizationId)
  * [GITHUB_OAUTH_TOKEN](https://github.com/settings/developers) - Token for testing
  * [GITHUB_KEY](https://github.com/settings/tokens)
  * [GITHUB_SECRET](https://github.com/settings/tokens) 
  * [SENDGRID_USERNAME](https://sendgrid.com/docs/ui/account-and-settings/api-keys/)
  * [SENDGRID_PASSWORD](https://sendgrid.com/docs/ui/account-and-settings/api-keys/)
  
  Run `mailcatcher` and visit `localhost:1080` to check mail sending capabilities in development.

### Versions
* Ruby 2.4.1
* Rails 5.2.0
