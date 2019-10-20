require "net/http"
require "uri"
require "nokogiri"

uri = URI.parse("https://www.cbr-xml-daily.ru/daily_eng.xml")
response = Net::HTTP.get_response(uri)

doc = Nokogiri::XML(response.body)

xpath_attr = doc.xpath('ValCurs').xpath('Valute')
Valute_Count = xpath_attr.count-1
Int_Iter = 0
val_array = Array.new(Valute_Count)
while Int_Iter <= Valute_Count

	city_Name = xpath_attr[Int_Iter].xpath('Name').text()
	cur_val = xpath_attr[Int_Iter].xpath('Value').text()
	
	val_array[Int_Iter] = "Для валюты "+city_Name+" текущий курс равен: "+cur_val.to_s
	
	Int_Iter+=1
end

for val_String in val_array
	puts val_String
end
