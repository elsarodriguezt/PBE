# Web Client

In this section we will find all the files and the necessary code to implement the Web Client application that will be able to access the server and obtain the information from the database. The client is almost entirely coded in HTML, CSS and JavaScript.

The most important files are the following ones:

- **Conectar:** The _conectar.js_ file is responsible for communicating with the server, and therefore sends the parameters entered by the user (both name and password and queries) and is also responsible for telling the user that the identification is incorrect or to allow entry into the program.

- **Inici:** The _inici.html_ file shows the screen to verify the user, where there is a search engine to enter the query. Once you submit the query, the button activates a function which filters the received query and, depending on this, activates the corresponding screen.

- **Login:** The _login.html_ file has coded the first screen that we find when opening the web client: a screen where the username and password are requested, with a login button and details.

- **Marks, Tasks and Timetables:** The _marks.html_, _tasks.html_, _timetables.html_ files describe each table that can be displayed, they are very similar, but varying the number of columns and their names.

- **Estil:** The _estil.css_ file contains all the font styles, window colors, buttons, and tables, that is, everything you need to design the graphical interface of the project
