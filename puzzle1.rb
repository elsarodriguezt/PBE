require 'mfrc522' 
require 'securerandom'

class Rfid
	@@r = MFRC522.new
	def read_uid
		aux = 1;
		$stdout.flush
		while(aux==1) 
			begin
				@@r.picc_request(MFRC522::PICC_REQA)  #Establiment de perifèric
				uid_dec, a = @@r.picc_select          #Llegim. Si expira el timeout llançem l'error a la següent línia
			rescue CommunicationError => e            #Timeout			           
			else					   				  #Ja tenim el uid
				aux = 0			   
			end
		end
		hex = Array.new				           		  #Vector hexadecimal
		uid_dec.length.times do |i|
			hex[i]=uid_dec[i].to_s(16)
		end
		
		return hex.join().upcase			   		  #Retornem uid capturat en forma de string concatenat, en majúscules
	end
end

if __FILE__ == $0
	rfid = Rfid.new()
	puts "Apropi la tarjeta al lector"
	id = rfid.read_uid
	puts id
end

