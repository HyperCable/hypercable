# Hypercable Analytics

Hypercable Analytics is a fully featured high performance scalable, open source, standalone deployable alternative to Google Analytics, build with timescaledb openresty redis and rails.


## local setup

* env: cp .env.example.docker .env
* build: docker-compose build
* start: docker-compose up
* stop: docker-compose stop
* add migration: docker-compose run rails rails g migration xxx
* run migration: docker-compose run rails rake db:migrate
* collcetor location: http://localhost:8000
* open http://localhost:3333


## production setup

* git clone 
* edit .env.production
* docker-compose -f docker-compose.production.yaml run rails  rake db:migrate
* docker-compose -f docker-compose.production.yaml up -d
* git pull && docker-compose -f docker-compose.production.yaml pull
* docker-compose -f docker-compose.production.yaml logs --tail="all"

## demo site

* https://learnsql.io （Note: demo project, data will be cleared later）
* https://hackershare.dev (site with hypercable analytics tracker installed)
