require('pg')
require('sinatra')
require('sinatra/reloader')
require('./lib/museum')
require('./lib/artwork')

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "museum_tracker"})


get('/') do
  erb(:index)
end

get('/museums') do
  @museums = Museum.all
  erb(:museum)
end

post ('/museums') do
  name = params['name']
  location = params['location']
  @museum = Museum.new({ name: name, location: location, id: nil })
  if @museum.save
    redirect("/museums/".concat(@museum.id().to_s()))
  else
    erb(:museum)
  end
end
#
get("/museums/:id") do
  @museum = Museum.find(params.fetch("id").to_i)
  erb(:museum)
end

get('/artwork') do
  erb(:artwork)
end
