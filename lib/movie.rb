require 'pry'
class Movie
  attr_accessor :title, :release_date, :director, :summary
  @@all = []
  def initialize(title, date, director, summary)
    @title = title
    @release_date = date
    @director = director
    @summary = summary
    @@all << self
  end

  def url
    "#{@title.gsub(" ", "_").downcase}.html"
  end

  def self.reset_movies!
    @@all = []
  end

  def self.all
    @@all
  end

  def self.make_movies!
    movie_file = File.open("./spec/fixtures/movies.txt", "r") 
    movie_file.each_line do |line|
       data = line.split(" - ")
       # binding.pry
       Movie.new(data[0], data[1].to_i, data[2], data[3])
    end
  end
  def self.recent
    return_array = []
    @@all.map do |element|
      if element.release_date >= 2012
        return_array << element
      end
    end
    return_array
  end
   
  
end