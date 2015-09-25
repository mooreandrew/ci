#!/bin/bash

apt-add-repository ppa:brightbox/ruby-ng
apt-get update
apt-get -y install ruby2.2 ruby2.2-dev

sudo apt-get -y install libpq-dev libsqlite3-dev

gem install bundler

cd /vagrant
bundle install
rake db:migrate
