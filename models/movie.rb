require_relative("../db/sql_runner")

class Movie
  attr_accessor :title, :genre, :rating
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating']
  end

  def save()
    sql = "INSERT INTO movies
            (title, genre, rating)
            VALUES
            ($1, $2, $3)
            RETURNING id"
    values = [@title, @genre, @rating]

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
           SET(title, genre, rating) = ($1, $2, $3)
           WHERE id = $4"
    values = [@title, @genre, @rating, @id]
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


end
