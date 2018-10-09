require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_urls_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  films_array = []
  response_hash["results"].each do |char|
    if char["name"].downcase == character
      films_array = char["films"]
    end
  end
  films_array
end

def get_film_info(films_array)
  film_hashes = []
  films_array.each do |url|
    dirty_hash = RestClient.get(url)
    film_hash = JSON.parse(dirty_hash)
    film_hashes << film_hash
  end
  film_hashes
end

def print_movies(film_hashes)
  film_hashes.each do |hash|
    puts hash["title"]
  end
end

def show_character_movies(character)
  urls = get_character_movies_urls_from_api(character)
  film_info = get_film_info(urls)
  print_movies(film_info)
end
