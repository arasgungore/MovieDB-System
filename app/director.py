from flask import Blueprint, render_template, request, redirect, url_for, session
import mysql.connector

director_bp = Blueprint('director', __name__)
director_bp.secret_key = 'qwerty123'

# MySQL database connection configuration
mysql_config = {
    'user': 'root',
    'password': 'Aras1337',
    'host': 'localhost',
    'database': 'Project1'
}

# Create MySQL connection
conn = mysql.connector.connect(**mysql_config)

# Routes for the Director

# Dashboard for registered director
@director_bp.route('/director_dashboard')
def director_dashboard():
    return render_template('director/director_dashboard.html')

# 9: Directors shall be able to log in to the system with their credentials (username and password).
@director_bp.route('/director_login', methods=['GET', 'POST'])
def director_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = conn.cursor()
        query = 'SELECT * FROM Directors WHERE username = %s AND _password = %s'
        cursor.execute(query, (username, password))
        result = cursor.fetchone()
        cursor.close()

        if result:
            session['username'] = username
            return redirect(url_for('director.director_dashboard'))
        else:
            return render_template('director/director_login.html', error='Invalid credentials.')

    return render_template('director/director_login.html')

# 10: Directors shall be able to list all of the theatres available for a given slot.
# The list must include the following attributes: theatre id, district, theatre capacity.
@director_bp.route('/list_theaters', methods=['GET', 'POST'])
def list_theaters():
    if request.method == 'POST':
        date = request.form['date']
        time_slot = request.form['time_slot']
        cursor = conn.cursor()
        query = '''
        SELECT Theater.theater_id, Theater.theater_district, Theater.theater_capacity
        FROM Theater
        INNER JOIN Movie_Sessions ON Theater.theater_id = Movie_Sessions.theater_id
        INNER JOIN Movie_Time ON Movie_Sessions.session_id = Movie_Time.session_id
        WHERE Movie_Time.time_slot = %s AND Movie_Time._date = %s
        '''
        cursor.execute(query, (time_slot, date))
        theaters = cursor.fetchall()
        cursor.close()

        return render_template('director/list_theaters.html', theaters=theaters)

    return render_template('director/list_theaters.html')

# 11: Directors shall be able to add movies by providing movie id, movie name, theatre id,
# time slot. The platform id of the movie should be the same as the director’s platform.
@director_bp.route('/add_movie', methods=['GET', 'POST'])
def add_movie():
    if request.method == 'POST':
        movie_id = request.form['movie_id']
        movie_name = request.form['movie_name']
        theater_id = request.form['theater_id']
        date = request.form['date']
        time_slot = request.form['time_slot']
        director_username = session['username']
        session_id = request.form['session_id']
        duration = request.form['duration']
        
        # Insert the movie into the database
        cursor = conn.cursor()
        query = 'INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (%s, %s, %s, %s, NULL)'
        cursor.execute(query, (movie_id, movie_name, duration, director_username))
        conn.commit()
        
        # Insert the movie session into the database
        query = 'INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (%s, %s, %s)'
        cursor.execute(query, (session_id, movie_id, theater_id))
        conn.commit()
        
        # Insert the movie time into the database
        query = 'INSERT INTO Movie_Time (session_id, _date, time_slot) VALUES (%s, %s, %s)'
        cursor.execute(query, (session_id, date, time_slot))
        conn.commit()
        
        cursor.close()
        
        return redirect(url_for('director.director_dashboard'))
    
    return render_template('director/add_movie.html')

# 12: Directors shall be able to add predecessor(s) to a movie by providing its movie id and the movie id of the predecessors.
@director_bp.route('/add_predecessors', methods=['GET', 'POST'])
def add_predecessors():
    if request.method == 'POST':
        movie_id = request.form['movie_id']
        predecessors = request.form['predecessors']  # Comma-separated list of predecessor movie IDs
        
        # Split the predecessors string into a list of movie IDs
        predecessor_ids = predecessors.split(',')
        
        # Insert the predecessor relationships into the database
        cursor = conn.cursor()
        for predecessor_id in predecessor_ids:
            query = 'INSERT INTO Predecessor_Movies (predecessor_id, successor_id) VALUES (%s, %s)'
            cursor.execute(query, (predecessor_id, movie_id))
        
        conn.commit()
        cursor.close()
        
        return redirect(url_for('director.director_dashboard'))
    
    return render_template('director/add_predecessors.html')

# 13: Directors shall be able to view all movies that they directed in ascending order of movie id.
# The list must include the following attributes: movie id, movie name, theatre id, time slot, predecessors list.
# Predecessors list must be a string in the form “movie1 id, movie2 id, ...”
@director_bp.route('/view_director_movies')
def view_director_movies():
    director_username = session['username']  # Assuming the director's username is stored in the session
    # Fetch the movies directed by the director in ascending order of movie ID
    cursor = conn.cursor()
    query = '''
    SELECT Movie.movie_id, Movie.movie_name, Movie_Sessions.theater_id, Movie_Time.time_slot,
        GROUP_CONCAT(Predecessor_Movies.predecessor_id) AS predecessors_list
    FROM Movie
    LEFT JOIN Movie_Sessions ON Movie.movie_id = Movie_Sessions.movie_id
    LEFT JOIN Movie_Time ON Movie_Sessions.session_id = Movie_Time.session_id
    LEFT JOIN Predecessor_Movies ON Movie.movie_id = Predecessor_Movies.successor_id
    WHERE Movie.director_username = %s
    GROUP BY Movie.movie_id, Movie_Sessions.theater_id, Movie_Time.time_slot
    ORDER BY Movie.movie_id ASC
    '''
    cursor.execute(query, (director_username,))
    movies = cursor.fetchall()
    cursor.close()

    return render_template('director/view_director_movies.html', movies=movies)

# 14: Directors shall be able to view all audiences who bought a ticket for a specific movie directed by themselves.
# To view this information, the director should provide a movie id.
# The list must include the following attributes: username, name and surname.
@director_bp.route('/view_audiences_for_movie', methods=['GET', 'POST'])
def view_audiences_for_movie():
    if request.method == 'POST':
        movie_id = request.form['movie_id']
        director_username = session['username']

        cursor = conn.cursor()
        query = '''
        SELECT Audience.username, Audience._name, Audience.surname
        FROM Audience
        JOIN Buy_Ticket ON Audience.username = Buy_Ticket.username
        JOIN Movie_Sessions ON Buy_Ticket.session_id = Movie_Sessions.session_id
        JOIN Movie ON Movie_Sessions.movie_id = Movie.movie_id
        WHERE Movie.movie_id = %s AND Movie.director_username = %s
        '''
        cursor.execute(query, (movie_id, director_username))
        audiences = cursor.fetchall()
        cursor.close()

        return render_template('director/view_audiences_for_movie.html', audiences=audiences)

    return render_template('director/view_audiences_for_movie.html')

# 15: Directors shall be able to update the name of a movie directed by themselves by providing a movie id and movie name.
@director_bp.route('/update_movie_name', methods=['GET', 'POST'])
def update_movie_name():
    if request.method == 'POST':
        movie_id = request.form['movie_id']
        movie_name = request.form['movie_name']
        director_username = session['username']

        cursor = conn.cursor()
        query = '''
        UPDATE Movie
        SET movie_name = %s
        WHERE movie_id = %s AND director_username = %s
        '''
        cursor.execute(query, (movie_name, movie_id, director_username))
        conn.commit()
        cursor.close()

        return redirect(url_for('director.director_dashboard'))

    return render_template('director/update_movie_name.html')

# Logout as registered director
@director_bp.route('/logout')
def logout():
    # Clear the session data
    session.clear()
    # Redirect to the main page or any other desired page
    return redirect(url_for('main'))