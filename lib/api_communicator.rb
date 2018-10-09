require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  character_name = response_hash["results"].find do |key|
    key["name"].downcase == character
  end #hash of info re: character
  films_url = character_name["films"] #films array of urls
#----
end

def get_film_hash(character)
  films_url = get_character_movies_from_api(character)
  film_info_hash = films_url.map do |film|
    films_info = RestClient.get(film)
    films_hash = JSON.parse(films_info)
  end
  film_info_hash
end

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  puts "Movies:"
  films_hash.each do |films|
    puts films["title"]
  end
end

def show_character_movies(character)
  films_array = get_film_hash(character) #array of hashes
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
