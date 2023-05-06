require 'lcd.rb'
require 'rfid.rb'
require 'net/http'
require 'json'
require 'thread'

#Lectura UID
class Connexio
	display=LCD.new
	display.inicialitzar

	def llegir(query, uid) #Lectura del servidor, que ens retorna el nom del usuari
		Thread.new{
			if query==null
				uri=URI("http://localhost:3000/students?uid="+uid) #buscar a la path:/students
			end
			else
				uri=URI("http://localhost:3000/"+query+"&uid="+uid)
			end
		
			request=Net::HTTP::Get.new(uri)
		
			Net::HTTP.start(uri.host,uri.port) do |http| #creates conection to HTTP server
				response=http.request(request)
				data=JSON.parse(response.body) #El server ens retorna un arxiu JSON(response), que hem de parsejar
			end

			#Exemple execucio
			#data=JSON.parse({"name":"Oriol Torres","uid":"ED467D29"})
			#puts data["name"] =>"Oriol Torres"
		
			name=data["name"]
			if name == "NotFound" #si el uid no esta a la nostra BD
				display.printInvalid
			else #si el uid si esta a la nostra BD
				display.printNom(name)
			end
			
			#---------RETURNS-----------
			if query==null
				return name
			end
			else
				return data
			end
		}
	end
end
