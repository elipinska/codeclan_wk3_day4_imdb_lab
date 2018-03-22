require_relative("../db/sql_runner")


class Casting
  attr_accessor :movie_id, :star_id, :fees

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id']
    @star_id = options['star_id']
    @fees = options['fee']
  end

  def save()
    sql = "INSERT INTO castings
            (movie_id, star_id, fee)
            VALUES
            ($1, $2, $3)
            RETURNING id"
    values = [@movie_id, @star_id, @fees]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM castings"
    result = SqlRunner.run(sql)
    return Casting.map_items(result)
  end

  def self.map_items(castings_array)
    castings_array.map{|casting| Casting.new(casting)}
  end

  def update()
    sql = "UPDATE castings
           SET(movie_id, star_id, fee) = ($1, $2, $3)
           WHERE id = $4"
    values = [@movie_id, @star_id, @fees, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM castings
           WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end


end
