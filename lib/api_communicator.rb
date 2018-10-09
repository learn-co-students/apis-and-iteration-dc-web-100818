require 'rest-client'
require 'json'
require 'pry'



# API Request from server, gets data about movies
def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
end
 
# Creates films array from the data pulled from the server
def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array, character)
end

# Accesses films link from films array (of hashes)
def print_movies(films_hash_array, character)
  films_link = nil
  films_hash_array["results"].each do |character_hash|
    if character_hash["name"].downcase == character.downcase
      films_link = character_hash["films"]
    end
  end 
  iterate_movies(films_link)
end

# iterates through film links and gets info from the server for them
def iterate_movies (films_link)
  parsed_films = []
  films_link.each do |link|
    response_films = RestClient.get(link)
    parsed_films << JSON.parse(response_films)
  end
  list_movies(parsed_films)
end

# gets movie titles and puts them to a list
def list_movies (parsed_films)
  movies = []
  parsed_films.each do |movie_hash|
    title = "Title #{movie_hash["title"]}"
    director = "Director #{movie_hash["director"]}"
    if director.nil?
      director = "N/A"
    end 
    puts title
    puts director
    puts "****************************"
    
  end
 
  
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

  
  # NOTE: in this demonstration we name many of the variables _hash or _array. 
  # This is done for educational purposes. This is not typically done in code.
    
  
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.