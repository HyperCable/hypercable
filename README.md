# Hypercable Web

Web for hypercable analytics.


## local setup

* env: cp .env.example.docker .env
* build: docker-compose build
* start: docker-compose up
* stop: docker-compose stop
* add migration: docker-compose run rails rails g migration xxx
* run migration: docker-compose run rails rake db:migrate
* open http://localhost:3333


## production setup

* git clone 
* edit .env.production
* docker-compose -f docker-compose.production.yaml run rails  rake db:migrate
* docker-compose -f docker-compose.production.yaml up -d
* git pull && docker-compose -f docker-compose.production.yaml pull
* docker-compose -f docker-compose.production.yaml logs --tail="all"
