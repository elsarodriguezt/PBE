# Database

The file _db.sql_ is a database programmed in MySQL that contains all the data corresponding to 5 students.
This is made up of 4 tables: students, tasks, marks and timetables.
Finally, the tables are sorted according to the subject or date depending on the table.

In order to use MySQL with NodeJS on the device requires the NPM package manager, and the following steps must be performed:

`sudo apt install mariadb-server`

`sudo mysql_secure_installation`

`sudo apt install npm`

`npm install mysql`

Get in the MariaDB (MySQL) server with the root user and create the new user with which the database will be made and accessed.

`sudo mysql -u root -p`

`CREATE USER 'pbe'@'localhost' IDENTIFIED BY 'password';`

`GRANT ALL PRIVILEGES ON *.* TO 'pbe'@'localhost';`

`FLUSH PRIVILEGES;`
