# Server

In this section you will find the implementation of the server through NodeJS and from the HTTP protocol. In order to install NodeJS do the following:

`sudo apt-get install -y nodejs`

In the folder there is previous version of the server, now it has been replaced to be more efficient.

The server is organized in such a way that the main file calls to parseQuery function that take care of each table in the database, and an options file.

- **Server:** The file _server.js_ is the main file. This creates a local server and keeps it listening for a request from the client.

- **Options:** The file _options.js_ contains the basic functions such as connecting to the database and sending responses to the client among others.

- **ParseQuery:** The file _parseQuery.js_ contains the function to create an SQL statement to communicate with the database and extract the requered data.
