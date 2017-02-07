require 'sinatra'
require 'sinatra/reloader'


get '/' do
  rand_number = rand(100)
  erb :index, :locals => {:number => rand_number}
end
