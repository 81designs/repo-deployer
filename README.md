# Repo Deployer

[![Code Climate](https://codeclimate.com/github/81designs/repo-deployer.png)](https://codeclimate.com/github/81designs/repo-deployer)

An automated test and deployment server built on Rails 4.

## Running Locally

In order to use the GitHub web hooks, we need to be able
to access our local server from an https address. We're
using [ngrok](http://ngrok.com) to accomplish this. You'll
want to sign up for an account so you can reserve a subdomain.

Here's an example `~/.ngrok` config file:

```
auth_token: mytokengoeshere
tunnels:
  web:
    subdomain: mysubdomain
    proto:
      https: 3000
```

With this config, we can start the tunnel with the command:

```bash
$ ngrok start web
```

Which will point `https://mysubdomain.ngrok.com` to `localhost:3000`.

## Required Environment Variables

```ruby
ENV['GITHUB_KEY']
ENV['GITHUB_SECRET']
ENV['HEROKU_OAUTH_ID']
ENV['HEROKU_OAUTH_SECRET']
ENV['SECRET_KEY']
```

### GitHub Variables

Register a new GitHub application: 

<https://github.com/settings/applications/new>

### Heroku Variables

Register a new Heroku API Client:

<https://dashboard.heroku.com/account>

### Secret Key Variable

This is used to set the application's secret key while keeping it out of the repo.

```ruby
# config/initializers/secret_token.rb
RepoDeployer::Application.config.secret_key_base = ENV['SECRET_KEY']
```

