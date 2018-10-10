require_relative "../lib/api_refactored.rb"
require_relative "../lib/command_line_interface.rb"

welcome
character = get_character_from_user
get_character_movies_from_api(character)
get_film_hash(character)
show_character_movies(character)
