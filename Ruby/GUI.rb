require "net/http"
require "uri"
require "nokogiri"
require "Qt4"
require "date"

uri = URI.parse("https://www.cbr-xml-daily.ru/daily_eng.xml")
response = Net::HTTP.get_response(uri)

doc = Nokogiri::XML(response.body)

xpath_attr = doc.xpath('ValCurs').xpath('Valute')
Valute_Count = xpath_attr.count-1
Int_Iter = 0
val_array = Array.new(1)
while Int_Iter <= Valute_Count
	val_Name = xpath_attr[Int_Iter].xpath('Name').text()
	if val_Name == "US Dollar" then
		city_Name = val_Name
		cur_val = xpath_attr[Int_Iter].xpath('Value').text()
		val_array[0] = "Для валюты "+city_Name+" текущий курс равен: "+cur_val.to_s+"\n"
	end
	Int_Iter+=1
end
txt_val = val_array[0]

Qt::Application.new(ARGV) do
	Qt::Widget.new do
	
		self.window_title = "Актуальный курс валют"
					
		button = Qt::PushButton.new('Закрыть') do
			connect(SIGNAL :clicked){Qt::Application.instance.quit}
		end
		
		label = Qt::Label.new(txt_val)
		label_time = Qt::Label.new(DateTime.now.strftime "%d/%m/%Y %H:%M")
		
		self.layout = Qt::VBoxLayout.new do
			add_widget(label_time, 0, Qt::AlignLeft)
			add_widget(label, 0, Qt::AlignCenter)
			add_widget(button, 0, Qt::AlignCenter)
		end
		setWindowOpacity(0.8)
		show
		
	end	
	exec
end
