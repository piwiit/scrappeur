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
  name = open_url.xpath('//td[contains(@class,"symbol")]')
  name.each do |v|
    @array_name << v.text
  end
  @array_name
end

def crypto_value
  value = open_url.xpath('//td[contains(@class,"price")]')
  value.each do |price|
    @array_price << price.text.delete('$,').to_f
  end
  @array_price
end

def final_result
  final_array = crypto_name.zip(crypto_value)
  final_array.each do |n, v|
    my_hash = {}
    my_hash[n] = v
    @result << my_hash
  end
  puts @result
  puts "result est bien un  #{@result.class}"
end
final_result
