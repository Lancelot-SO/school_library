require_relative 'person'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'

class App
  def initialize
    @classrooms = []
    @books = []
    @rentals = []
    @people = []
  end

  def create_person
    person_type = person_type_switch
    return if person_type.nil?

    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    person =
      case person_type
      when '1'
        print 'classroom: '
        classroom = gets.chomp
        print 'Has parent permission? [Y/N]: '
        parent_permission = gets.chomp
        parent_permission = parent_permission.downcase == 'y'
        classroom = Classroom.new(classroom)
        Student.new(classroom, age, name, parent_permission: parent_permission)
      when '2'
        print 'Specialization: '
        specialization = gets.chomp

        Teacher.new(age, specialization, name)
      end

    @people << person
    puts 'Person created successfully'
  end

  def person_type_switch
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    if person_type != '1' && person_type != '2'
      puts 'Invalid option'
      return
    end
    person_type
  end

  def create_rental
    create_rental_book
    book_index = gets.chomp.to_i
    puts
    create_rental_person
    person_index = gets.chomp.to_i
    puts
    print 'Date: '
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def create_rental_book
    if @books.empty?
      puts 'There are no books in the library to rent'
      return
    end
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
    end
  end

  def create_rental_person
    puts 'Select a person from the following list by number (not id)'
    if @people.empty?
      puts 'There are no people in the library'
      return
    end

    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" if rental.person.id == id
    end
  end

  def list_books
    @books.each do |book|
      puts "Title: '#{book.title}', Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created successfully'
  end
end
