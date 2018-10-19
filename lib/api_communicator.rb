require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  
  desired_films = []

  response_hash["results"].each do |hash|
    if character == hash["name"]
      desired_films = hash["films"]
    end 
  end 
    desired_films 
end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

def parse_character_movies(character)
    get_character_movies_from_api(character).collect do |film_name|
      film_resp_string = RestClient.get(film_name)
      JSON.parse(film_resp_string)
    end 
  response_hash["results"].each do |hash|
    if character == hash["name"]
      desired_films = hash["films"]
  end
end
  desired_films
end


def print_movies(character)
  parse_character_movies(character).collect do |hash_element|
  # some iteration magic and puts out the movies in a nice list
      "Movie Title: #{hash_element["title"]}"
    end 
  array_of_film_hashes = films_hash.collect do |film_name|
     film_resp_string = RestClient.get(film_name)
     JSON.parse(film_resp_string)
   end
  array_of_film_hashes.collect do |hash_element|
    "Movie Title: #{hash_element["title"]}"
    end
end


def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(character)
        
end
binding.pry
0

# BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
