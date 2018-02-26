require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = generate_letters
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    @included = included?
    @english = english_word?
    @message = message
  end

  private

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?
     @word.chars.all? { |letter| @word.count(letter) <= @grid.count(letter) }
  end

  def generate_letters
    Array.new(8) { ('A'..'Z').to_a.sample }
  end

  def message
  if included?
    if english_word?
      "well done"
    else
      "not an english word"
    end
  else
    "not in the grid"
  end
end

end
