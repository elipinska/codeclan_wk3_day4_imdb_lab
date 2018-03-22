require_relative("../db/sql_runner")

class Movie
  attr_accessor :title, :genre, :rating, :budget
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating']
    @budget = options['budget'].to_i if options['budget']
  end

  def save()
    sql = "INSERT INTO movies
            (title, genre, rating, budget)
            VALUES
            ($1, $2, $3, $4)
            RETURNING id"
    values = [@title, @genre, @rating, @budget]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM movies"
    result = SqlRunner.run(sql)
    return Movie.map_items(result)
  end

  def self.map_items(movies_array)
    movies_array.map{|movie| Movie.new(movie)}
  end

  def update()
    sql = "UPDATE movies
           SET(title, genre, rating, budget) = ($1, $2, $3, $4)
           WHERE id = $5"
    values = [@title, @genre, @rating, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM movies
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def all_stars()
    sql = "SELECT stars.* FROM stars
    INNER JOIN castings
    ON stars.id = castings.star_id
    WHERE castings.movie_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Star.map_items(result)
  end

  #Add a budget to your movie model and create a method that will return the remaining budget once all a movie's star's fees have been taken into consideration!
  def remaining_budget()
    sql = "SELECT fee FROM castings
           WHERE movie_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    fees_array = result.map {|casting| Casting.new(casting).fees}
    fees = fees_array.inject(0){|sum, x| sum + x.to_i }
    return @budget - fees
  end

end
