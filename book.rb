require_relative 'rental'
class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(person, date = Date.today, book = self)
    Rental.new(date, book, person)
    @rentals << self unless @rentals.include?(self)
  end
end
