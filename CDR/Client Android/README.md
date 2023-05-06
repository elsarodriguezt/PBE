# Android Client

In this section we will find all the packages and the necessary code to implement the Client application that will be able to access the server and obtain the information from the database. The application is almost entirely coded in Java, and it runs in an Android environment.

In order to connect with the server it is important to be sure you have the library _OkHttp3_ installed. To do so, write the following in section _dependencies_ of the _build.gradle_ file: `implementation("com.squareup.okhttp3:okhttp:4.9.3")`

Another important thing is to keep in mind that to connect to the port 3000 of the localhost of another device we will need to write its IP. Example: `http://192.168.54.1:3000/`

The most important files of the app are the following ones:

- **AndroidManifest:** The _AndroidManifest.xml_ file shows the essential information about the App, such as the name of the package, defines the components and classes, the initial activity and the necessary permissions.

- **LoginActivity:** The _LoginActivity.java_ file is used to identify the user by asking him for username, password and the URL route of the server. 

- **LoggedActivity:** The _LoggedActivity.java_ file is used to collect the queries made by the user, connect to the server and print the information returned in a table. It also has a logout button.

- **login_window:** The _login_window.xml_ file describes the structure and graphical characteristics of the main window, linked to _LoginActivity.java_.

- **logged_window:** The _logged_window.xml_ file describes the structure and graphical characteristics of the secondary window, linked to _LoggedActivity.java_. 
