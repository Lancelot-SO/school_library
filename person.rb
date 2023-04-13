require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    super()
  end

  def correct_name
    name
  end

  def add_rental(person, date = Date.today, book = self)
    Rental.new(date, book, person)
    @rentals << self unless @rentals.include?(self)
  end

  attr_accessor :name, :age, :rentals
  attr_reader :id

  private

  def of_age?
    @age >= 18
  end

  def can_use_services?
    of_age? || @parent_permission
  end
end
