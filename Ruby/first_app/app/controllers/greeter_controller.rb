class GreeterController < ApplicationController

  def hello
	randome_names = ["Мама","Папа","Доча"]
	@name = randome_names.sample
	@time = Time.now
	@times_displayed ||= 0
	@times_displayed += 1
  end
  
  #def goodbay
  #end
  
end
