require 'sinatra'

#http://localhost:4567

#sample route for root
get '/' do
  "Hello, world!"
end

#sample route for a path
get '/about' do
  'A little about me'
end

#sample route with params
get '/hello/:name/:color' do
  your_name = params[:name]
  your_color = params[:color]

  "Hello there, #{your_name} and your favorite color is, #{your_color}."

end

