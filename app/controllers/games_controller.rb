require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(15) { ('A'..'Z').to_a.sample }
  end

  def score
    # CALCULAR O TEMPO TOTAL
    @total_time = Time.now - params[:start_time].to_time
    # DEFINIR VARIAVEL DA RESPOSTA DO USUARIO

    # raise
    @attempt = params[:answer].upcase.chars
    # VERIFICAR SE AS LETRAS UTILIZADAS ESTAO DENTRO DO ARRAY DISPONIVEL
    @answer_verification = @attempt.all? { |letter| @attempt.count(letter) <= params[:array].chars.count(letter) }
    # raise
    # VERIFICAR SE A PALAVRA UTILIZADA PERTENCE AO DICIONARIO
    response = open("https://wagon-dictionary.herokuapp.com/#{@attempt.join}")
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
