require 'sinatra'

#http://localhost:4567

INVALID_LOGIN = 'Login incorrect.'

@@total_items_in_cart = 1

get '/foostore' do
  erb :login
end

post '/login' do

  VALID_PASSWORD = 'password'

  if VALID_PASSWORD == params[:password].downcase
    redirect to '/authorized?username='+params[:username].downcase
  else
    redirect to '/unauthorized'
  end

end

get '/authorized' do
  redirect to '/storefront?username='+params[:username]
end

get '/unauthorized' do
  @errmsg = INVALID_LOGIN
  erb :login
end

get '/storefront' do
  @username = params[:username].capitalize
  erb :storefront
end

#404 catcher
not_found do
  halt 404, 'This page has moved on, so should you.'
end