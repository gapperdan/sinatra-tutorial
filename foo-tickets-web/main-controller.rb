require 'sinatra'
require '../foo-tickets-web/models/ticket'

INVALID_LOGIN = 'Login incorrect.'

@@total_items_in_cart = 0
@@tickets = {}


get '/footix' do
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
  redirect to '/ticket_list?username='+params[:username]
end

get '/unauthorized' do
  @errmsg = INVALID_LOGIN
  erb :login
end

get '/ticket_list' do
  @username = params[:username].capitalize

  @@tickets = data_mock

  #@@tickets.each do |key, value |
  #  a_ticket = value
  #  puts a_ticket.artist + '/' + a_ticket.seat
  #end

  erb :ticket_list
end

#404 catcher
not_found do
  halt 404, 'This page has moved on, so should you.'
end

def data_mock

  mock_tix = {}

  #create list of tix
  ticket = Ticket.new(1, 'The Cure','HP Pavilion','Section 1, Row 1, Seat 1', 250)
  mock_tix[1] = ticket
  ticket = Ticket.new(2, 'The Cure','HP Pavilion','Section 10, Row 9, Seat 17', 75)
  mock_tix[2] = ticket
  ticket = Ticket.new(3, 'The Smiths','Cafe Du Nord','General Admission', 900)
  mock_tix[3] = ticket
  ticket = Ticket.new(4, 'The Smiths','Cafe Du Nord','General Admission', 900)
  mock_tix[4] = ticket
  mock_tix

end