require 'rest-client'
require 'json'
require 'pry'

# NOTE: in this demonstration we name many of the variables _hash or _array.
# This is done for educational purposes. This is not typically done in code.


def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  response_hash.select do |x,y| # iterates through each portion of the initial hash to get to character data#
    if x == "results"
      y.each do |character_data|
        if character_data["name"].downcase.include?(character)
          return character_data["films"]
        end
      end
    end
  end
end







  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def print_movies(films_hash)
  titles =[]
  films_hash.each do |site_url|
    response_string = RestClient.get(site_url)
    movie_hash = JSON.parse(response_string)
      titles << movie_hash["title"]
  end
  titles.each do |movie_title|
    puts movie_title # some iteration magic and puts out the movies in a nice list
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
