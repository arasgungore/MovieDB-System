USE Project1;

-- Add data to tables.
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10130, "IMDB");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10131, "Letterboxd");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10132, "FilmIzle");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10133, "Filmora");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10134, "BollywoodMDB");

INSERT INTO Audience (username, _password, _name, surname) VALUES ("steven.jobs", "apple", "Steven", "Jobs");
INSERT INTO Audience (username, _password, _name, surname) VALUES ("steve.wozniak", "pass", "Ryan", "Andrews");

INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES ("he.gongmin", "pass", "He", "Gongmin", "Turkish", 10130);
INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES ("kyle.balda", "kyle9", "Kyle", "Balda", "German", 10132);

INSERT INTO Genre (genre_id, genre_name) VALUES (80001, "Animation");
INSERT INTO Genre (genre_id, genre_name) VALUES (80002, "Comedy");
INSERT INTO Genre (genre_id, genre_name) VALUES (80003, "Adventure");
INSERT INTO Genre (genre_id, genre_name) VALUES (80004, "Real Story");
INSERT INTO Genre (genre_id, genre_name) VALUES (80005, "Thriller");
INSERT INTO Genre (genre_id, genre_name) VALUES (80006, "Drama");

INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20001, "Despicable Me", 2, "kyle.balda", null);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20002, "Catch Me If You Can", 2, "he.gongmin", null);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20005, "Minions: The Rise of Gru", 1, "kyle.balda", null);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20006, "The Minions", 1, "kyle.balda", null);

INSERT INTO Predecessor_Movies (predecessor_id, successor_id) VALUES (20005, 20006);

INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20001, 80001);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20001, 80002);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20002, 80003);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20005, 80001);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20005, 80002);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20006, 80001);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20006, 80002);

INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40001, "Sisli_1", 300, "Sisli");
INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40002, "Sisli_2", 200, "Sisli");
INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40003, "Sisli_3", 200, "Sisli");

INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50001, 20001, 40001);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50002, 20002, 40002);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50003, 20005, 40002);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50004, 20006, 40001);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50005, 20001, 40003);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50006, 20001, 40002);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50007, 20006, 40002);

INSERT INTO Buy_Ticket(username, session_id) VALUES ("steven.jobs", 50001);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("steven.jobs", 50004);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("steven.jobs", 50003);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("steve.wozniak", 50003);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("steve.wozniak", 50004);

INSERT INTO Subscribed_To (username, platform_id) VALUES ("steven.jobs", 10130);
INSERT INTO Subscribed_To (username, platform_id) VALUES ("steve.wozniak", 10131);

INSERT INTO Rate (username, movie_id, rating) VALUES ("steven.jobs", 20001, 2.4);
INSERT INTO Rate (username, movie_id, rating) VALUES ("steven.jobs", 20005, 1.2);
INSERT INTO Rate (username, movie_id, rating) VALUES ("steve.wozniak", 20005, 4.2);
INSERT INTO Rate (username, movie_id, rating) VALUES ("steve.wozniak", 20006, 3);

INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50001, "2018-05-04", 3);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50002, "2018-05-03", 3);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50003, "2018-05-02", 2);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50004, "2018-05-02", 1);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50005, "2018-05-07", 2);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50006, "2018-06-07", 1);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50007, "2018-06-07", 2);

INSERT INTO Database_Managers (username, _password) VALUES ("manager1", "managerpass1");
INSERT INTO Database_Managers (username, _password) VALUES ("manager2", "managerpass2");
INSERT INTO Database_Managers (username, _password) VALUES ("manager35", "managerpass35");
INSERT INTO Database_Managers (username, _password) VALUES ("manager135", "managerpass35");
INSERT INTO Database_Managers (username, _password) VALUES ("manager235", "managerpass35");



-- Show the tables
SELECT * FROM Audience;
SELECT * FROM Directors;
SELECT * FROM Genre;
SELECT * FROM Movie_Genre;
SELECT * FROM Movie;
SELECT * FROM Rating_Platform;
SELECT * FROM Rate;
SELECT * FROM Subscribed_To;
SELECT * FROM Theater;
SELECT * FROM Movie_Sessions;
SELECT * FROM Buy_Ticket;
SELECT * FROM Movie_Time;
SELECT * FROM Predecessor_Movies;
SELECT * FROM Database_Managers;