# Installation

These instructions cover how to create a working development environment on OS X.

You will need a package manager.  At this time we recommend homebrew.  Install homebrew by following the recommendations here 
[http://brew.sh/](http://brew.sh/)

You will need to install git and clone a copy of this repository onto your local system.

You will need a working version of Ruby and PostgreSQL to run this application.  I recommend installing a version manager
for Ruby such as RVM. Instructions for install RVM are here [https://rvm.io/rvm/install](https://rvm.io/rvm/install)

Once you have installed RVM you'll need to open a new terminal session to enable it.  It's working correctly when you `cd` into the folder where you keep the voterguides repository, and you see the following message:

```
ruby-2.3.1 is not installed.
To install do: 'rvm install ruby-2.3.1'
```
So, then you do that.

Then you must change directories up and back in to activate your new ruby.

```
cd .. && cd -
```

Then install bundler.

```
gem install bundler
```

and use bundler to install the rest of your gems

```
bundle install
```

and install heroku CLI

[https://devcenter.heroku.com/articles/heroku-command-line](https://devcenter.heroku.com/articles/heroku-command-line)

and postgres

```
brew install postgres
```

You'll need to create your databases and migrate them with the following commands:

```
rails db:create
rails db:migrate
```

## Configuring your local environment

You'll want to copy the .env.example file in the root folder to a file names '.env' that will be used by the local development tools. This .env file should contain all keys for external services.

## Facebook login
If you'd like to test your local app against facebook login, you'll need to create keys at [https://developers.facebook.com/](https://developers.facebook.com/)	


## AWS Uploads
Uploads are stored in AWS.  If you don't configure AWS keys, guide uploads will not work.

## Recaptcha Keys
Users are verified before login by Google's recaptcha.  Get keys for that here:
[https://www.google.com/recaptcha](https://www.google.com/recaptcha)

## Starting the server

To start the server using the local environment configuration, use the heroku local command

```
heroku local
```

## Creating an admin user
To access the admin interface and edit all guides, users must have the admin privilege.
To make an existing user an admin, simply run the following task with the user's email address:

```
rails manage:declare_admin[yohan@example.com]
```

to do this on heroku, use the heroku CLI:

```
heroku run rails manage:declare_admin[yohan@example.com]
```



## Creating sample data

You may want to populate your system with some sample guides.  A task to do this is included:

```
rails sample_data:populate
```


# Developer Guide

## Testing

To run the tests, just use the standard command

```
rails test
```

## Dependencies

A full dependency listing can be found in the Gemfile.  Key libraries for this project include Bootstrap, ActiveAdmin, SimpleForm, OmniAuth, and CanCanCan.

## Updating a user password

If a (non-facebook) user has forgotten their password, you can generate a reset link for them via a task:

```
heroku run rails manage:reset_password[geraldo@example.com]
```

They can also request a password reset email via the web interface.


# Deployment

This system is built to deploy to heroku.  Deployment instructions are here [https://devcenter.heroku.com/articles/git](https://devcenter.heroku.com/articles/git)

Once you have created your heroku deploy, you can deploy using 

```
git push heroku
```

## Staging

We have a staging system for feature review before deploying to [www.localballot.us](https://www.localballot.us).  This system can be found at [voterguides-staging.herokuapp.com](https://voterguides-staging.herokuapp.com)

## Email Sending

This system uses AWS SES to send email from the localballot.us domain.  To avoid being tagged as spam, we put DKIM certificate information into the DNS record.  More information is here: [http://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-domains.html](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-domains.html)

As a result, this app can only send emails from the @localballot.us domain or another domain you have configured using the above process.  You must provide an unsubscribe link in each email to comply with AWS guidelines.

For local development, you may want to install [mailcatcher](https://mailcatcher.me/) to view emails sent by the app.

## SSL Certificate

Our SSL certificate is provided by [letsencrypt.org/](https://letsencrypt.org/) using the process detailed here: [http://collectiveidea.com/blog/archives/2016/01/12/lets-encrypt-with-a-rails-app-on-heroku/](http://collectiveidea.com/blog/archives/2016/01/12/lets-encrypt-with-a-rails-app-on-heroku/)

# License

This software is created and distributed under the [GPL 2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

