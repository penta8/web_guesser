require 'sinatra'
require 'sinatra/reloader'


SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  backcolor = getColor(message)

  erb :index, :locals => {:number => SECRET_NUMBER,
                          :message => message,
                          :backcolor => backcolor}
end

def getColor(message)
  if message == 'Way too high!' || message == 'Way too low!'
    'red'
  elsif message == 'Too high!' || message == 'Too low!'
    '#ffcccc'
  else
    'green'
  end
end

def check_guess(guess)
  puts SECRET_NUMBER
  if SECRET_NUMBER == guess
    "You got it right!<br>" \
    "The SECRET NUMBER is " + SECRET_NUMBER.to_s
  elsif guess > SECRET_NUMBER
    if guess - SECRET_NUMBER > 5
      'Way too high!'
    else
      'Too high!'
    end
  elsif guess < SECRET_NUMBER
    if SECRET_NUMBER - guess > 5
      'Way too low!'
    else
      'Too low!'
    end
  end
end
