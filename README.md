# Hypercable Web

Web for hypercable analytics.


## local setup

* build: docker-compose build
* start: docker-compose up
* stop: docker-compose stop
* add migration: docker-compose run rails rails g migration xxx
* run migration: docker-compose run rails rake db:migrate