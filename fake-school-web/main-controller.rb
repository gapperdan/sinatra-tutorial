require 'sinatra'

#http://localhost:4567

JEDI_MASTER = 'yoda'
JEDI_KNIGHT = 'obi wan'
JEDI_PADAWAN = 'anakin'

INVALID_LOGIN = 'The force is not with you, please try again.'

get '/' do
  erb :login
end

post '/' do

  VALID_USERS = ['obi wan','yoda','anakin']
  VALID_PASSWORD = 'force'

  puts params[:username].downcase

  if VALID_USERS.include? params[:username].downcase and VALID_PASSWORD == params[:password].downcase
    redirect to '/authorized?username='+params[:username].downcase
  else
    redirect to '/unauthorized'
  end

end

get '/authorized' do
  #this_user = params[:username]
  #"Valid login"
  #"Userid="+params[:username]

  case params[:username]
    when JEDI_MASTER
      redirect to '/master?username='+params[:username]
    when JEDI_KNIGHT
      redirect to '/knight?username='+params[:username]
    when JEDI_PADAWAN
      redirect to '/padawan?username='+params[:username]
  end
end

get '/unauthorized' do
  @errmsg = INVALID_LOGIN
  erb :login
end

get '/master' do
  @username = params[:username].capitalize
  erb :master
end

get '/knight' do
  @username = params[:username].capitalize
  erb :knight
end

get '/padawan' do
  @username = params[:username].capitalize
  erb :padawan
end


#404 catcher
not_found do
  halt 404, 'This page has moved on, so should you.'
end