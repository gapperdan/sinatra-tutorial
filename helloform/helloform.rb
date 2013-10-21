require 'sinatra'

#http://localhost:4567

get '/' do
  erb :form
end

post '/' do
  "You are logged in as: '#{params[:userid]}'"
end

#404 catcher
not_found do
  halt 404, 'This page has moved on, so should you.'
end
