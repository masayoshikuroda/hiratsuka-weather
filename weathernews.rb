require 'nokogiri'
require 'net/http'
require 'open-uri'

class WeatherNews
  attr_reader :title, :time, :tenki
  attr_reader :temp, :unit
  attr_reader :humid, :press, :wind
  attr_reader :sunrise, :sunset

  BASE_URL = 'http://weathernews.jp/onebox'

  def initialize(lon, lat)
    @lon = lon
    @lat = lat
    @temp = 'c'
    @lang = 'ja'

    url = getUrl()
    html = open(url) do |f| f.read end
    page = Nokogiri::HTML.parse(html, nil, 'UTF-8')

    @title = page.css("p.tit-01")[0].text
    cont = page.css("div.weather-now__cont")
    @time = cont.css('p').inner_text
    ul = cont.css("ul.weather-now__ul")
    @tenki = ul.css("li")[0].text.slice(2..10)
    @temp  = ul.css("li")[1].text.slice(2..10)
    @humid = ul.css("li")[2].text.slice(2..10)
    @press = ul.css("li")[3].text.slice(2..10)
    @wind  = ul.css("li")[4].text.slice(2..10)
    sun = ul.css("li")[5].inner_text.strip
    @sunrise  = sun.split("|")[0].strip.slice(4..8).strip
    @sunset   = sun.split("|")[1].strip.slice(5..9).strip
   end

  def getUrl()
    return "#{BASE_URL}/%.6f/%.6f/temp=#{@temp}&lang=#{@lang}" % [@lon, @lat]
  end
end

if $0 == __FILE__ then
  lng = 139.35
  lat = 35.33
  wn = WeatherNews.new(lat, lng)
  puts wn.getUrl()
  puts wn.title
  puts wn.time, wn.tenki
  puts wn.temp, wn.humid, wn.press
  puts wn.wind
  puts wn.sunrise, wn.sunset
end
