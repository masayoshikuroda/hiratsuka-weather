require 'uri'
require 'open-uri'
require 'rexml/document'

class Geocoding
  attr_reader :version, :address, :lng, :lat

  BASE_URL = 'https://www.geocoding.jp/api'

  def initialize(q)
    url = getUrl(q)
    xml = open(url) do |f| f.read end
    #puts xml
    doc = REXML::Document.new(xml)
    @version = REXML::XPath.first(doc, '/result/version').text 
    @address = REXML::XPath.first(doc, '/result/address').text
    @lng     = REXML::XPath.first(doc, '/result/coordinate/lng').text
    @lat     = REXML::XPath.first(doc, '/result/coordinate/lat').text
  end

  def getUrl(q)
   url = BASE_URL + '/?v1.2&q=' + q
   return URI.escape(url)
  end
end
