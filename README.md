# MovieDB-System

Final MySQL project assigned for the Introduction to Database Systems (CMPE 321) course in the Spring 2023 semester. This project aims to develop a database application for a movie ticket booking and rating system. In the first project, we have performed conceptual database design, drew ER diagrams, and converted these ER diagrams into relational tables for MovieDB. In this project, we went one step further and implemented the MovieDB database with a user interface (UI) using the structure we have designed in the first project. The database was built using MySQL and the UI was built using Flask.



## Setting up the MySQL Database

Before you begin, make sure you have MySQL installed on your system. If not, you can download it from [here](https://dev.mysql.com/downloads/mysql/).

1. Open the MySQL command line by entering the following command in your terminal:

    ```bash
    mysql -u root -p
    ```

   You'll be prompted for your MySQL root user password. Enter it to continue.

2. Now, you can run the `createTables.sql` file to set up your database and tables. You can do this by entering the following command, replacing "path_to_project" with the actual path to your `createTables.sql` file:

    ```bash
    source path_to_project/database/createTables.sql
    ```

3. Optionally, you can run 'test.sql' file to insert sample data into the database. This file was used primarily for testing.

   ```bash
    source path_to_project/database/test.sql
    ```



## Setting up the Python Environment

Ensure that Python 3 is installed on your system. If not, you can download it from [here](https://www.python.org/downloads/).

1. It's recommended to create a virtual environment to keep the dependencies required by the project separate from your other Python projects. To install `virtualenv`, run:

   ```bash
   pip install virtualenv
   ```

   Then, in your project directory, create and activate a virtual environment:

   ```bash
   cd path_to_your_project/app
   virtualenv venv
   source venv/bin/activate  # On Windows use: venv\Scripts\activate
   ```

2. Install the required Python packages:

   ```bash
   pip install flask mysql-connector-python
   ```



## Running the Application

1. Make sure your MySQL server is running.
2. Update the `mysql_config` dictionary in ALL `*.py` files other than `app.py` with your MySQL configuration details.
3. Run the application with the following command:

   ```bash
   python app.py
   ```

4. Open your web browser and go to `localhost:5000` (or if you've set a different host/port, use that instead).



## Using the Application

You will see the main page of the application. From here, you can navigate to the login page for database managers, directors, or audience members and log in using your credentials. Depending on your role, you will have different capabilities like adding/deleting users, listing/adding/updating movies, buying tickets, and viewing bought tickets.

Remember to log out when you're finished to ensure your session data is cleared.



## Shutting Down the Application

When you want to stop running the application, go back to your terminal and press `CTRL+C`.



## Deactivating the Virtual Environment

After finishing your work, you can deactivate the virtual environment:

```bash
deactivate
```

When you want to work on the project again, you can reactivate the environment with the activate command used earlier.



## Authors

👤 **Aras Güngöre**

* LinkedIn: [@arasgungore](https://www.linkedin.com/in/arasgungore)
* GitHub: [@arasgungore](https://github.com/arasgungore)

👤 **Ali Üçer**

* LinkedIn: [@ucer](https://www.linkedin.com/in/ucer)
* GitHub: [@aliucer](https://github.com/aliucer)
