require "net/http"
require "uri"
require "nokogiri"
require "Qt4"
require "date"

slots 'button_refresh()'

class Current_Value

	def update_val(val_name_old)
		uri = URI.parse("https://www.cbr-xml-daily.ru/daily_eng.xml")
		response = Net::HTTP.get_response(uri)

		doc = Nokogiri::XML(response.body)

		xpath_attr = doc.xpath('ValCurs').xpath('Valute')
		@@Valute_Count = xpath_attr.count-1
		@@Int_Iter = 0
		val_array = Array.new(1)
		while @@Int_Iter <= @@Valute_Count
			val_Name = xpath_attr[@@Int_Iter].xpath('Name').text()
			if val_Name == val_name_old
				city_Name = val_Name
				cur_val = xpath_attr[@@Int_Iter].xpath('Value').text()
				val_array[0] = "Для валюты "+city_Name+" текущий курс равен: "+cur_val.to_s+"\n"
			end
			@@Int_Iter = @@Int_Iter+1
		end
		@@currentValue = val_array[0]
	end

  def open_main_window()

    txt_val = @@currentValue

    Qt::Application.new(ARGV) do
    Qt::Widget.new do

      self.window_title = "Актуальный курс"

      button = Qt::PushButton.new('Закрыть') do
         connect(SIGNAL :clicked){Qt::Application.instance.quit}
      end

			button_refresh = Qt::PushButton.new('Обновить') do
					connect(SIGNAL('clicked()'),self, SLOT('button_refresh()'))
			end

      label = Qt::Label.new(txt_val)
      label_time = Qt::Label.new(DateTime.now.strftime "%d/%m/%Y %H:%M")

      self.layout = Qt::VBoxLayout.new do
        add_widget(label_time, 0, Qt::AlignLeft)
        add_widget(label, 0, Qt::AlignCenter)
				add_widget(button_refresh, 0, Qt::AlignCenter)
        add_widget(button, 0, Qt::AlignCenter)
      end
      setWindowOpacity(0.8)
      show

     end
     exec
    end
  end

 	def button_refresh()
			puts "Привет"
	end

end

main_class_window = Current_Value.new
main_class_window.update_val('US Dollar')
main_class_window.open_main_window()
