require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.map do
      ('a'..'z').to_a.sample
    end
    @letters = @letters.sample(10)
    # @letters = ('a'..'z').to_a.sample(10) brings letters only once
  end

  def score
    word = params[:word].split('')
    letters = params[:letters].split

    url = "https://wagon-dictionary.herokuapp.com/#{word.join}"
    results_serialized = open(url).read
    results = JSON.parse(results_serialized)

    @result = if word.all? { |letter| !letters.include?(letter) }
                "Sorry, but [#{word.join}] cannot be built out of #{letters}."
              elsif word.all? { |letter| letters.include?(letter) }
                "Yes, [#{word.join}] can be built out of #{letters}, but it is NOT A WORD, you moron."
              else
                "Great, #{results[word]} is a valid word."
              end

    # @result = "The letters were:#{letters} and you used: #{word}"
  end
end
