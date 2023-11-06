# Test ATask


### Status
![development](https://github.com/SunDi3yansyah/atask/actions/workflows/workflow.yml/badge.svg?branch=development)


### Postman
[![Run in Postman](https://run.pstmn.io/button.svg)](https://documenter.getpostman.com/view/920672/2s9YXfc4GF)


### Tech Stack

- You can see on [Gemfile](Gemfile)


### Requirements

- Ruby
- PostgreSQL


### Setup

#### Quick Setup / Re-Setup:
```
rails db:drop db:create db:migrate
```

#### Development Environment:
```bash
bundle install --without production
```

#### Test Environment:
```bash
bundle install --without development production
```

#### Production Environment:
```bash
bundle install --deployment --without development test
```

#### Run Test with RSpec
```
rspec
```

#### Run Web Server with Puma
```
rails s
```
