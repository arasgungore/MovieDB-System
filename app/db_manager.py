from flask import Blueprint, render_template, request, redirect, url_for, session
import mysql.connector

db_manager_bp = Blueprint('db_manager', __name__)
db_manager_bp.secret_key = 'qwerty123'

# MySQL database connection configuration
mysql_config = {
    'user': 'root',
    'password': 'Aras1337',
    'host': 'localhost',
    'database': 'Project1'
}

# Create MySQL connection
conn = mysql.connector.connect(**mysql_config)

# Routes for the Database Manager

# Dashboard for registered database manager
@db_manager_bp.route('/db_manager_dashboard')
def db_manager_dashboard():
    return render_template('db_manager/db_manager_dashboard.html')

# 1: Database managers shall be able to log in to the system with their credentials (username and password).
@db_manager_bp.route('/db_manager_login', methods=['GET', 'POST'])
def db_manager_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = conn.cursor()
        query = 'SELECT * FROM Database_Managers WHERE username = %s AND _password = %s'
        cursor.execute(query, (username, password))
        result = cursor.fetchone()
        cursor.close()

        if result:
            session['username'] = username
            return redirect(url_for('db_manager.db_manager_dashboard'))
        else:
            return render_template('db_manager/db_manager_login.html', error='Invalid credentials.')

    return render_template('db_manager/db_manager_login.html')

# 2: Database managers shall be able to add new Users (Audiences or Directors) to the system.
@db_manager_bp.route('/add_user', methods=['GET', 'POST'])
def add_user():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        name = request.form['name']
        surname = request.form['surname']
        user_type = request.form['user_type']
        nation = request.form['nation']
        platform_id = request.form['platform_id']
        cursor = conn.cursor()

        if user_type == 'audience':
            query = 'INSERT INTO Audience (username, _password, _name, surname) VALUES (%s, %s, %s, %s)'
            cursor.execute(query, (username, password, name, surname))
        elif user_type == 'director':
            query = 'INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES (%s, %s, %s, %s, %s, %s)'
            cursor.execute(query, (username, password, name, surname, nation, platform_id))
        else:
            cursor.close()
            return render_template('db_manager/add_user.html', error='Invalid user type.')
        conn.commit()
        cursor.close()
        return redirect(url_for('db_manager.db_manager_dashboard'))

    return render_template('db_manager/add_user.html')

# 3: Database managers shall be able to delete audience by providing username.
# When an audience is deleted, all personal data regarding that audience must be deleted
# including the list of bought sessions for movie sessions and the list of rating platforms
# to which they are subscribed.
@db_manager_bp.route('/delete_audience', methods=['GET', 'POST'])
def delete_audience():
    if request.method == 'POST':
        username = request.form['username']
        cursor = conn.cursor()
        query = 'DELETE FROM Audience WHERE username = %s'
        cursor.execute(query, (username,))
        conn.commit()
        cursor.close()

        return redirect(url_for('db_manager.db_manager_dashboard'))

    return render_template('db_manager/delete_audience.html')

# 4: Database managers shall be able to update platform id of the directors by providing director username and platform id.
@db_manager_bp.route('/update_platform', methods=['GET', 'POST'])
def update_platform():
    if request.method == 'POST':
        username = request.form['username']
        platform_id = request.form['platform_id']
        cursor = conn.cursor()
        query = 'UPDATE Directors SET platform_id = %s WHERE username = %s'
        cursor.execute(query, (platform_id, username))
        conn.commit()
        cursor.close()

        return redirect(url_for('db_manager.db_manager_dashboard'))

    return render_template('db_manager/update_platform.html')

# 5: Database managers shall be able to view all directors.
# The list must include the following attributes: username, name, surname, nation, platform id.
@db_manager_bp.route('/view_directors')
def view_directors():
    cursor = conn.cursor()
    query = 'SELECT username, _name, surname, nation, platform_id FROM Directors'
    cursor.execute(query)
    directors = cursor.fetchall()
    cursor.close()

    return render_template('db_manager/view_directors.html', directors=directors)

# 6: Database managers shall be able to view all ratings of a specific audience by providing username.
# The list must include the following information: movie id, movie name, rating.
@db_manager_bp.route('/view_ratings', methods=['GET', 'POST'])
def view_ratings():
    if request.method == 'POST':
        username = request.form['username']
        cursor = conn.cursor()
        query = '''
        SELECT Movie.movie_id, Movie.movie_name, Rate.rating
        FROM Movie
        INNER JOIN Rate ON Movie.movie_id = Rate.movie_id
        WHERE Rate.username = %s
        '''
        cursor.execute(query, (username,))
        ratings = cursor.fetchall()
        cursor.close()

        return render_template('db_manager/view_ratings.html', ratings=ratings)
        
    return render_template('db_manager/view_ratings.html')

# 7: Database managers shall be able to view all movies of a specific director by providing the director’s username.
# The list must include the following attributes: movie id, movie name, theatre id, district, time slot.
@db_manager_bp.route('/view_movies', methods=['GET', 'POST'])
def view_movies():
    if request.method == 'POST':
        username = request.form['username']
        cursor = conn.cursor()
        query = '''
        SELECT Movie.movie_id, Movie.movie_name, Movie_Sessions.theater_id, Theater.theater_district, Movie_Time.time_slot
        FROM Movie
        INNER JOIN Movie_Sessions ON Movie.movie_id = Movie_Sessions.movie_id
        INNER JOIN Theater ON Movie_Sessions.theater_id = Theater.theater_id
        INNER JOIN Movie_Time ON Movie_Sessions.session_id = Movie_Time.session_id
        WHERE Movie.director_username = %s
        '''
        cursor.execute(query, (username,))
        movies = cursor.fetchall()
        cursor.close()

        return render_template('db_manager/view_movies.html', movies=movies)
        
    return render_template('db_manager/view_movies.html')

# 8: Database managers shall be able to view the average rating of a movie by providing movie id.
# The list must include the following attributes: movie id, movie name, overall rating.
@db_manager_bp.route('/view_average_rating', methods=['GET', 'POST'])
def view_average_rating():
    if request.method == 'POST':
        movie_id = request.form['movie_id']
        cursor = conn.cursor()
        query = '''
        SELECT Movie.movie_id, Movie.movie_name, Movie.average_rating
        FROM Movie
        WHERE Movie.movie_id = %s
        '''
        cursor.execute(query, (movie_id,))
        average_rating = cursor.fetchone()
        cursor.close()

        return render_template('db_manager/view_average_rating.html', average_rating=average_rating)

    return render_template('db_manager/view_average_rating.html')

# Logout as registered database manager
@db_manager_bp.route('/logout')
def logout():
    # Clear the session data
    session.clear()
    # Redirect to the main page or any other desired page
    return redirect(url_for('main'))