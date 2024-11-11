require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("a".."z").to_a.sample }
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    url = "https://dictionary.lewagon.com/#{@answer}"
    serialized_word = URI.open(url).read
    result = JSON.parse(serialized_word)
    grid = @answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
    @score = 0
    if !grid && result["found"] == false
      @return = "The word is not a valid English word and cannot be formed from the original grid. ❌"
      @score += 0
    elsif !grid
      @return = "The word is a valid English word but cannot be formed from the original grid.  ❌"
      @score += 0
    elsif result["found"] == false
      @return = "The word is valid according to the grid, but it is not a valid English word.  ❌"
      @score += 0
    else
      @return = "The word is valid according to the grid and is a valid English word. ✅"
      @score += 100
    end
  end
end
