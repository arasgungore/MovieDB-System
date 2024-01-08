USE Project1;

-- Add data to tables.
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10130, "IMDB");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10131, "Letterboxd");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10132, "FilmIzle");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10133, "Filmora");
INSERT INTO Rating_Platform (platform_id, platform_name) VALUES (10134, "BollywoodMDB");

INSERT INTO Audience (username, _password, _name, surname) VALUES ("steven.jobs", "apple123", "Steven", "Jobs");
INSERT INTO Audience (username, _password, _name, surname) VALUES ("steve.wozniak", "pass4321", "Ryan", "Andrews");
INSERT INTO Audience (username, _password, _name, surname) VALUES ("arzucan.ozgur", "deneme123", "Arzucan", "Ozgur");
INSERT INTO Audience (username, _password, _name, surname) VALUES ("egemen.isguder", "deneme124", "Egemen", "Isguder");
INSERT INTO Audience (username, _password, _name, surname) VALUES ("busra.oguzoglu", "deneme125", "Busra", "Oguzoglu");

INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES ("he.gongmin", "passwordpass", "He", "Gongmin", "Turkish", 10130);
INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES ("cam.galian", "madrid9897", "Carmelita", "Galiano", "Turkish", 10131);
INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES ("kron.helene", "helenepass", "Helene", "Kron", "French", 10130);
INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES ("peter.weir", "peter_weir879", "Peter", "Weir", "Spanish", 10131);
INSERT INTO Directors (username, _password, _name, surname, nation, platform_id) VALUES ("kyle.balda", "mynameiskyle9", "Kyle", "Balda", "German", 10132);

INSERT INTO Genre (genre_id, genre_name) VALUES (80001, "Animation");
INSERT INTO Genre (genre_id, genre_name) VALUES (80002, "Comedy");
INSERT INTO Genre (genre_id, genre_name) VALUES (80003, "Adventure");
INSERT INTO Genre (genre_id, genre_name) VALUES (80004, "Real Story");
INSERT INTO Genre (genre_id, genre_name) VALUES (80005, "Thriller");
INSERT INTO Genre (genre_id, genre_name) VALUES (80006, "Drama");

INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20001, "Despicable Me", 2, "kyle.balda", 5);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20002, "Catch Me If You Can", 2, "he.gongmin", null);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20003, "The Bone Collector", 2, "cam.galian", null);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20004, "Eagle Eye", 2, "kron.helene", 5);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20005, "Minions: The Rise of Gru", 1, "kyle.balda", 5);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20006, "The Minions", 1, "kyle.balda", 5);
INSERT INTO Movie (movie_id, movie_name, duration, director_username, average_rating) VALUES (20007, "The Truman Show", 3, "peter.weir", 5);

INSERT INTO Predecessor_Movies (predecessor_id, successor_id) VALUES (20001, 20005);
INSERT INTO Predecessor_Movies (predecessor_id, successor_id) VALUES (20006, 20005);
INSERT INTO Predecessor_Movies (predecessor_id, successor_id) VALUES (20001, 20006);

INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20001, 80001);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20001, 80002);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20002, 80003);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20002, 80004);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20003, 80005);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20004, 80003);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20005, 80001);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20005, 80002);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20006, 80001);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20006, 80002);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20007, 80002);
INSERT INTO Movie_Genre (movie_id, genre_id) VALUES (20007, 80006);

INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40001, "Sisli_1", 300, "Sisli");
INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40002, "Sisli_2", 200, "Sisli");
INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40003, "Besiktas1", 100, "Besiktas");
INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40004, "Besiktas2", 100, "Besiktas");
INSERT INTO Theater (theater_id, theater_name, theater_capacity, theater_district) VALUES (40005, "Besiktas3", 500, "Besiktas");

INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50001, 20001, 40001);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50002, 20001, 40001);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50003, 20001, 40002);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50004, 20002, 40002);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50005, 20003, 40003);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50006, 20004, 40003);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50007, 20005, 40004);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50008, 20006, 40004);
INSERT INTO Movie_Sessions (session_id, movie_id, theater_id) VALUES (50009, 20007, 40005);

INSERT INTO Buy_Ticket(username, session_id) VALUES ("steven.jobs", 50001);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("steve.wozniak", 50004);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("steve.wozniak", 50005);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("arzucan.ozgur", 50006);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("egemen.isguder", 50001);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("egemen.isguder", 50008);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("egemen.isguder", 50004);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("egemen.isguder", 50007);
INSERT INTO Buy_Ticket(username, session_id) VALUES ("busra.oguzoglu", 50009);

INSERT INTO Subscribed_To (username, platform_id) VALUES ("steven.jobs", 10130);
INSERT INTO Subscribed_To (username, platform_id) VALUES ("steven.jobs", 10131);
INSERT INTO Subscribed_To (username, platform_id) VALUES ("steve.wozniak", 10131);
INSERT INTO Subscribed_To (username, platform_id) VALUES ("arzucan.ozgur", 10130);
INSERT INTO Subscribed_To (username, platform_id) VALUES ("egemen.isguder", 10132);
INSERT INTO Subscribed_To (username, platform_id) VALUES ("busra.oguzoglu", 10131);

INSERT INTO Rate (username, movie_id, rating) VALUES ("egemen.isguder", 20001, 5);
INSERT INTO Rate (username, movie_id, rating) VALUES ("egemen.isguder", 20005, 5);
INSERT INTO Rate (username, movie_id, rating) VALUES ("egemen.isguder", 20006, 5);
INSERT INTO Rate (username, movie_id, rating) VALUES ("arzucan.ozgur", 20004, 5);
INSERT INTO Rate (username, movie_id, rating) VALUES ("busra.oguzoglu", 20007, 5);

INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50001, "2023-03-15", 1);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50002, "2023-03-15", 3);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50003, "2023-03-15", 1);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50004, "2023-03-15", 3);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50005, "2023-03-16", 1);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50006, "2023-03-16", 3);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50007, "2023-03-16", 1);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50008, "2023-03-16", 3);
INSERT INTO Movie_Time(session_id, _date, time_slot) VALUES (50009, "2023-03-16", 1);

INSERT INTO Database_Managers (username, _password) VALUES ("manager1", "managerpass1");
INSERT INTO Database_Managers (username, _password) VALUES ("manager2", "managerpass2");
INSERT INTO Database_Managers (username, _password) VALUES ("manager35", "managerpass35");


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