require 'sinatra'
require '../foo-tickets-web/models/ticket'

enable :sessions

INVALID_LOGIN = 'Login incorrect.'

@@total_items_in_cart = 0
@@tickets = {}

get '/footix' do
  erb :login
end

post '/footix/login' do

  VALID_PASSWORD = 'password'

  if VALID_PASSWORD == params[:password].downcase
    redirect to '/footix/authorized?username='+params[:username].downcase
  else
    redirect to '/footix/unauthorized'
  end

end

get '/footix/authorized' do
	
  @@tickets = {}
  @@tickets = data_mock
  @@tickets.each do |key, value |
    a_ticket = value
    puts a_ticket.artist + '/' + a_ticket.seat
  end

  #put the ticket hash in the session
  session.clear
  session[:tickets] ||= @@tickets		
	
  redirect to '/footix/ticket_list?username='+params[:username]
end

get '/footix/unauthorized' do
  @errmsg = INVALID_LOGIN
  erb :login
end

get '/footix/ticket_list' do
  @username = params[:username].capitalize
  erb :ticket_list
end

get '/footix/ticket_buy' do
  @artist = params[:artist]
  @venue = params[:venue]
  @seat = params[:seat]
  @price = params[:price]
  @nbr = params[:nbr]

  erb :ticket_buy
end

get '/footix/load' do

  @@tickets = {}
  @@tickets = data_mock
  @@tickets.each do |key, value |
    a_ticket = value
    puts a_ticket.artist + '/' + a_ticket.seat
  end

  #put the ticket hash in the session
  session.clear
  session[:tickets] ||= @@tickets

  'Number of tickets created: ' + @@tickets.length.to_s + '<br /><br /><a href="/footix">Click here to go to login page</a>'

end

post '/footix/process_buy' do
  @nbr = params[:nbr]
  puts 'cc_nbr=' +params[:cc_nbr]

    @@tickets = session[:tickets]
    @@tickets.delete(Integer(@nbr))
    session.clear
    session[:tickets] ||= @@tickets

    erb :ticket_list
end

def data_mock

  mock_tix = {}

  ticket = Ticket.new(1, 'The Cure','HP Pavilion','Section 1, Row 1, Seat 01', 250)
  mock_tix[1] = ticket
  ticket = Ticket.new(2, 'The Cure','HP Pavilion','Section 10, Row 9, Seat 17', 75)
  mock_tix[2] = ticket
  ticket = Ticket.new(3, 'The Smiths','Cafe Du Nord','General Admission', 100)
  mock_tix[3] = ticket
  ticket = Ticket.new(4, 'The Smiths','Cafe Du Nord','VIP', 200)
  mock_tix[4] = ticket
  ticket = Ticket.new(5, 'M83','Regency Ballroom','General Admission', 35)
  mock_tix[5] = ticket
  ticket = Ticket.new(6, 'Chvrches','Mountain Winery','Section 1, Row J, Seat 11', 45)
  mock_tix[6] = ticket
  ticket = Ticket.new(7, 'Chvrches','Mountain Winery','Section 5, Row A, Seat 08', 15)
  mock_tix[7] = ticket
  ticket = Ticket.new(8, 'Feet Like Modern People','Oakland Arena','Section 1, Row 1, Seat 05', 180)
  mock_tix[8] = ticket
  ticket = Ticket.new(9, 'Feet Like Modern People','Oakland Arena','Section 2, Row 7, Seat 15', 90)
  mock_tix[9] = ticket
  ticket = Ticket.new(10, 'Feet Like Modern People','Oakland Arena','Section 3, Row 3, Seat 7', 60)
  mock_tix[10] = ticket
  ticket = Ticket.new(11, 'Feet Like Modern People','Oakland Arena','Section 4, Row 11, Seat 9', 30)
  mock_tix[11] = ticket
  ticket = Ticket.new(12, 'Edible Insects','Shoreline Ampitheater','Section 11, Row G, Seat 17', 15)
  mock_tix[12] = ticket
  mock_tix

end

#404 catcher
not_found do
  halt 404, 'Error 404 - this page has moved on, so should you.'
end