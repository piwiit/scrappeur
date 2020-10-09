# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'
# require 'mechanize'

def open_url
  # Ouvrir l'URL souhaitée sous Nokogiri et le stocker dans un objet
  Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
end
@array_name = []
@array_price = []
@result = []

def crypto_name
  # recherche du nom de la valeur souhaiter nomé ici symbol : placé ensuite dans un tableau
  name = open_url.xpath('//td[contains(@class,"symbol")]')
  name.each do |v|
    @array_name << v.text
  end
  @array_name
end

def crypto_value
  # recherche des prix des noms demandé plus haut : placezr ensuite dans un tableau
  value = open_url.xpath('//td[contains(@class,"price")]')
  value.each do |price|
    # insertion du resultat dans un tableau et suppression des "$" et ","
    @array_price << price.text.delete('$,').to_f
  end
  @array_price
end

def final_result
  # Associer les 2 tableaux entre eux
  final_array = crypto_name.zip(crypto_value)
  # creation d'un hash par Noms / Valeurs pour tout les elment du tableau
  final_array.each do |n, v|
    my_hash = {}
    my_hash[n] = v
    # Insertion des dit element dans un dernier tableau final
    @result << my_hash
  end
  puts @result
  puts "result est bien un  #{@result.class}"
end
final_result
