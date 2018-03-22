require('pry')
require_relative('models/movie')
require_relative('models/star')
require_relative('models/casting')

star_options_hash1 = {'first_name'=>'Taka', 'last_name'=>'Waititi'}

star1 = Star.new(star_options_hash1)
star1.save()

movies_options_hash1 = {'title'=>'Hunt for Wilderpeople', 'genre'=>'comedy', 'rating'=>8, 'budget'=>'100000'}

movie1 = Movie.new(movies_options_hash1)
movie1.save()

# puts "All movies"
# p Movie.all()
# puts ""
#
# puts "All stars"
# p Star.all()
# puts ""
#
puts "Update star"
star1.first_name = 'Taika'
star1.update()
p Star.all()
puts ""

puts "Update movie"
movie1.title = 'Hunt for the Wilderpeople'
movie1.update()
p Movie.all()
puts ""
#
# puts "Delete all movies"
# Movie.delete_all()
# p Movie.all()
# puts ""
#
# puts "Delete all stars"
# Star.delete_all()
# p Star.all()
# puts ""

#Create new records
# star1.save()
star_options_hash2 = {'first_name'=>'Cate', 'last_name'=>'Blanchett'}

star2 = Star.new(star_options_hash2)
star2.save()
#
# # movie1.save()
movies_options_hash2 = {'title'=>'Thor Ragnarok', 'genre'=>'action', 'rating'=>8, 'budget'=>'100000'}

movie2 = Movie.new(movies_options_hash2)
movie2.save()

# puts "Display new stars/movies"
# p Star.all()
# puts ""
# p Movie.all()
# puts ""


# puts "Delete single star/movie"
# star2.delete()
# movie2.delete()
# p Star.all()
# puts ""
# p Movie.all()
# puts ""

casting1 = Casting.new({'movie_id'=> movie1.id, 'star_id'=>star1.id, 'fee'=>'20000'})
casting2 = Casting.new({'movie_id'=>movie2.id, 'star_id'=>star2.id, 'fee'=>'50000'})
casting3 = Casting.new({'movie_id'=> movie2.id, 'star_id'=> star1.id, 'fee'=>'30000'})
casting1.save()
casting2.save()
casting3.save()



puts "Display castings"
p Casting.all()
puts ""

puts "All stars from movie2"
p movie2.all_stars()
puts ""
puts "All movies starring star1"
p star1.all_movies()

# puts "Update casting1"
# casting1.fees = '30000'
# casting1.update()
# p Casting.all()
# puts ""
#
# puts "Delete casting1"
# casting1.delete()
# p Casting.all()
# puts ""
#
# puts "Delete all castings"
# casting1.save()
# Casting.delete_all()
# p Casting.all()
# puts ""
puts ""
puts "Remaining budget for Thor"
p movie2.remaining_budget()

p movie1.remaining_budget()
