# Ruby Client

In this section we will find the necessary code to implement in Ruby the Client application that will be able to access the server and obtain the information from the database.
It is a direct extension of Puzzle1 and Puzzle2.

- **RFID:** The _rfid.rb_ file contains a Class based on Puzzle1 code that identifies the user by reading the RFID card from an RFID reader module and returns the User ID. 

- **LCD:** The _lcd.rb_ file contains a Class where all the necessary functions to operate with the LCD screen are introduced, such as initializing, welcoming the user or indicating an error.

- **Lectura:** The _lectura.rb_ file contains two functions that establish a connection to the server. One of them provides the name of the student when logging in, and the other sends to the server what the user writes in the browser and returns the requested information.

- **Interficie:** The _interficie.rb_ file contains the GUI of the entire project. Initially there is a login screen where the user is expected to register with his RFID card. Next, the user is welcomed and a search engine appears where queries can be written. If the query is wrong, an error message will be shown, instead a table will be displayed with the requested information. You can also press the logout button at any time to exit the application.

- **Estil:** The _estil.css_ file contains the styling of the user interface in CSS.
