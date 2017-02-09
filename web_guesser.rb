require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
VALUES = {
  wtl: { message: 'Way Too low!', backcolor: 'red' },
  tl:  { message: 'Too low!', backcolor: '#ffcccc' },
  co:  { message: 'You got it right!<br>' \
       'The SECRET NUMBER is ' + SECRET_NUMBER.to_s,
         backcolor: 'green' },
  wth: { message: 'Way too high!', backcolor: 'red' },
  th:  { message: 'Too high!', backcolor: '#ffcccc' }
}.freeze

new_game = '<br>A NEW NUMBER has been generated'
@@guesses = 6

get '/' do
  guess = params['guess'].to_i
  option = check_guess(guess)

  if params['cheat'] == 'true'
    message = 'The secret number is ' + SECRET_NUMBER.to_s
    backcolor = 'yellow'
  elsif guess == SECRET_NUMBER
    message = VALUES[:co][:message] + new_game
    backcolor = VALUES[:co][:backcolor]
    @@guesses = 6
  elsif @@guesses > 1
    message = VALUES[option][:message]
    backcolor = VALUES[option][:backcolor]
  elsif @@guesses == 1
    @@guesses = 6
    SECRET_NUMBER = rand(100)
    message = 'You have lost' + new_game
  end
  @@guesses -= 1

  erb :index, locals: { number: SECRET_NUMBER,
                        message: message,
                        backcolor: backcolor }
end

def check_guess(guess)
  puts SECRET_NUMBER
  if SECRET_NUMBER == guess
    :co
  elsif guess > SECRET_NUMBER
    guess - SECRET_NUMBER > 5 ? :wth : :th
  elsif guess < SECRET_NUMBER
    SECRET_NUMBER - guess > 5 ? :wtl : :tl
  end
end
