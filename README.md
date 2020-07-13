# DFE-Digital Get Teacher Training Adviser Service

![Build and Deploy](https://github.com/DFE-Digital/get-teacher-training-adviser-service/workflows/Build%20and%20Deploy/badge.svg)

![Release to test](https://github.com/DFE-Digital/get-teacher-training-adviser-service/workflows/Release%20to%20test/badge.svg)

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=get-teacher-training-adviser-service&metric=alert_status)](https://sonarcloud.io/dashboard?id=get-teacher-training-adviser-service)

## Prerequisites

- Ruby 2.6.6
- NodeJS 12.16.x
- Yarn 1.12.x
- Redis

## Setting up the app in development

1. Run `bundle install` to install the gem dependencies
2. Run `yarn` to install node dependencies
3. Start Redis in alternate terminal, see below
4. Run `bundle exec rails server` to launch the app on http://localhost:3000
5. (optional) Run `./bin/webpack-dev-server` in a separate shell for faster compilation of assets

## Redis for session storage

1. Install redis, https://redis.io/documentation
2. Edit redis.conf file, e.g. /usr/local/redis.conf for maxmemory size and policy keys (allkeys-lru), https://redis.io/topics/lru-cache
3. Run `(sudo if required) redis-server` in alternate terminal window

## Whats included in this application?

- Rails 6.0 with Webpacker
- [GOV.UK Frontend](https://github.com/alphagov/govuk-frontend)
- RSpec
- Dotenv (managing environment variables)
- Dockerfile
- CI based on GitHub Actions
- Deployment utilising GovUK PAAS

## Running specs, linter(without auto correct) and annotate models and serializers

```
bundle exec rake
```

## Running specs

```
bundle exec rspec
```

## Linting

It's best to lint just your app directories and not those belonging to the framework, e.g.

```bash
bundle exec rubocop app config db lib spec Gemfile --format clang -a

or

bundle exec scss-lint app/webpacker/styles
```

You can automatically run the Ruby linter on commit for any changed files with
the following pre-commit hook `.git/hooks/pre-commit`.

```bash
#!/bin/sh
if [ "x$SKIPLINT" == "x" ]; then
    exec bundle exec rubocop $(git diff --cached --name-only --diff-filter=ACM | egrep '\.rb|\.feature|\.rake' | grep -v 'db/schema.rb') Gemfile
fi
```

## Configuration

### Environments

The application has 2 extra Rails environments, in addition to the default 3.

1. `development` - used for local development
2. `test` - used for running the test suites in an isolated manner
3. `production` - the 'live' production copy of the application
4. `rolling` - 'production-like' - continuously delivered, reflects current master
5. `preprod` - 'production-like' - stage before release to final production

**NOTE:** It is **important** if checking for the production environment to also
check for other 'production-like' environments unless you really intend to only
check for production, ie.

```ruby
if Rails.env.rolling? || Rails.env.preprod? || Rails
```

### Public Configuration

First its worth mentioning that all config from `production.rb` is inherited by
both `rolling.rb` and `preprod.rb` so separate configuration may not be required

Publicly visible Environment Variables can be added to the relevant `.env`
files for each environment

1. `/.env.production`
2. `/.env.rolling`
3. `/.env.preprod`

### Variables

`HTTPAUTH_USERNAME` and `HTTPAUTH_PASSWORD` - setting both enables site wide
password protection

## DevOps

### Docker
The built docker container will be stored on the [Docker Hub](https://hub.docker.com/repository/docker/dfedigital/accessibility_crawler)

### OWASP Scanning
On deployment to the development environment the web url is scanned using [ZAP Scanner](https://github.com/marketplace/actions/owasp-zap-full-scan). The scanner is controlled by a rules file stored in .zap/rules.tsv.   Ideally there should be no rules supressed but intially it has been agreed to resolve them at a slower pace. The scanner will produce an artifact in the output of the running action (zap_scan.zip), by downloading this file and reading the contents it is possible to see what vulnerabilities have beeen detected.
The following rules have been added:
- 10038	IGNORE	(Content Security Policy (CSP) Header Not Set)
- 10063	IGNORE	(Feature Policy Header Not Set)
- 40025	IGNORE	(Proxy Disclosure)

### Accessibility Scanning
The [Scanner](https://github.com/DFE-Digital/accessibility-scanner) is employed to provide Accessibility Scanning within the pipeline.

### CVE Scanning
The [Anchore Scanner](https://github.com/anchore/scan-action) will carry out CVE testing on the docker container. 
