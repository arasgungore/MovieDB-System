USE Project1;

DROP TABLE Database_Managers;   -- No entity uses its attributes as foreign key, can be safely dropped.

DROP TABLE Predecessor_Movies;  -- No entity uses its attributes as foreign key, can be safely dropped.

DROP TABLE Movie_Time;  -- No entity uses its attributes as foreign key, can be safely dropped.

DROP TABLE Buy_Ticket;  -- No entity uses its attributes as foreign key, can be safely dropped.

DROP TABLE Movie_Sessions;  -- Buy_Ticket and Movie_Time uses its attributes as foreign key, since they are dropped can be safely dropped.

DROP TABLE Theater;     -- Movie_Sessions uses its attributes as foreign key, since it is dropped can be safely dropped.

DROP TABLE Movie_Genre; -- No entity uses its attributes as foreign key, can be safely dropped.

DROP TABLE Rate;        -- No entity uses its attributes as foreign key, can be safely dropped.

DROP TABLE Movie;       -- Rate, Movie_Genre, Predecessor_Movies uses its attributes as foreign key, since they are dropped can be safely dropped.

DROP TABLE Genre;       -- Movie_Genre uses its attributes as foreign key, since it is dropped can be safely dropped.

DROP TABLE Subscribed_To;   -- No entity uses its attributes as foreign key, can be safely dropped.

DROP TABLE Directors;       -- Movie uses its attributes as foreign key, since it is dropped can be safely dropped.

DROP TABLE Audience;        -- Subscribed_To and Rate uses its attributes as foreign key, since they are dropped can be safely dropped.

DROP TABLE Rating_Platform; -- Directors and Subscribed_To uses its attributes as foreign key, since they are dropped can be safely dropped.