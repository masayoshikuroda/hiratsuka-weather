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
    #puts url
    html = open(url) do |f| f.read end
    page = Nokogiri::HTML.parse(html, nil, 'UTF-8')

    @title = page.css("h1.title_now").inner_text
    elem = page.css("div.flex_radar.mb > div.obs_text")
    status = elem.css("div.text_box > span.sub").inner_text
    @time  = status.split(', ')[0]
    @tenki = status.split(', ')[1]
    @temp = elem.css("td.obs_temp > span.obs_temp_main").inner_text
    @temp +=  " " +  elem.css("td.obs_temp > span.obs_temp_sub").inner_text
    elems = elem.css("table.table-obs_sub > tr")
    @humid    = elems[0].css('td')[1].inner_text.split(":")[1].strip 
    @press    = elems[1].css('td')[1].inner_text.split(":")[1].strip
    @wind     = elems[2].css('td')[1].inner_text.split(":")[1].strip
    @sunrise  = elems[3].css("td")[1].inner_text.split(":")[1..2].join(":").strip
    @sunset   = elems[4].css("td")[1].inner_text.split(":")[1..2].join(":").strip
   end

  def getUrl()
    return "#{BASE_URL}/%.6f/%.6f/temp=#{@temp}&lang=#{@lang}" % [@lon, @lat]
  end
end
