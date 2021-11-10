#!/bin/sh

set -x

# Remove a potentially pre-existing server.pid for Rails.
rm -rf /app/tmp/pids/server.pid
rm -rf /app/tmp/cache/*

bundle install

BUNDLE="bundle check"

until $BUNDLE
do
  sleep 2;
done

# Execute the main process of the container
exec "$@"
