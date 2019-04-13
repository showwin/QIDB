#!/bin/bash

source ~/.bashrc
cd /app
bundle install

# remove pid file
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

#bundle exec unicorn -p 3000
bundle exec rails s -b 0.0.0.0
