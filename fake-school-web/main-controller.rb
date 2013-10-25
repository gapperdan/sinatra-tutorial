require 'sinatra'

#http://localhost:4567

get '/' do
  erb :login
end

post '/' do

  VALID_USERS = ['Obi Wan','Yoda','Anakin']
  VALID_PASSWORD = 'force'

  puts params[:userid]

  if VALID_USERS.include? params[:userid] and VALID_PASSWORD == params[:password]

  #if params[:userid] == 'Yoda' || 'Anakin' || 'Obi Wan'
    #redirect to('/master?userid='+params[:userid])
    redirect to '/authorized?userid='+params[:userid]
  else
    redirect to '/unauthorized'
  end

end

get '/master' do
  "You are a Jedi Master"
end

get '/authorized' do
  "Valid login"
  "Userid="+params[:userid]

end

get '/unauthorized' do
  "Invalid login"
end

#404 catcher
not_found do
  halt 404, 'This page has moved on, so should you.'
end
