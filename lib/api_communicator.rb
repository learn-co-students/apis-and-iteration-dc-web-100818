require 'rest-client'
require 'json'
require 'pry'

LINK_TO_STAR_WARS_API = 'http://www.swapi.co/api/people/'

def get_char_url_array(hash, character)
  hash["results"].each do |character_hash|
    if character_hash["name"].downcase == character.downcase
      films_hash = character_hash["films"]
      return films_hash
    end
  end

  if films_hash.nil?
    character = get_character_from_user
  end
end

def api_caller(url)
  response = RestClient.get(url)
  json = JSON.parse(response)
  return json
end

def get_character_movies_from_api(character)
  #make the web request
  response_hash = api_caller(LINK_TO_STAR_WARS_API)

  films_hash = {}

  films_hash = get_char_url_array(response_hash, character)

  films_hash.collect! do |url|
    api_caller(url)
  end
end

def print_movies(films_hash)
  films_hash.each do |movie|
    puts "Movie Title: #{movie["title"]}"
    puts "Episode Number : #{movie["episode_id"]}"
    puts "Director: #{movie["director"]}"
    puts "*************\n"
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
