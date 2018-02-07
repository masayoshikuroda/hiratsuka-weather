require "./weathernews.rb"

LON = 35.32783
LAT = 139.350645

wn = WeatherNews.new(LON, LAT)
message  = "現在の天気は" + wn.tenki + '。'
message += '気温' + wn.temp + '、'
message += '湿度' + wn.humid
message += 'です。'

puts '{'
puts '  "longitude": '   + LON.to_s + ','
puts '  "lattitude": '   + LAT.to_s + ','
puts '  "title": '       + wn.title + ','
puts '  "time": '        + wn.time  + ','
puts '  "weather": '     + wn.tenki + ','
puts '  "temperature": ' + wn.temp  + ',' 
puts '  "humidity": '    + wn.humid + ','
puts '  "pressure": '    + wn.press + ','
puts '  "wind": '        + wn.wind  + ','
puts '  "sunrise": '     + wn.sunrise + ','
puts '  "sunset": '      + wn.sunset
puts '  "message": '     + message
puts '}'

