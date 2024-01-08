CREATE DATABASE IF NOT EXISTS Project1;
USE Project1;

-- Rating_Platform(platform_id: integer, platform_name: string)
CREATE TABLE IF NOT EXISTS Rating_Platform (
    platform_id int,
	platform_name varchar(255) NOT NULL UNIQUE,	-- Platform name must also be unique and each platform should have a name.
	PRIMARY KEY (platform_id)	-- Platform ID is set as primary key and is by default unique and not null.
);

-- Audience(username: string, _password: string, _name: string, surname: string)
CREATE TABLE IF NOT EXISTS Audience (	-- Audience inherits User.
    username varchar(255),
    _password varchar(255) NOT NULL, -- 'password' and 'name' are reserved keywords so I have added an underscore.
    _name varchar(255) NOT NULL,	 -- Each user has a password and a name, surname can be empty.
    surname varchar(255),
    PRIMARY KEY(username)	-- Username is set as primary key and is by default unique and not null.
);

-- Directors(username: string, _password: string, _name: string, surname: string, nation: string, platform_id: integer)
CREATE TABLE IF NOT EXISTS Directors (	-- Director inherits User.
    username varchar(255),
    _password varchar(255) NOT NULL, -- 'password' and 'name' are reserved keywords so I have added an underscore.
    _name varchar(255) NOT NULL,	 -- Each user has a password and a name, surname can be empty.
    surname varchar(255),
    nation varchar(255) NOT NULL,		-- Each director must have only one nation, so it cannot be null.
    platform_id int,					-- Each director can have at most one platform id, so it can be null.
    PRIMARY KEY(username),				-- Username is set as primary key.
    FOREIGN KEY(platform_id) REFERENCES Rating_Platform(platform_id)	-- Director is registered to a rating platform via platform ID.
    ON DELETE CASCADE
);

-- Subscribed_To(username: string, platform_id: integer)
CREATE TABLE IF NOT EXISTS Subscribed_To (
	username varchar(255),
	platform_id int,
	PRIMARY KEY (username, platform_id),	-- Username and platform ID is set as composite key, multiple entries are avoided.
	FOREIGN KEY (username) REFERENCES Audience(username)
	ON DELETE CASCADE,
	FOREIGN KEY (platform_id) REFERENCES Rating_Platform(platform_id) -- An audience can subscribe to different rating platforms.
	ON DELETE CASCADE
);

-- Genre(genre_id: integer, genre_name: string)
CREATE TABLE IF NOT EXISTS Genre (
	genre_id int,
	genre_name varchar(255) NOT NULL UNIQUE,	-- Genre name must be unique and a genre is meaningless without name, so it cannot be null.
	PRIMARY KEY(genre_id)		-- Genre ID is set as primary key, hence it is unique and not null by default.
);

-- Movie(movie_id: integer, movie_name: string, duration: integer, director_username: string, average_rating: real)
CREATE TABLE IF NOT EXISTS Movie (
    movie_id int,
	movie_name varchar(255) NOT NULL,	-- A movie is meaningless without a name, so it cannot be null.
	duration int NOT NULL,				-- Each movie also has a duration and a director's name, which cannot be null.
	director_username varchar(255) NOT NULL,
	average_rating real,				-- Overall rating can be empty.
	PRIMARY KEY (movie_id),				-- Movie ID is set as primary key.
	FOREIGN KEY (director_username) REFERENCES Directors(username)	-- Each movie is directed by a director.
	ON DELETE CASCADE
);

-- Rate(username: string, movie_id: integer, rating: real)
CREATE TABLE IF NOT EXISTS Rate (		-- This is known as 'Rating' in the project.
	username varchar(255),
	movie_id int NOT NULL,				-- Movie ID cannot be null otherwise it is meaningless.
	rating real NOT NULL,				-- Rating also has to be specified, without it act of rating is meaningless.
	PRIMARY KEY (username, movie_id),	-- Username and movie_id uniquely identifies rating.
	FOREIGN KEY(username) REFERENCES Audience(username)		-- Only audience can rate a movie since only they can buy tickets.
	ON DELETE CASCADE,
	FOREIGN KEY(movie_id) REFERENCES Movie(movie_id)
	ON DELETE CASCADE
);

-- Movie_Genre(movie_id: integer, genre_id: integer)
CREATE TABLE IF NOT EXISTS Movie_Genre (	-- Each movie has at least one genre.
	movie_id int,
	genre_id int,
	PRIMARY KEY(movie_id, genre_id),		-- Movie and genre ID is defined as composite key.
	FOREIGN KEY(movie_id) REFERENCES Movie(movie_id)
	ON DELETE CASCADE,
	FOREIGN KEY(genre_id) REFERENCES Genre(genre_id)
	ON DELETE CASCADE
);

-- Theater(theater_id: integer, theater_name: string, theater_capacity: integer, theater_district: string)
CREATE TABLE IF NOT EXISTS Theater (		-- Each movie session is displayed on a theater.
	theater_id int,
	theater_name varchar(255) NOT NULL,		-- A theater without a name is meaningless, so it cannot be null.
	theater_capacity int NOT NULL,			-- While theater district can be unknown, capacity has to be known to ensure audience doesn't overflow to a certain movie session.
	theater_district varchar(255),
	PRIMARY KEY (theater_id)				-- Theater ID is set as primary key.
);

-- Movie_Sessions(session_id: integer, movie_id: integer, theater_id: integer)
CREATE TABLE IF NOT EXISTS Movie_Sessions (
    session_id int,
    movie_id int NOT NULL,			-- Movie and theater ID must be given, it cannot be null.
	theater_id int NOT NULL,
	PRIMARY KEY(session_id),
	FOREIGN KEY(movie_id) REFERENCES Movie(movie_id)
	ON DELETE CASCADE,
	FOREIGN KEY(theater_id) REFERENCES Theater(theater_id)	-- Movie Session inherits Theater.
	ON DELETE CASCADE
);

-- Buy_Ticket(username: string, session_id: integer)
CREATE TABLE IF NOT EXISTS Buy_Ticket (
	username varchar(255),
	session_id int,
	PRIMARY KEY(username, session_id),
	FOREIGN KEY(username) REFERENCES Audience(username)		-- Only audiences can buy tickets.
	ON DELETE CASCADE,
	FOREIGN KEY(session_id) REFERENCES Movie_Sessions(session_id)	-- An audience can buy tickets for different movies.
	ON DELETE CASCADE
);

-- Movie_Time(session_id: integer, _date: date, time_slot: integer)
CREATE TABLE IF NOT EXISTS Movie_Time (
	session_id int,
	_date date,		-- 'date' is a reserved keyword so I have added an underscore.
	time_slot int,
	PRIMARY KEY(session_id),	-- Since movie sessions CAN have conflicting time periods in different theaters, I have set session ID as composite key.
	FOREIGN KEY(session_id) REFERENCES Movie_Sessions(session_id)
	ON DELETE CASCADE
);

-- Predecessor_Movies(predecessor_id: integer, successor_id: integer)
CREATE TABLE IF NOT EXISTS Predecessor_Movies (		-- A movie can have multiple predecessor movies.
	predecessor_id int,
	successor_id int,
	PRIMARY KEY(predecessor_id, successor_id),		-- Predecessor and successor movie IDs are defined as composite key.
	FOREIGN KEY(predecessor_id) REFERENCES Movie(movie_id)
	ON DELETE CASCADE,
	FOREIGN KEY(successor_id) REFERENCES Movie(movie_id)
	ON DELETE CASCADE
);

-- Database_Managers(username: string, _password: string)
CREATE TABLE IF NOT EXISTS Database_Managers (
	username varchar(255),
	_password varchar(255) NOT NULL,		-- 'password' is a reserved keyword so I have added an underscore.
	PRIMARY KEY(username)		-- While not specified, like users it makes sense to define username as primary key.
);





-- Check if rating is between 0-5 in 'Rate' table.
ALTER TABLE Rate
ADD CONSTRAINT check_rating CHECK (rating >= 0 AND rating <= 5);

-- Check if time slots between 1-4 in 'Movie_Time' table.
ALTER TABLE Movie_Time
ADD CONSTRAINT check_timeslot CHECK (time_slot >= 1 AND time_slot <= 4);

-- Trigger to limit the number of database managers.
DELIMITER //
CREATE TRIGGER IF NOT EXISTS MaxDatabaseManagers BEFORE INSERT ON Database_Managers
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM Database_Managers) >= 4 THEN	-- Print error message if number of database managers exceeds 4.
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cannot add more than 4 database managers';
	END IF;
END; //
DELIMITER ;

-- Trigger to update average rating of corresponding movie after rating.
DELIMITER //
CREATE TRIGGER IF NOT EXISTS UpdateAverageRating AFTER INSERT ON Rate
FOR EACH ROW 
BEGIN
    UPDATE Movie
    SET average_rating = (
        SELECT AVG(rating) FROM Rate WHERE movie_id = NEW.movie_id
    )
    WHERE movie_id = NEW.movie_id;
END; //
DELIMITER ;

-- Trigger to check if a user is subscribed to a movie platform and bought a ticket before rating.
DELIMITER //
CREATE TRIGGER IF NOT EXISTS CheckUserRating BEFORE INSERT ON Rate
FOR EACH ROW
BEGIN
    IF NOT EXISTS (		-- Not bought a ticket.
        SELECT 1
        FROM Buy_Ticket
        JOIN Movie_Sessions ON Buy_Ticket.session_id = Movie_Sessions.session_id
        WHERE Buy_Ticket.username = NEW.username AND Movie_Sessions.movie_id = NEW.movie_id
    ) OR NOT EXISTS (	-- Not subscribed to a movie platform.
        SELECT 1
        FROM Subscribed_To
        JOIN Movie ON Movie.movie_id = NEW.movie_id
        JOIN Directors ON Movie.director_username = Directors.username
        WHERE Subscribed_To.username = NEW.username
        AND Subscribed_To.platform_id = Directors.platform_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User cannot rate a movie without buying a ticket or being subscribed to the movie platform';
    END IF;
END; //
DELIMITER ;

-- Trigger to check the movie duration doesn't exceed the available time slots.
DELIMITER //
CREATE TRIGGER IF NOT EXISTS CheckMovieDuration BEFORE INSERT ON Movie_Time
FOR EACH ROW
BEGIN
    IF (		-- There are 4 time slots [1, 2, 3, 4], so duration can max be (4 - start_time + 1)
        SELECT Movie.duration
        FROM Movie
        JOIN Movie_Sessions ON Movie.movie_id = Movie_Sessions.movie_id
        WHERE Movie_Sessions.session_id = NEW.session_id
    ) > (5 - NEW.time_slot) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Movie duration exceeds the available time slots';
    END IF;
END; //
DELIMITER ;

-- Trigger to check if theatre capacity can hold the number of tickets sold for given theatre.
DELIMITER //
CREATE TRIGGER IF NOT EXISTS CheckTheatreCapacity BEFORE INSERT ON Buy_Ticket
FOR EACH ROW
BEGIN
    IF (
        SELECT COUNT(*)
        FROM Buy_Ticket
        WHERE Buy_Ticket.session_id = NEW.session_id
    ) >= (
        SELECT Theater.theater_capacity
        FROM Theater
        JOIN Movie_Sessions ON Theater.theater_id = Movie_Sessions.theater_id
        WHERE Movie_Sessions.session_id = NEW.session_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot sell more tickets than the theatre capacity';
    END IF;
END; //
DELIMITER ;

-- Trigger to check if there is no time conflict in the same theater.
DELIMITER //
CREATE TRIGGER IF NOT EXISTS CheckTimeSlot BEFORE INSERT ON Movie_Time
FOR EACH ROW
BEGIN
    DECLARE session_start_time INT;
    DECLARE session_end_time INT;
    DECLARE theater_id INT;

    SET session_start_time = NEW.time_slot;
    SET session_end_time = session_start_time + (   -- end time = start time + duration - 1
        SELECT Movie.duration
        FROM Movie
        JOIN Movie_Sessions ON Movie.movie_id = Movie_Sessions.movie_id
        WHERE Movie_Sessions.session_id = NEW.session_id
    ) - 1;
    SET theater_id = (                              -- Get theater ID.
        SELECT Movie_Sessions.theater_id
        FROM Movie_Sessions
        WHERE Movie_Sessions.session_id = NEW.session_id
    );

    IF EXISTS (
        SELECT 1
        FROM Movie_Sessions
        JOIN Movie_Time ON Movie_Sessions.session_id = Movie_Time.session_id
        JOIN Movie ON Movie_Sessions.movie_id = Movie.movie_id
        WHERE Movie_Sessions.theater_id = theater_id
            AND Movie_Time._date = NEW._date    -- In the same theater at the same day.
            AND (
                Movie_Time.time_slot BETWEEN session_start_time AND session_end_time
                OR session_start_time BETWEEN Movie_Time.time_slot AND (Movie_Time.time_slot + Movie.duration - 1)
            )
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'There is already a movie playing at this theater and time slot.';
        DELETE FROM Movie_Sessions WHERE session_id = NEW.session_id;
    END IF;
END //
DELIMITER ;


-- Trigger to check if the audience has watched all predecessor movies before buying ticket.
DELIMITER //
CREATE TRIGGER IF NOT EXISTS CheckPredecessorMovies BEFORE INSERT ON Buy_Ticket
FOR EACH ROW
BEGIN
	IF EXISTS (
            SELECT 1 
            FROM Predecessor_Movies 
            WHERE successor_id IN (
                SELECT movie_id 
                FROM Movie_Sessions 
                WHERE session_id = NEW.session_id
            )
            AND predecessor_id NOT IN (     -- Check if the ticket for predecessor movie is bought.
                SELECT Movie_Sessions.movie_id
                FROM Buy_Ticket
                JOIN Movie_Sessions ON Buy_Ticket.session_id = Movie_Sessions.session_id
                WHERE Buy_Ticket.username = NEW.username
            )
        ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User cannot buy a ticket without watching all predecessor movies';
	END IF;
END; //
DELIMITER ;

