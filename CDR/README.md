# CDR (Critical Design Review)

This project contains a Ruby application with a GUI (Graphical User Interface) that works as a client. This connects to a local server programmed with NodeJS that works as an intermediary between it and a database programmed with MySQL, to collect the information requested by the client and send it back.

Once the client has logged into the server, it will be able to send queries following the URL format.
The server will determine in which database table it will find the requered information and will ask the database for it.
Once obtained, the data will be sent back to the client who will display it on the interface in the form of a table.

Some examples of the queries:

- marks?mark[lt]=5 → Lists all the user's failed marks.
- tasks?date[gte]=now&limit=1 → Lists the first paper from the current date.
- timetables?day=Fri&hour[gt]=08:00 → Lists the first class after Friday at 8 am.

For the correct operation, the server must first be run with the following command: `node server.js`

The Ruby client is then run executing _interficie.rb_ file.

The Web client is then run executing _login.htlm_ file.

The Android client is then run executing de APK application in an Android enviroment.
