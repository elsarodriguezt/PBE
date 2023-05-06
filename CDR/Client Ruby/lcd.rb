require 'gtk3'
require 'i2c/drivers/lcd'

class LCD
	def inicialitzar
		@display=I2C::Drivers::LCD::Display.new('/dev/i2c-1',0x27)
		@files=4
		@columnes=20
		@display.clear
		@display.text("Introduce your ID:", 1)
	end
	
	def printNom(nom)
		#Neteja LCD
		@display.clear
		#Printem a la LCD
		@display.text("Welcome",1)
		@display.text(nom, 2)
	end
	
	def printInvalid
		@display.clear
		@display.text("UID",1)
		@display.text("INVALID",2)
	end
end
