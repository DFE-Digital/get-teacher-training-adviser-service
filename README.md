# DFE-Digital Get An Adviser Service

![Build and Deploy](https://github.com/DFE-Digital/get-teacher-training-adviser-service/workflows/Build%20and%20Deploy/badge.svg)

![Release to test](https://github.com/DFE-Digital/get-teacher-training-adviser-service/workflows/Release%20to%20test/badge.svg)

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=get-teacher-training-adviser-service&metric=alert_status)](https://sonarcloud.io/dashboard?id=get-teacher-training-adviser-service)

## Prerequisites

- Ruby 2.7.5
- NodeJS 12.16.x
- Yarn 1.12.x
- Redis

## Setting up the app in development

1. Run `bundle install` to install the gem dependencies
2. Run `yarn` to install node dependencies
3. Run `rails db:setup` to setup the database.
4. Run `bundle exec rails server` to launch the app on http://localhost:3000
5. (optional) Run `./bin/webpack-dev-server` in a separate shell for faster compilation of assets

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

### Contract tests

> :warning: **Development of the contract tests is currently in-progress**

We use a variation of 'contract testing' to achieve end-to-end integration tests across all services (Get an Adviser -> API -> CRM).

The general idea is that Capybara 'contract' tests in the Get an Adviser service perform various sign up scenarios and create a snapshot of the request payload that would be sent to the API. We commit these snapshots with our code and - if a change to the application results in a different snapshot - then the contract test will fail (the idea being you commit the updated snapshot, assuming the change is expected).

The API also has a set of contract tests that use the Get an Adviser payload snapshots as the test fixtures. These tests result in another set of request snapshots for the payloads sent to the CRM (which serve as the fixtures to the CRM contract tests).

A difficulty with these tests is ensuring that the services all have a consistent, global view of the service data state prior to executing the contract tests. We currently maintain the service data in `contracts/data` (to be centralised in a GitHub repospitory, but currently duplicated in each service).

Eventually, the `contracts/output` will be 'published' to a separate GitHub repository, which will enable other services to pull in their test fixtures from the upstream service. This will enable us to develop features in each service independently and publish only when the change is ready to be reflected in another service.

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

Setting `http_auth` in the Rails credentials enables site wide password protection (in the format `http_auth: username1=password1,username2=password2,...`). The authenticated `username` will also be set in the `session` so that we can scope certain actions to certain credentials (the same username can have multiple passwords).

## DevOps

### Docker

The built docker container will be stored on the [Docker Hub](https://hub.docker.com/repository/docker/dfedigital/accessibility_crawler)

### OWASP Scanning

On deployment to the development environment the web url is scanned using [ZAP Scanner](https://github.com/marketplace/actions/owasp-zap-full-scan). The scanner is controlled by a rules file stored in .zap/rules.tsv. Ideally there should be no rules supressed but intially it has been agreed to resolve them at a slower pace. The scanner will produce an artifact in the output of the running action (zap_scan.zip), by downloading this file and reading the contents it is possible to see what vulnerabilities have beeen detected.
The following rules have been added:

- 10038 IGNORE (Content Security Policy (CSP) Header Not Set)
- 10063 IGNORE (Feature Policy Header Not Set)
- 40025 IGNORE (Proxy Disclosure)
- 90022 IGNORE (500 Internal Server Error)

### Accessibility Scanning

The [Scanner](https://github.com/DFE-Digital/accessibility-scanner) is employed to provide Accessibility Scanning within the pipeline.

### CVE Scanning

The [Anchore Scanner](https://github.com/anchore/scan-action) will carry out CVE testing on the docker container.
