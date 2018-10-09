require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  character_name = response_hash["results"].find do |key|
    key["name"].downcase == character
  end
  films_url = character_name["films"]
  film_info_hash = films_url.map do |film|
    films_info = RestClient.get(film)
    films_hash = JSON.parse(films_info)
  end

  film_info_hash
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |films|
    puts films["title"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character) #array of hashes
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
