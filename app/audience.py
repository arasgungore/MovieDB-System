from flask import Blueprint, render_template, request, redirect, url_for, session
import mysql.connector

audience_bp = Blueprint('audience', __name__)
audience_bp.secret_key = 'qwerty123'

# MySQL database connection configuration
mysql_config = {
    'user': 'root',
    'password': 'Aras1337',
    'host': 'localhost',
    'database': 'Project1'
}

# Create MySQL connection
conn = mysql.connector.connect(**mysql_config)

# Routes for the Audience

# Dashboard for registered audience
@audience_bp.route('/audience_dashboard')
def audience_dashboard():
    return render_template('audience/audience_dashboard.html')

# Login page for audience
@audience_bp.route('/audience_login', methods=['GET', 'POST'])
def audience_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = conn.cursor()
        query = 'SELECT * FROM Audience WHERE username = %s AND _password = %s'
        cursor.execute(query, (username, password))
        result = cursor.fetchone()
        cursor.close()

        if result:
            session['username'] = username
            return redirect(url_for('audience.audience_dashboard'))
        else:
            return render_template('audience/audience_login.html', error='Invalid credentials.')

    return render_template('audience/audience_login.html')

# 16: Audiences shall be able to list all the movies. The list must include the following attributes:
# movie id, movie name, director’s surname, platform, theatre id, time slot, predecessors list.
# predecessors list must be a string in the form “movie1 id, movie2 id, ...”
@audience_bp.route('/list_movies', methods=['GET', 'POST'])
def list_movies():
    cursor = conn.cursor()
    query = '''
    SELECT Movie.movie_id, Movie.movie_name, Directors.surname, Rating_Platform.platform_name,
        Movie_Sessions.theater_id, Movie_Time.time_slot,
        GROUP_CONCAT(Predecessor_Movies.predecessor_id) AS predecessors_list
    FROM Movie
    LEFT JOIN Directors ON Movie.director_username = Directors.username
    LEFT JOIN Rating_Platform ON Directors.platform_id = Rating_Platform.platform_id
    LEFT JOIN Movie_Sessions ON Movie.movie_id = Movie_Sessions.movie_id
    LEFT JOIN Movie_Time ON Movie_Sessions.session_id = Movie_Time.session_id
    LEFT JOIN Predecessor_Movies ON Movie.movie_id = Predecessor_Movies.successor_id
    GROUP BY Movie.movie_id, Movie.movie_name, Directors.surname, Rating_Platform.platform_name, Movie_Sessions.theater_id, Movie_Time.time_slot
    '''
    cursor.execute(query)
    movies = cursor.fetchall()
    cursor.close()

    return render_template('audience/list_movies.html', movies=movies)

# 17: Audiences shall be able to buy a movie ticket by providing a session id. There are several constraints:
# (a) Audiences can buy tickets for different movies or movie sessions (i.e., different sessions of the same movie)
# (b) To buy the movie tickets, all predecessor movies need to be watched in order to watch that movie. (See the example below:
# Deli Yurek to be watched before the Deli Yurek: Bumerang Cehennemi). We will not test the case of a director adding a predecessor
# for a movie after an audience has bought the movie tickets.
# (c) Audience cannot buy a ticket if the theatre capacity is full. At the beginning, bought list of bought sessions of audiences
# will be provided. The capacity for a movie session is the maximum number of audiences who can buy ticket for that movie session.
# These triggers are both implemented in SQL and Python.
@audience_bp.route('/buy_ticket', methods=['GET', 'POST'])
def buy_ticket():
    if request.method == 'POST':
        session_id = request.form['session_id']
        audience_username = session['username']  # Assuming the audience's username is stored in the session

        cursor = conn.cursor()
        
        query = 'SELECT movie_id FROM Movie_Sessions WHERE session_id = %s'
        cursor.execute(query, (session_id,))
        result = cursor.fetchone()
        movie_id = result[0]
        
        # Check if all predecessor movies have been watched by the audience
        query = query = '''
        SELECT COUNT(*) AS count
        FROM Predecessor_Movies
        WHERE successor_id = %s
        AND predecessor_id NOT IN (
            SELECT Movie_Sessions.movie_id
            FROM Movie_Sessions
            JOIN Buy_Ticket ON Movie_Sessions.session_id = Buy_Ticket.session_id
            WHERE Buy_Ticket.username = %s
        )
        '''

        cursor.execute(query, (movie_id, audience_username))
        result = cursor.fetchone()
        predecessor_count = result[0]

        if predecessor_count == 0:
            # Check if the theater capacity is full
            query = '''
            SELECT COUNT(*) AS count
            FROM Buy_Ticket
            WHERE session_id = %s
            '''
            cursor.execute(query, (session_id,))
            result = cursor.fetchone()
            ticket_count = result[0]
            
            query = '''
            SELECT theater_capacity
            FROM Theater
            JOIN Movie_Sessions ON Theater.theater_id = Movie_Sessions.theater_id
            WHERE Movie_Sessions.session_id = %s
            '''
            cursor.execute(query, (session_id,))
            result = cursor.fetchone()
            theater_capacity = result[0]
            
            if ticket_count < theater_capacity:
                # Insert the ticket into the database
                query = 'INSERT INTO Buy_Ticket (username, session_id) VALUES (%s, %s)'
                cursor.execute(query, (audience_username, session_id))
                conn.commit()
                cursor.close()
                
                return redirect(url_for('audience.audience_dashboard'))
            else:
                cursor.close()
                return render_template('audience/buy_ticket.html', error='The theater capacity is full.')
        else:
            cursor.close()
            return render_template('audience/buy_ticket.html', error='You need to watch all predecessor movies first.')
    
    return render_template('audience/buy_ticket.html')

# 18: Audiences shall be able to view the tickets that they’re currently buying and have bought
# previously. The list must include the following attributes: movie id, movie name, session id,
# rating, overall rating. If the audience is buying the ticket and the movie isn’t screened yet,
# the rating field will be null.
@audience_bp.route('/view_tickets')
def view_tickets():
    audience_username = session['username']
    
    cursor = conn.cursor()
    query = '''
    SELECT Movie.movie_id, Movie.movie_name, Movie_Sessions.session_id, Rate.rating, Movie.average_rating
    FROM Movie
    LEFT JOIN Movie_Sessions ON Movie.movie_id = Movie_Sessions.movie_id
    LEFT JOIN Buy_Ticket ON Movie_Sessions.session_id = Buy_Ticket.session_id
    LEFT JOIN Rate ON Movie.movie_id = Rate.movie_id AND Rate.username = Buy_Ticket.username
    WHERE Buy_Ticket.username = %s
    '''
    cursor.execute(query, (audience_username,))
    tickets = cursor.fetchall()
    cursor.close()

    return render_template('audience/view_tickets.html', tickets=tickets)

# Logout as registered audience
@audience_bp.route('/logout')
def logout():
    # Clear the session data
    session.clear()
    # Redirect to the main page or any other desired page
    return redirect(url_for('main'))