def welcome
  puts "Welcome!"
end

def get_character_from_user
  puts "Please Enter a Star Wars Character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp!
end

def invalid_entry
  puts "Character does not exist.  Please enter a valid character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp!
end
