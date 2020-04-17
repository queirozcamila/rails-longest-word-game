require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters_array = Array.new(9) { ('A'..'Z').to_a.sample }
    @letters = @letters_array.join(" ")
  end

  def score
    @found = word_validation(params[:word])
    @check = letter_check(params[:word], params[:letters].split)
  end

  def word_validation(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    return json["found"]
  end

  def letter_check(word, grid)
    array_to_check = []
    word.upcase.chars.each do |letter|
      array_to_check << grid.include?(letter)
    end
    if array_to_check.include?(false)
      false
    else
      true
    end
  end
end
