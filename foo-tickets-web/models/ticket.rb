class Ticket
  attr_accessor :artist, :venue, :seat, :price

  def initialize (nbr, artist, venue, seat, price)
    @nbr = nbr
    @artist = artist
    @venue = venue
    @seat = seat
    @price = price
  end

end