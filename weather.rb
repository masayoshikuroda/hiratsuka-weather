require_relative 'geocoding'
require_relative 'weathernews'

address = ARGV.length == 0 ? '平塚' : ARGV[0]
g = Geocoding.new(address)
wn = WeatherNews.new(g.lat, g.lng)
message  = "現在の天気は" + wn.tenki + '。'
message += '気温' + wn.temp + '、'
message += '湿度' + wn.humid
message += 'です。'

puts '{'
puts '  "address": '     + sprintf('"%s"', g.address)+ ','
puts '  "longitude": '   + g.lng.to_s + ','
puts '  "lattitude": '   + g.lat.to_s + ','
puts '  "title": '       + sprintf('"%s"', wn.title) + ','
puts '  "time": '        + sprintf('"%s"', wn.time)  + ','
puts '  "weather": '     + sprintf('"%s"', wn.tenki) + ','
puts '  "temperature": ' + sprintf('"%s"', wn.temp)  + ',' 
puts '  "humidity": '    + sprintf('"%s"', wn.humid) + ','
puts '  "pressure": '    + sprintf('"%s"', wn.press) + ','
puts '  "wind": '        + sprintf('"%s"', wn.wind)  + ','
puts '  "sunrise": '     + sprintf('"%s"', wn.sunrise) + ','
puts '  "sunset": '      + sprintf('"%s"', wn.sunset)  + ','
puts '  "iconurl": '     + sprintf('"%s"', wn.iconurl) + ','
puts '  "message": '     + sprintf('"%s"', message)
puts '}'

