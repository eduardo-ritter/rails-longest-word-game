require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(15) { ('A'..'Z').to_a.sample }
  end

  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  def included?(guess, grid); end

  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  def score
    # CALCULAR O TEMPO TOTAL
    @total_time = Time.now - params[:start_time].to_time
    # DEFINIR VARIAVEL DA RESPOSTA DO USUARIO
    attempt = params[:answer]
    # VERIFICAR SE AS LETRAS UTILIZADAS ESTAO DENTRO DO ARRAY DISPONIVEL
    @answer_verification = true
    # attempt.chars.all? { |letter| attempt.count(letter) <= @letters.count(letter) }
    # VERIFICAR SE A PALAVRA UTILIZADA PERTENCE AO DICIONARIO
    response = open("https://wagon-dictionary.herokuapp.com/#{attempt}")
    json = JSON.parse(response.read)
    @dictionary_verification = json['found']
    # CALCULAR O SCORE FINAL
    @total_score = if @answer_verification
                     if @dictionary_verification
                       10
                     else
                       0
                     end
                   else
                     0
                   end
  end
end
