require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    if included?(@word, @letters)
      if english_word?(@word)
        @score = "Congratulations! #{@word} is a valid English word."
      else
        @score = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @score = "Sorry but #{@word} can't be bulti out of #{@letters}"
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
