Museum Tracker

Contributor(s):

Jessi Iler (https://github.com/InertialObserver)

Date: Started June 12th, 2015

Installation:

Build database in Postgres:

# psql
username=# CREATE DATABASE museum_tracker;
username=# \c museum_tracker;
museum_tracker=# CREATE TABLE museums (id serial PRIMARY KEY, name varchar, location varchar);
museum_tracker=# CREATE TABLE artworks (id serial PRIMARY KEY, name varchar, artist varchar, museum_id int);
museum_tracker=# \c Guest
username=# CREATE DATABASE museum_tracker_test WITH TEMPLATE museum_tracker;

Clone git repo

Retrieve the included Gemfile and Run the following command:

bundle install

Usage

To use the app:

Run ruby app.rb Navigate in your browser to localhost:4567 and enjoy!!

Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

Known Bugs


LICENSE

MIT License. Copyright 2015
