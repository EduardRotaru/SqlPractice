-----------------------------------------------------  MOVIES DATABASE --------------------------------------------------
-----------------------------------------------------  BASIC QUERIES ----------------------------------------------------

-- 1. Write a query in SQL to find the name and year of the movies.
SELECT mov_title, mov_year                       
FROM movie

-- 2. Write a query in SQL to find the year when the movie American Beauty released. 
SELECT mov_title, mov_year   
FROM movie
WHERE mov_title = 'American Beauty'

-- 3. Write a query in SQL to find the movie which was released in the year 1999.
SELECT mov_title, mov_year   
FROM movie
WHERE mov_year = 1999

-- 4. Write a query in SQL to find the movies which was released before 1998.
SELECT mov_title, mov_year   
FROM movie
WHERE mov_year < 1998
ORDER BY mov_year DESC

-- 5. Write a query in SQL to return the name of all reviewers and name of movies together in a single list. 
SELECT * 
FROM movie, reviewer

-- 6. Write a query in SQL to find the name of all reviewers who have rated 7 or more stars to their rating.
SELECT * 
FROM reviewer re
INNER JOIN rating ra ON ra.rev_id = re.rev_id
WHERE ra.rev_stars >= 7 AND re.rev_name IS NOT NULL

-- 7. Write a query in SQL to find the titles of all movies that have no ratings. 
SELECT * 
FROM movie re
LEFT JOIN rating ra ON ra.mov_id  = re.mov_id 
WHERE ra.rev_stars IS NULL

-- 8. Write a query in SQL to find the titles of the movies with ID 905, 907, 917.
SELECT * 
FROM movie 
WHERE mov_id IN(905, 907, 917)

-- 9. Write a query in SQL to find the list of all those movies with year which include the words Boogie Nights. 
SELECT * 
FROM movie 
WHERE mov_title = 'Boogie Nights'

-- 10. Write a query in SQL to find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'. 
SELECT * 
FROM actor 
WHERE act_fname = 'Woody' AND act_lname = 'Allen'    


-----------------------------------------------------  SUBQUERIES ------------------------------------------------------

-- 1. Write a query in SQL to list all the information of the actors who played a role in the movie 'Annie Hall'.  
SELECT *
FROM actor
WHERE act_id =(SELECT act_id 
			  FROM movie_cast	
			  WHERE mov_id = (SELECT mov_id 
							 FROM movie
							 WHERE mov_title = 'Annie Hall'))

-- 2. Write a query in SQL to find the name of the director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'. (using subquery)
SELECT dir_fname, dir_lname
FROM director
WHERE dir_id = (SELECT dir_id 
				FROM movie_direction
			   	WHERE mov_id = (SELECT mov_id
							   FROM movie_cast
							   WHERE mov_id =(SELECT mov_id 
											 FROM movie
											 WHERE mov_title = 'Eyes Wide Shut')))

-- 3. Write a query in SQL to list all the movies which released in the country other than UK. 
SELECT * 
FROM movie
WHERE movie_id = (SELECT movie_id
				 FROM movie
				 WHERE mov_rel_country <> 'UK')
-- 4. Write a query in SQL to find the movie title, year, date of release, director and actor for those movies which reviewer is unknown. 


-- 5. Write a query in SQL to find the titles of all movies directed by the director whose first and last name are Woddy Allen. 
-- 6. Write a query in SQL to find all the years which produced at least one movie and that received a rating of more than 3 stars. Show the results in increasing order.
-- 7. Write a query in SQL to find the titles of all movies that have no ratings. 
-- 8. Write a query in SQL to find the names of all reviewers who have ratings with a NULL value.
-- 9. Write a query in SQL to return the reviewer name, movie title, and stars for those movies which reviewed by a reviewer and must be rated. Sort the result by reviewer name, movie title, and number of stars.
-- 10. Write a query in SQL to find the reviewer's name and the title of the movie for those reviewers who rated more than one movies. 
-- 11. Write a query in SQL to find the movie title, and the highest number of stars that movie received and arranged the result according to the group of a movie and the movie title appear alphabetically in ascending order.
-- 12. Write a query in SQL to find the names of all reviewers who rated the movie American Beauty. 
-- 13. Write a query in SQL to find the titles of all movies which have been reviewed by anybody except by Paul Monks. 
-- 14. Write a query in SQL to return the reviewer name, movie title, and number of stars for those movies which rating is the lowest one.
-- 15. Write a query in SQL to find the titles of all movies directed by James Cameron. 
-- 16. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. 

-----------------------------------------------------  JOINS ---------------------------------------------------------

-- 1. Write a query in SQL to find the name of all reviewers who have rated their ratings with a NULL value. 
-- 2. Write a query in SQL to list the first and last names of all the actors who were cast in the movie 'Annie Hall', and the roles they played in that production. 
-- 3. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role for 'Eyes Wide Shut'. 
-- 4. Write a query in SQL to find the name of movie and director (first and last names) who directed a movie that casted a role as Sean Maguire.
-- 5. Write a query in SQL to list all the actors who have not acted in any movie between 1990 and 2000. 
-- 6. Write a query in SQL to list first and last name of all the directors with number of genres movies the directed with genres name, and arranged the result alphabetically with the first and last name of the director. 
-- 7. Write a query in SQL to list all the movies with year and genres. 
-- 8. Write a query in SQL to list all the movies with year, genres, and name of the director. 
-- 9. Write a query in SQL to list all the movies with title, year, date of release, movie duration, and first and last name of the director which released before 1st january 1989, and sort the result set according to release date from highest date to lowest. 
-- 10. Write a query in SQL to compute a report which contain the genres of those movies with their average time and number of movies for each genres. 
-- 11. Write a query in SQL to find those lowest duration movies along with the year, director's name, actor's name and his/her role in that production. 
-- 12. Write a query in SQL to find all the years which produced a movie that received a rating of 3 or 4, and sort the result in increasing order.
-- 13. Write a query in SQL to return the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars. 
-- 14. Write a query in SQL to find movie title and number of stars for each movie that has at least one rating and find the highest number of stars that movie received and sort the result by movie title. 
-- 15. Write a query in SQL to find the director's first and last name together with the title of the movie(s) they directed and received the rating.
-- 16. Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies.
-- 17. Write a query in SQL to find the first and last name of a director and the movie he or she directed, and the actress appeared which first name was Claire and last name was Danes along with her role in that movie. 
-- 18. Write a query in SQL to find the first and last name of an actor with their role in the movie which was also directed by themselve. 
-- 19. Write a query in SQL to find the cast list for the movie Chinatown. 
-- 20. Write a query in SQL to find the movie in which the actor appeared whose first and last name are 'Harrison' and 'Ford'. 
-- 21. Write a query in SQL to find the highest-rated movie, and report its title, year, rating, and releasing country. 
-- 22. Write a query in SQL to find the highest-rated Mystery movie, and report the title, year, and rating.
-- 23. Write a query in SQL to generate a report which shows the year when most of the Mystery movies produces, and number of movies and their average rating.
-- 24. Write a query in SQL to generate a report which contain the columns movie title, name of the female actor, year of the movie, role, movie genres, the director, date of release, and rating of that movie.


