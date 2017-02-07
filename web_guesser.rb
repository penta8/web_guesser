require 'sinatra'
require 'sinatra/reloader'


SECRET_NUMBER = rand(100)
VALUES = {
  wtl: {message: 'Way Too low!', backcolor: 'red'},
  tl:  {message: 'Too low!', backcolor: '#ffcccc'},
  co:  {message: 'You got it right!<br>' \
       'The SECRET NUMBER is ' + SECRET_NUMBER.to_s,
        backcolor: 'green'},
  wth: {message: 'Way too high!', backcolor: 'red'},
  th:  {message: 'Too high!', backcolor: '#ffcccc'}
}

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)

  erb :index, :locals => {:number => SECRET_NUMBER,
                          :message => VALUES[message][:message],
                          :backcolor => VALUES[message][:backcolor]}
end

def check_guess(guess)
  puts SECRET_NUMBER
  if SECRET_NUMBER == guess
    :co
  elsif guess > SECRET_NUMBER
    if guess - SECRET_NUMBER > 5
      :wth
    else
      :th
    end
  elsif guess < SECRET_NUMBER
    if SECRET_NUMBER - guess > 5
      :wtl
    else
      :tl
    end
  end
end
