require "gtk3"
require_relative 'puzzle1.rb'
require_relative 'options.rb'

rf = Rfid.new                                                         #Objecte RFID

def scan_tag(rf, info_label)
  thr = Thread.new {                                                  
    uid =  rf.read_uid                                                #Lectura 
    puts "Tag detected: " + uid                                       #Mostra UID per command-prompt
    info_label.set_markup("uid: " + uid)                              #Mostra UID per pantalla
    info_label.override_background_color(0, Gdk::RGBA::new(1,0,0,1))  #Canvi a vermell
  }
end

#S'ha utilitzat el fitxer options.rb, on tenim les variables de configuració per fer-ho més senzill.

window = get_window		#Finestra
grid = get_grid			#Graella
info_label = get_label		#Etiqueta
clear_button = get_button	#Botó 'clear' (per tornar a llegir RFID)

#Afegir objectes a graella, determinant la seva posició.
grid.attach(info_label,0,0,1,1)
grid.attach(clear_button,0,1,1,1)
window.set_window_position(:center) #Pantalla al centre


clear_button.signal_connect("clicked") do #Actua si es clica botó
  reset_label(info_label)                 #Reestabliment blau i missatge
  scan_tag(rf, info_label)                
end

window.signal_connect('destroy') { Gtk.main_quit } #Botó que finalitza aplicació


# Run Application
window.add(grid) #Afegim graella amb etiqueta i botó a la finestra visible
window.show_all  #Mostrem elements 
scan_tag(rf, info_label) #Invoquem mètode d'escanejament per primer cop

Gtk.main
