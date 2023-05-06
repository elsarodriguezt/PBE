require 'gtk3'
require 'lectura.rb'
require 'rfid.rb'

class Client
	@connect=Connexio.new
	
	def init_window
		@window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
		@window.set_size_request(20,20)
		@window.set_border_width(10) 
		@window.set_window_position(:CENTER)

		@grid=Gtk::Grid.new		#incloem la quadricula
		@window.add(grid)
		@grid.set_column_spacing(10)
		@grid.set_row_spacing(10)
		
		@provider = Gtk::CssProvider.new
		@style_provider = Gtk::StyleProvider::PRIORITY_USER
		@provider.load(:data => File.read("estil.css"))
		
		Pantalla_Login
	end
	
	def Pantalla_Login
	    #Eliminem tot el que hi ha a la grid de la window per posar la info de la nova pantalla
	    @grid.children.each do |object|
	        @grid.remove(object)
	    end
		#Missatge LOGIN
		login=Gtk::Label.new("Please, login with your university card")
		login.set_name("login")
		login.style_context.add_provider(@provider, @style_provider)
		@grid.attach(login,1,1,2,1)
		
		@window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
		@window.show_all
		Gtk.main
		
		#Escanejem targeta RFID
		rfid=Rfid.new
		@uid=rfid.read_uid
		if(@uid = null)   #Escanejo el rfid
			@grid.remove(login)	  #Elimino el missatge de LOGIN
			Pantalla_Buscador	  #canvio a la pantalla BUSCADOR
		end
	end
	
	def Pantalla_Buscador
		#Eliminem tot el que hi ha a la grid de la window per posar la info de la nova pantalla
	    @grid.children.each do |object|
	        @grid.remove(object)
	    end
		#DEMANA EL NOM AL SERVIDOR 
		name = @connect.llegir(null,@uid)
		
		#Missatge benvinguda
		welcome=Gtk::Label.new("Welcome "+name)
		@window.add(welcome)
		@grid.attach(welcome, 0,1,3,1)
		
		#Creem el botÃ³ LOGOUT
		button = Gtk::Button.new(:label => "Logout")
		button.signal_connect "clicked" do |_widget| #Si cliquem logout, tornem a la pantalla d'inici
			Pantalla_Login
		end
		@grid.attach(button, 5, 1, 1, 1)

		#Creem BUSCADOR
		buscador  = Gtk::Entry.new
		buscador.set_max_length 50
		buscador.signal_connect "activate" do |widget|
			query=buscador.buffer.text.chop
			buscar(query)
		end
		@grid.attach(buscador,0,2,20,1)
		
		@window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
		@window.show_all
		Gtk.main
	end

	def buscar(query)
		#La taula que necessito..
		informacio = query.split('?')
		
		#Posem el titol de la taula corresponent
		titol=Gtk::Label.new(informacio[0])
		titol.set_name("titol1")
		titol.style_context.add_provider(@provider, @style_provider)
		@window.add(titol)
		@grid.attach(titol,2,3,2,1)
		
		#LLEGIM INFO DEL SERVER
		lectura=@conect.llegir(query, @uid)
		
		#PROCESSEM LA INFO 
		case informacio[0]
		when "tasks"
			titols=["Date","Subject","Name"]
			taula(lectura, titols)
			
		when "timetables"
			titols=["Day","Hour","Subject","Room"]
			taula(lectura, titols)
		
		when "marks"
			titols=["Subject","Name","Mark"]
			taula(lectura, titols)
		else
			error
		end
	end
	
	def taula(lectura, titols)
		#Eliminem tot el que hi ha a la grid de la window per posar la info de la nova pantalla
	    @grid.children.each do |object|
	        @grid.remove(object)
	    end
		i=0
		#ESCRIVIM ELS TITOLS
		while i<titols.length do
			titol=Gtk::Label.new(titols[i])
			titol.set_name("titol2")
			titol.style_context.add_provider(@provider, @style_provider)
			@grid.attach(titol,i,4,1,1)
			j=0
			info=lectura[titols[i]]
			while j<lectura.length do
				fila=Gtk::Label.new(info[j])
				@grid.attach(fila, i, 5+j, 1, 1)
				j=j+1
			end
			i=i+1
		end
	end
	
	def error
		dialog = Gtk::Dialog.new
		dialog.title = "Error"
		dialog.set_default_size(400,80)
		dualog.set_name("dialog")
		dialog.style_context.add_provider(@provider, @style_provider)
		close_button = dialog.add_button(Gtk::Stock::CLOSE, Gtk::ResponseType::CLOSE)
		dialog.child.add(Gtk::Label.new("Cerca incorrecta. Torni a intentar-ho"))
		dialog.signal_connect("response") {dialog.destroy}
		dialog.show_all
	end
end
