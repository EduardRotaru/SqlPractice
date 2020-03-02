-----------------------------------------------------  SOCCER DATABASE --------------------------------------------------
-----------------------------------------------------  BASIC QUERIES ----------------------------------------------------

-- 1. Write a query in SQL to find the number of venues for EURO cup 2016. 
SELECT COUNT(venue_id)
FROM soccer_venue

-- 2. Write a query in SQL to find the number countries participated in the EURO cup 2016. 
SELECT COUNT(DISTINCT team_id)
FROM player_mast

-- 3. Write a query in SQL to find the number goals scored in EURO cup 2016 within normal play schedule. 
SELECT COUNT(*)
FROM goal_details
WHERE goal_schedule = 'NT'

-- 4. Write a query in SQL to find the number of matches ended with a result.
SELECT COUNT(*)
FROM match_mast
WHERE results <> 'DRAW'

-- 5. Write a query in SQL to find the number of matches ended with draws. 
SELECT COUNT(*)
FROM match_mast
WHERE results = 'WIN'

-- 6. Write a query in SQL to find the date when did Football EURO cup 2016 begin. 
SELECT play_date
FROM match_mast
ORDER BY play_date 
LIMIT 1

SELECT MIN(play_date)
FROM match_mast

-- 7. Write a query in SQL to find the number of self-goals scored in EURO cup 2016.
SELECT COUNT(*)
FROM goal_details
WHERE goal_type = 'O'

-- 8. Write a query in SQL to count the number of matches ended with a results in group stage. 
SELECT COUNT(*)
FROM match_mast
WHERE play_stage = 'G' AND results = 'WIN'

-- 9. Write a query in SQL to find the number of matches got a result by penalty shootout.  
SELECT COUNT(DISTINCT match_no)
FROM penalty_shootout

-- 10. Write a query in SQL to find the number of matches were decided on penalties in the Round of 16.
(SELECT COUNT(*)
FROM match_mast
WHERE play_stage = 'R' AND decided_by = 'P')

-- 11. Write a query in SQL to find the number of goal scored in every match within normal play schedule. 
SELECT match_no, COUNT(*)
FROM goal_details
WHERE goal_schedule = 'NT' 
GROUP BY match_no
ORDER BY match_no

-- 12. Write a query in SQL to find the match no, date of play, and goal scored for that match in which no stoppage time have been added in 1st half of play. 
SELECT match_no, play_date, goal_score 
FROM match_mast
WHERE stop1_sec = 0

-- 13. Write a query in SQL to find the number of matches ending with a goalless draw in group stage of play. 
SELECT COUNT(DISTINCT(match_no))
FROM match_details
WHERE goal_score = 0 AND play_stage = 'G' AND win_lose = 'D'

-- 14. Write a query in SQL to find the number of matches ending with only one goal win except those matches which was decided by penalty shootout.
SELECT *
FROM match_details 
WHERE goal_score = 1 AND decided_by <> 'P' AND win_lose = 'W'

-- 15. Write a query in SQL to find the total number of players replaced in the tournament.
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I'

-- 16. Write a query in SQL to find the total number of palyers replaced within normal time of play.
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I' AND play_schedule = 'NT'

-- 17. Write a query in SQL to find the number of players replaced in the stoppage time. 
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I' AND play_schedule = 'ET'

-- 18. Write a query in SQL to find the total number of players replaced in the first half of play. 
SELECT COUNT(*)
FROM player_in_out
WHERE play_schedule = 'NT' AND in_out = 'I' AND play_half = '1'

-- 19. Write a query in SQL to find the total number of goalless draws have there in the entire tournament.
SELECT COUNT(*)
FROM player_in_out
WHERE play_schedule = 'NT' AND in_out = 'I' AND play_half = '1'

-- 20. Write a query in SQL to fine the total number of players replaced in the extra time of play. 
SELECT COUNT(*)
FROM player_in_out
WHERE in_out = 'I' AND play_schedule = 'ET' 

-- 21. Write a query in SQL to compute a list to show the number of substitute happened in various stage of play for the entire tournament.
SELECT play_half, play_schedule, COUNT(*)
FROM player_in_out
WHERE in_out = 'I' 
GROUP BY play_half, play_schedule
ORDER BY play_half

-- 22. Write a query in SQL to find the number of shots taken in penalty shootout matches.
SELECT COUNT(*)
FROM penalty_shootout

-- 23. Write a query in SQL to find the number of shots socred goal in penalty shootout matches.
SELECT COUNT(*)
FROM penalty_shootout
WHERE score_goal = 'Y'

-- 24. Write a query in SQL to find the number of shots missed or saved in penalty shootout matches.
SELECT COUNT(*)
FROM penalty_shootout
WHERE score_goal = 'N'

SELECT team_id, score_goal, COUNT(*)
FROM penalty_shootout
GROUP BY team_id, score_goal

-- 25. Write a query in SQL to prepare a list of players with number of shots they taken in penalty shootout matches.
SELECT pm.player_name, sc.country_name, COUNT(*)
FROM penalty_shootout ps
INNER JOIN player_mast pm ON pm.player_id = ps.player_id
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id 
GROUP BY pm.player_name,  sc.country_name

-- 26. Write a query in SQL to find the number of penalty shots taken by the teams
SELECT sc.country_name, COUNT(*)
FROM penalty_shootout ps
INNER JOIN soccer_country sc ON sc.country_id = ps.team_id 
GROUP BY sc.country_name

-- 27. Write a query in SQL to find the number of booking happened in each half of play within normal play schedule. 
SELECT play_half, COUNT(*)
FROM player_booked 
WHERE play_schedule = 'NT'
GROUP BY play_half

-- 28. Write a query in SQL to find the number of booking happened in stoppage time.
SELECT COUNT(*)
FROM player_booked 
WHERE play_schedule = 'ST'

-- 29. Write a query in SQL to find the number of booking happened in extra time.
SELECT COUNT(*)
FROM player_booked 
WHERE play_schedule = 'ET'

-----------------------------------------------------  SUBQUERIES ------------------------------------------------------

-- 1. Write a query in SQL to find the teams played the first match of EURO cup 2016.
SELECT country_name 
FROM soccer_country
WHERE country_id IN (SELECT team_id 
				   FROM match_details 
				   WHERE match_no = 1)
				   
-- 2. Write a query in SQL to find the winner of EURO cup 2016.
SELECT country_name 
FROM soccer_country
WHERE country_id IN (SELECT team_id 
				   FROM match_details 
				   WHERE play_stage = 'F' 
					 	AND win_lose = 'W')

-- 3. Write a query in SQL to find the match with match no, play stage, goal scored, and the audience which was the heighest audience match.
SELECT match_no, play_stage, goal_score, audence 
FROM match_mast
WHERE audence = (SELECT MAX(audence)
				FROM match_mast)

-- 4. Write a query in SQL to find the match no in which Germany played against Poland 
SELECT match_no
FROM match_mast
WHERE team_id = (SELECT country_id
				FROM match_mast
				WHERE country_id )
				
-- 5. Write a query in SQL to find the match no, play stage, date of match, number of gole scored, and the result of the match where Portugal played against Hungary. 
SELECT match_no, play_stage, play_date, results, goal_score
FROM match_mast
WHERE match_no IN(SELECT match_no 
				 FROM match_details
				 WHERE team_id IN(SELECT country_id 
								 FROM soccer_country
								 WHERE country_abbr IN('POR','HUN')))
GROUP BY match_no 
HAVING COUNT(DISTINCT team_id)=2) -- using this because from the entire list of games in need to counts twice since they played same game

SELECT match_no, play_stage, play_date, results, goal_score
FROM match_mast
WHERE match_no IN(SELECT md.match_no
				 FROM match_details md
				 INNER JOIN soccer_country sc ON md.team_id = sc.country_id
				 WHERE sc.country_abbr IN('POR','HUN')
GROUP BY match_no 
HAVING COUNT(DISTINCT team_id)=2)

-- 6. Write a query in SQL to display the list of players scored number of goals in every matches.
SELECT match_no,country_name, player_name, COUNT(*)
FROM player_mast pm, goal_details gd, soccer_country sc
WHERE pm.player_id = gd.player_id 
	AND gd.team_id = sc.country_id 
GROUP BY match_no, country_name, player_name

SELECT match_no, country_name, player_name, COUNT(*)
FROM goal_details
JOIN soccer_country ON goal_details.team_id = soccer_country.country_id
JOIN player_mast ON goal_details.player_id = player_mast.player_id
GROUP BY match_no, country_name, player_name

-- 7. Write a query in SQL to find the teams who played the heighest audience match. 
SELECT *
FROM soccer_country
WHERE country_id IN(SELECT team_id 
				   FROM goal_details
				   WHERE match_no = (SELECT match_no
									FROM match_mast
									WHERE audence = (SELECT MAX(audence)
													FROM match_mast)))
					
-- 8. Write a query in SQL to find the player who scored the last goal for Portugal against Hungary.


-- 9. Write a query in SQL to find the 2nd highest stoppage time which had been added in 2nd half of play.
SELECT MAX(stop2_sec)
FROM match_mast
WHERE stop2_sec < (SELECT MAX(stop2_sec)
					   FROM match_mast)
					   
-- 10. Write a query in SQL to find the teams played the match where 2nd highest stoppage time had been added in 2nd half of play. 
SELECT country_name
FROM soccer_country
WHERE country_id IN(SELECT team_id 
				   FROM match_details
				   WHERE match_no = (SELECT match_no
									FROM match_mast
									WHERE stop2_sec = (SELECT MAX(stop2_sec)
													   FROM match_mast
													   WHERE stop2_sec <> (SELECT MAX(stop2_sec)
														                   FROM match_mast))))

-- 11. Write a query in SQL to find the match no, date of play and the 2nd highest stoppage time which have been added in the 2nd half of play.
SELECT match_no, play_date, MAX(stop2_sec)
FROM match_mast
WHERE stop2_sec <> (SELECT MAX(stop2_sec)
					   FROM match_mast)
GROUP BY match_no, play_date
ORDER BY MAX(stop2_sec) DESC
LIMIT 1

-- 12. Write a query in SQL to find the team which was defeated by Portugal in EURO cup 2016 final.
SELECT *
FROM soccer_country
WHERE country_id =(SELECT team_id 
				  FROM match_details
				  WHERE win_lose = 'L' AND play_stage = 'F')

-- 13. Write a query in SQL to find the club which supplied the most number of players to the 2016 EURO cup.


-- 14. Write a query in SQL to find the player and his jersey number Who scored the first penalty of the tournament.
SELECT player_name, jersey_no 
FROM player_mast
WHERE player_id = (SELECT player_id 
				  FROM goal_details
				  WHERE goal_type = 'P' AND goal_time = (SELECT MIN(goal_time)
									FROM goal_details
									WHERE goal_type = 'P' AND play_stage = 'G'))

-- 15. Write a query in SQL to find the player along with his team and jersey number who scored the first penalty of the tournament. 
	
	
-- 16. Write a query in SQL to find the player who was the goalkeeper for Italy in penalty shootout against Germany in Football EURO cup 2016.


-- 17. Write a query in SQL to find the number of Germany scored at the tournament. 


-- 18. Write a query in SQL to find the players along with their jersey no., and playing club, who were the goalkeepers for the England squad for 2016 EURO cup. 


-- 19. Write a query in SQL to find the players with other information under contract to Liverpool were in the Squad of England in 2016 EURO cup.


-- 20. Write a query in SQL to find the player with other infromation Who scored the last goal in the 2nd semi final i.e. 50th match in EURO cub 2016.


-- 21. Write a query in SQL to find the player Who was the captain of the EURO cup 2016 winning team from Portugal. 


-- 22. Write a query in SQL to find the number of players played for france in the final.


-- 23. Write a query in SQL to find the goalkeeper of the team Germany who didn't concede any goal in their group stage matches.


-- 24. Write a query in SQL to find the runners-up in Football EURO cup 2016.


-- 25. Write a query in SQL to find the maximum penalty shots taken by the teams. 


-- 26. Write a query in SQL to find the maximum number of penalty shots taken by the players.

-- #toohard
-- 27. Write a query in SQL to find the match no. where highest number of penalty shots taken.


-- 28. Write a query in SQL to find the match no. and teams who played the match where highest number of penalty shots had been taken.


-- 29. Write a query in SQL to find the player of portugal who taken the 7th kick against poland.
SELECT player_id 
FROM penalty_shootout
WHERE kick_no = 7 AND team_id IN(SELECT country_id 
				FROM soccer_country
				WHERE country_name IN('Portugal','Poland'))

-- 30. Write a query in SQL to find the stage of match where the penalty kick number 23 had been taken.
SELECT *  
FROM match_mast
WHERE decided_by = 'P' 
	AND match_no IN(SELECT match_no
				   FROM penalty_shootout
				   WHERE kick_id = 23)

-- 31. Write a query in SQL to find the venues where penalty shootout matches played.
SELECT *
FROM soccer_venue
WHERE venue_id IN(SELECT venue_id 
				 FROM match_mast 
				 WHERE decided_by = 'P' 
				  	AND match_no IN(SELECT match_no
				  					FROM penalty_shootout))

-- 32. Write a query in SQL to find the date when penalty shootout matches played.
SELECT play_date  
FROM match_mast
WHERE decided_by = 'P' 
	AND match_no IN(SELECT match_no
				   FROM penalty_shootout)

-- 33. Write a query in SQL to find the most quickest goal at the EURO cup 2016, after 5 minutes.
SELECT goal_id 
FROM goal_details
WHERE goal_time = (SELECT MIN(goal_time)
				  FROM goal_details
				  WHERE goal_time > 5)

-----------------------------------------------------  JOINS -----------------------------------------------------------

-- 1. Write a query in SQL to find the name of the venue with city where the EURO cup 2016 final match was played.
SELECT sv.venue_name, sc.city        
FROM soccer_venue sv
LEFT JOIN soccer_city sc ON sc.city_id = sv.city_id 
INNER JOIN match_mast m ON m.venue_id = sv.venue_id
WHERE m.play_stage = 'F'

-- 2. Write a query in SQL to find the number of goal scored by each team in every match within normal play schedule. 
SELECT sc.country_name, md.goal_score        
FROM match_details md
INNER JOIN soccer_country sc ON sc.country_id = md.team_id  
WHERE decided_by = 'N'

-- 3. Write a query in SQL to find 
	-- the total number of goals scored by each player within normal play schedule and arrange the result set according to the heighest to lowest scorer.
SELECT COUNT(gd.goal_id), pm.player_name       
FROM goal_details gd
INNER JOIN player_mast pm ON gd.player_id = pm.player_id  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id  
WHERE gd.goal_schedule  = 'NT'
GROUP BY pm.player_name   
ORDER BY COUNT(gd.goal_id) DESC, pm.player_name  

-- 4. Write a query in SQL to find the highest individual scorer in EURO cup 2016.
SELECT COUNT(gd.goal_id), pm.player_name       
FROM goal_details gd
INNER JOIN player_mast pm ON gd.player_id = pm.player_id  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id  
GROUP BY 2   
ORDER BY COUNT(gd.goal_id) DESC 
LIMIT 1

-- 5. Write a query in SQL to find the scorer of only goal along with his country and jersey number in the final of EURO cup 2016.
SELECT COUNT(gd.goal_id), pm.player_name, sc.country_name, pm.jersey_no       
FROM goal_details gd
INNER JOIN player_mast pm ON gd.player_id = pm.player_id  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id  
WHERE gd.play_stage = 'F'
GROUP BY 2, 3, 4   
HAVING COUNT(gd.goal_id) = 1
ORDER BY 2  

-- 6. Write a query in SQL to find the country where Football EURO cup 2016 held. 
SELECT DISTINCT sco.country_name  
FROM soccer_country sco
INNER JOIN soccer_city sci ON sco.country_id = sci.country_id  
INNER JOIN soccer_venue sv ON sci.city_id = sv.city_id  

-- 7. Write a query in SQL to find the player who socred first goal of EURO cup 2016. 
SELECT 
	pm.player_name, 
	pm.jersey_no,
	sc.country_name,
	gd.goal_time, 
	gd.play_stage,
	gd.goal_schedule, 
	gd.goal_half 
FROM soccer_country sc
INNER JOIN player_mast pm ON sc.country_id = pm.team_id   
INNER JOIN goal_details gd ON pm.player_id = gd.player_id   
WHERE gd.goal_id IN(SELECT goal_id  
					FROM goal_details
					WHERE goal_time =(SELECT MIN(goal_time)
									  FROM goal_details
					 				  WHERE play_stage = 'G'))

-- 8. Write a query in SQL to find the name and country of the referee who managed the opening match.
SELECT sc.country_name, rm.referee_name       
FROM soccer_country sc
INNER JOIN referee_mast rm ON sc.country_id = rm.country_id    
INNER JOIN match_mast mm ON rm.referee_id = mm.referee_id 
WHERE match_no = 1

-- 9. Write a query in SQL to find the name and country of the referee who managed the final match. 
SELECT sc.country_name, rm.referee_name       
FROM soccer_country sc
INNER JOIN referee_mast rm ON sc.country_id = rm.country_id    
INNER JOIN match_mast mm ON rm.referee_id = mm.referee_id 
GROUP BY sc.country_name, rm.referee_name, mm.match_no  
HAVING mm.match_no = (SELECT MAX(match_no)
						FROM match_mast)
						
SELECT sc.country_name, rm.referee_name       
FROM soccer_country sc
INNER JOIN referee_mast rm ON sc.country_id = rm.country_id    
INNER JOIN match_mast mm ON rm.referee_id = mm.referee_id 
WHERE play_stage = 'F'

-- 10. Write a query in SQL to find the name and country of the referee who assisted the referee in the opening match. 
SELECT asf.ass_ref_name, sc.country_name            
FROM asst_referee_mast asf
INNER JOIN soccer_country sc ON sc.country_id = asf.country_id 
INNER JOIN match_details md ON asf.ass_ref_id = md.ass_ref     
WHERE match_no = 1

-- 11. Write a query in SQL to find the name and country of the referee who assisted the referee in the final match. 
SELECT asf.ass_ref_name, sc.country_name            
FROM asst_referee_mast asf
INNER JOIN soccer_country sc ON sc.country_id = asf.country_id 
INNER JOIN match_details md ON asf.ass_ref_id = md.ass_ref     
WHERE play_stage = 'F'

-- 12. Write a query in SQL to find the city where the opening match of EURO cup 2016 played. 
SELECT sc.city, sv.venue_name      
FROM soccer_venue sv
LEFT JOIN soccer_city sc ON sv.city_id = sc.city_id 
INNER JOIN match_mast mm ON sv.venue_id = mm.venue_id 
WHERE match_no = 1

-- 13. Write a query in SQL to find the stadium hosted the final match of EURO cup 2016 along with the capacity, and audance for that match.
SELECT mm.audence, sv.venue_name, sv.aud_capacity      
FROM soccer_venue sv
INNER JOIN soccer_city sc ON sv.city_id = sc.city_id 
INNER JOIN match_mast mm ON sv.venue_id = mm.venue_id 
WHERE play_stage = 'F'

-- 14. Write a query in SQL to compute a report that contain the number of matches played in each venue along with their city.
SELECT COUNT(mm.match_no), sv.venue_name, sc.city            
FROM soccer_venue sv
INNER JOIN soccer_city sc ON sv.city_id = sc.city_id 
INNER JOIN match_mast mm ON sv.venue_id = mm.venue_id 
GROUP BY sv.venue_name, sc.city  

-- 15. Write a query in SQL to find the player who was the first player to be sent off at the tournament EURO cup 2016.
SELECT pm.player_name               
FROM player_booked pb
INNER JOIN player_mast pm ON pb.player_id = pm.player_id 
	AND pb.player_id = pm.player_id 
INNER JOIN soccer_country sc ON pb.team_id = sc.country_id 
WHERE pb.match_no = (SELECT MIN(match_no)
				  FROM player_booked
				  WHERE sent_off = 'Y')
ORDER BY pb.match_no
LIMIT 1

-- 16. Write a query in SQL to find the teams that scored only one goal to the torunament.
SELECT sco.country_name               
FROM soccer_team sc
INNER JOIN soccer_country sco ON sc.team_id = sco.country_id  
WHERE goal_for = 1

-- 17. Write a query in SQL to find the yellow cards received by each country.
SELECT sc.country_name, COUNT(pb.booking_time)         
FROM soccer_country sc
INNER JOIN player_booked pb ON sc.country_id = pb.team_id   
WHERE sent_off <> 'Y'
GROUP BY sc.country_name
ORDER BY sc.country_name

-- 18. Write a query in SQL to find the venue with number of goals that has seen. 
SELECT sv.venue_name, COUNT(gd.goal_id)
FROM soccer_country sc
INNER JOIN goal_details gd ON sc.country_id = gd.team_id 
INNER JOIN match_mast mm ON gd.match_no = mm.match_no 
INNER JOIN soccer_venue sv ON mm.venue_id = sv.venue_id 
GROUP BY sv.venue_name

-- 19. Write a query in SQL to find the match where no stoppage time added in 1st half of play.
SELECT mm.match_no, sc.country_name
FROM match_details md
INNER JOIN match_mast mm ON md.match_no = mm.match_no 
INNER JOIN soccer_country sc ON md.team_id = sc.country_id 
WHERE stop1_sec = 0

-- 20. Write a query in SQL to find the team(s) who conceded the most goals in EURO cup 2016.
SELECT sco.country_name, SUM(st.goal_agnst)
FROM soccer_team st
INNER JOIN soccer_country sco ON st.team_id = sco.country_id 
GROUP BY sco.country_name
ORDER BY SUM(st.goal_agnst) DESC

-- solution from website and I consider its wrong. From the question I understand she/he wants the team with most goals scored for the whole tournament not in a specific game.
	-- it happens to be Russia for both cases.
SELECT country_name,team_group,match_played,
won,lost,goal_for,goal_agnst
FROM soccer_team 
JOIN soccer_country 
ON soccer_team.team_id=soccer_country.country_id
WHERE goal_agnst=(
SELECT MAX(goal_agnst) 
FROM soccer_team);

-- 21. Write a query in SQL to find the match where highest stoppege time added in 2nd half of play.
SELECT mm.match_no, sc.country_name, MAX(stop2_sec)
FROM match_details md
INNER JOIN match_mast mm ON md.match_no = mm.match_no 
INNER JOIN soccer_country sc ON md.team_id = sc.country_id 
GROUP BY mm.match_no, sc.country_name 
ORDER BY MAX(stop2_sec) DESC
LIMIT 2 -- because there are 2 teams playing in the same match_no

-- 22. Write a query in SQL to find the matchs ending with a goalless draw in group stage of play.
SELECT sco.country_name, md.match_no 
FROM match_details md
INNER JOIN soccer_country sco ON md.team_id = sco.country_id 
WHERE play_stage = 'G' 
	AND goal_score = 0 
	AND win_lose = 'D'

-- 23. Write a query in SQL to find the match no. and the teams played in that match where the 2nd highest stoppage time had been added in the 2nd half of play.
SELECT mm.match_no, sc.country_name 
FROM match_mast mm
INNER JOIN match_details md ON mm.match_no = md.match_no 
INNER JOIN soccer_country sc ON md.team_id = sc.country_id 
WHERE mm.stop2_sec = (SELECT MAX(stop2_sec)
					 FROM match_mast
					 WHERE stop2_sec < (SELECT MAX(stop2_sec)
									   FROM match_mast))

-- 24. Write a query in SQL to find the player and his team and how many matches he kept goal for his team. 
SELECT DISTINCT pm.player_name, sc.country_name 
FROM player_mast pm
INNER JOIN match_details md ON pm.player_id = md.player_gk   
INNER JOIN soccer_country sc ON md.team_id = sc.country_id 
ORDER BY sc.country_name 

-- 25. Write a query in SQL to find the venue that has seen the most goals. 
SELECT sv.venue_name, COUNT(gd.goal_id)        
FROM goal_details gd
INNER JOIN soccer_country sc ON gd.team_id = sc.country_id 
INNER JOIN match_mast mm ON gd.match_no = mm.match_no  
INNER JOIN soccer_venue sv ON mm.venue_id = sv.venue_id 
GROUP BY sv.venue_name 
ORDER BY COUNT(gd.goal_id) DESC

-- 26. Write a query in SQL to find the oldest player to have appeared in a EURO cup 2016 match.
SELECT pm.player_name, sc.country_name, pm.age 
FROM player_mast pm	
INNER JOIN soccer_country sc ON pm.team_id = sc.country_id 
WHERE pm.age = (SELECT MAX(age)
			   	FROM player_mast)

-- 27. Write a query in SQL to find those two teams which scored three goals in a single game at this tournament.  
SELECT
FROM soccer_team st
INNER JOIN soccer_country sc ON st.team_id = sc.country_id

-- 28. Write a query in SQL to find the teams with other information that finished bottom of their respective groups after conceding four times in three games.
SELECT sc.country_name, st.team_id
FROM soccer_team st
INNER JOIN soccer_country sc ON st.team_id = sc.country_id
WHERE st.group_position = 4 
	AND st.goal_agnst = 4

-- 29. Write a query in SQL to find those three players with other information, who contracted to Lyon participated in the EURO cup 2016 Finals
SELECT DISTINCT pm.player_name
FROM player_mast pm
INNER JOIN soccer_country sc ON pm.team_id = sc.country_id 
INNER JOIN match_details md ON sc.country_id = md.team_id 
WHERE pm.playing_club = 'Lyon'

-- 30. Write a query in SQL to find the final four teams in the tournament.
SELECT sc.country_name
FROM soccer_country sc
INNER JOIN match_details md ON md.team_id = sc.country_id
WHERE md.play_stage = 'S'

-- 31. Write a query in SQL to find the captains for the top four teams with other information which participated in the semifinals (match 48 and 49) in the tournament. 
SELECT sc.country_name, pm.player_name       
FROM soccer_country sc
INNER JOIN match_captain mc ON sc.country_id = mc.team_id 
INNER JOIN player_mast pm ON mc.player_captain = pm.player_id 
WHERE mc.match_no IN(48, 49)

-- 32. Write a query in SQL to find the captains with other information for all the matches in the tournament. 
SELECT sc.country_name, pm.player_name       
FROM soccer_country sc
INNER JOIN match_captain mc ON sc.country_id = mc.team_id 
INNER JOIN player_mast pm ON mc.player_captain = pm.player_id 

-- 33. Write a query in SQL to find the captain and goal keeper with other information for all the matches for all the team.
SELECT DISTINCT sc.country_name, pm1.player_name AS "CPT", pm2.player_name AS "GK"
FROM match_details md
INNER JOIN player_mast pm1 ON pm1.team_id = md.team_id 
INNER JOIN match_captain mc ON pm1.player_id = mc.player_captain
INNER JOIN player_mast pm2 ON pm2.player_id = md.player_gk
INNER JOIN soccer_country sc ON mc.team_id = sc.country_id
ORDER BY 1

-- 34. Write a query in SQL to find the player who was selected for the Man of the Match Award in the finals of EURO cup 2016.
SELECT pm.player_name, sc.country_name       
FROM match_mast mm
INNER JOIN player_mast pm ON pm.player_id = mm.plr_of_match  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id
WHERE mm.play_stage = 'F'

-- 35. Write a query in SQL to find the substitute players who came into the field in the first half of play within normal play schedule. 
SELECT pm.player_name, sc.country_name, pi.time_in_out, pi.in_out         
FROM player_in_out pi
INNER JOIN player_mast pm ON pm.player_id = pi.player_id  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id
WHERE pi.play_half = 1 AND pi.play_schedule = 'NT'

-- 36. Write a query in SQL to prepare a list for the player of the match against each match. 
SELECT pm.player_name, mm.match_no, sc.country_name           
FROM match_mast mm
INNER JOIN player_mast pm ON pm.player_id = mm.plr_of_match  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id

-- 37. Write a query in SQL to find the player along with his country who taken the penalty shot number 26.
SELECT pm.player_name, sc.country_name           
FROM penalty_shootout ps
INNER JOIN player_mast pm ON pm.player_id = ps.player_id    
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id
WHERE ps.kick_id = 26

-- 38. Write a query in SQL to find the team against which the penalty shot number 26 had been taken.
SELECT ps.match_no, sc.country_name           
FROM penalty_shootout ps 
INNER JOIN soccer_country sc ON sc.country_id = ps.team_id
WHERE ps.match_no = (SELECT match_no 
					FROM penalty_shootout
					WHERE kick_id = 26)
						AND sc.country_name <> (SELECT country_name
											   FROM soccer_country
											   WHERE country_id IN(SELECT team_id
															   FROM penalty_shootout
															   WHERE kick_id = 26))
GROUP BY ps.match_no, sc.country_name   		

SELECT DISTINCT ps.match_no, sc.country_name           
FROM penalty_shootout ps 
INNER JOIN soccer_country sc ON sc.country_id = ps.team_id
WHERE ps.match_no = (SELECT match_no 
					FROM penalty_shootout
					WHERE kick_id = 26)
						AND sc.country_name <> (SELECT sc.country_name           
												FROM penalty_shootout ps 
												INNER JOIN soccer_country sc ON sc.country_id = ps.team_id
												WHERE kick_id = 26)
												
-- 39. Write a query in SQL to find the captain who was also the goalkeeper. 
SELECT DISTINCT pm.player_name, sc.country_name           
FROM match_captain mc
INNER JOIN soccer_country sc ON mc.team_id = sc.country_id 
INNER JOIN player_mast pm ON mc.player_captain = pm.player_id 
WHERE pm.posi_to_play = 'GK'

-- 40. Write a query in SQL to find the number of captains who was also the goalkeeper.
SELECT pm.player_name, sc.country_name, COUNT(pm.posi_to_play)           
FROM match_captain mc
INNER JOIN soccer_country sc ON mc.team_id = sc.country_id 
INNER JOIN player_mast pm ON mc.player_captain = pm.player_id 
WHERE pm.posi_to_play = 'GK'
GROUP BY pm.player_name, sc.country_name

-- 41. Write a query in SQL to find 
	-- the players along with their team booked number of times in the tournament. Show the result according to the team and number of times booked in descending order. 
SELECT pm.player_name, sc.country_name, COUNT(pb.*)           
FROM player_booked pb
INNER JOIN player_mast pm ON pb.player_id = pm.player_id  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id  
GROUP BY pm.player_name, sc.country_name
ORDER BY sc.country_name, COUNT(pb.*) DESC
	
-- 42. Write a query in SQL to find the players who booked most number of times. 
SELECT pm.player_name, sc.country_name, COUNT(pb.player_id)           
FROM player_booked pb
INNER JOIN player_mast pm ON pb.player_id = pm.player_id  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id  
GROUP BY pm.player_name, sc.country_name
HAVING COUNT(pb.player_id) = (SELECT MAX(topBookers.count)
							 FROM (SELECT COUNT(pb.player_id), pm.player_name
								  FROM player_booked pb
								  INNER JOIN player_mast pm ON pb.player_id = pm.player_id
								  GROUP BY pm.player_name) AS topBookers)
ORDER BY sc.country_name, COUNT(pb.*) DESC 

-- 43. Write a query in SQL to find the number of players booked for each team. 
SELECT sc.country_name, COUNT(pb.*)           
FROM player_booked pb
INNER JOIN soccer_country sc ON sc.country_id = pb.team_id    
GROUP BY sc.country_name
ORDER BY COUNT(pb.*) DESC

-- 44. Write a query in SQL to find the most number of cards shown in the matches.
SELECT pb.match_no, COUNT(pb.*)           
FROM player_booked pb
INNER JOIN player_mast pm ON pb.player_id = pm.player_id  
INNER JOIN soccer_country sc ON sc.country_id = pm.team_id  
GROUP BY pb.match_no
ORDER BY COUNT(pb.*) DESC

-- 45. Write a query in SQL to list the name of assistant referees with their countries for each matches.
SELECT pb.match_no, sc.country_name, pm.ass_ref_name       
FROM match_details pb
INNER JOIN asst_referee_mast pm ON pb.ass_ref = pm.ass_ref_id   
INNER JOIN soccer_country sc ON sc.country_id = pm.country_id  

-- 46. Write a query in SQL to find the assistant referees of each countries assists the number of matches. 
SELECT sc.country_name, pm.ass_ref_name, COUNT(DISTINCT pb.match_no)
FROM match_details pb
INNER JOIN asst_referee_mast pm ON pb.ass_ref = pm.ass_ref_id   
INNER JOIN soccer_country sc ON sc.country_id = pm.country_id  
GROUP BY sc.country_name, pm.ass_ref_name 
ORDER BY sc.country_name

-- 47. Write a query in SQL to find the countries from where the assistant referees assist most of the matches. 
SELECT sc.country_name, COUNT(DISTINCT md.match_no)
FROM match_details md
INNER JOIN asst_referee_mast arm ON arm.ass_ref_id = md.ass_ref 
INNER JOIN soccer_country sc ON sc.country_id = arm.country_id
GROUP BY sc.country_name
ORDER BY COUNT(DISTINCT md.match_no) DESC

-- 48. Write a query in SQL to list the name of referees with their countries for each match.
SELECT rm.referee_name, sc.country_name, mm.match_no 
FROM match_mast mm
INNER JOIN referee_mast rm ON rm.referee_id  = mm.referee_id  
INNER JOIN soccer_country sc ON sc.country_id = rm.country_id
ORDER BY rm.referee_name

-- 49. Write a query in SQL to find the referees of each country managed number of matches. 
SELECT rm.referee_name, sc.country_name, COUNT(mm.match_no) 
FROM match_mast mm
INNER JOIN referee_mast rm ON rm.referee_id  = mm.referee_id  
INNER JOIN soccer_country sc ON sc.country_id = rm.country_id
GROUP BY rm.referee_name, sc.country_name
ORDER BY COUNT(mm.match_no) DESC

-- 50. Write a query in SQL to find the countries from where the referees managed most of the matches.
SELECT sc.country_name, COUNT(mm.match_no) 
FROM match_mast mm
INNER JOIN referee_mast rm ON rm.referee_id  = mm.referee_id  
INNER JOIN soccer_country sc ON sc.country_id = rm.country_id
GROUP BY sc.country_name
ORDER BY COUNT(mm.match_no) DESC

-- 51. Write a query in SQL to find the referees managed the number of matches.
SELECT rm.referee_name, COUNT(mm.match_no) 
FROM match_mast mm
INNER JOIN referee_mast rm ON rm.referee_id  = mm.referee_id  
INNER JOIN soccer_country sc ON sc.country_id = rm.country_id
GROUP BY rm.referee_name
ORDER BY COUNT(mm.match_no) DESC

-- 52. Write a query in SQL to find those referees who managed most of the match.
SELECT rm.referee_name, sc.country_name, COUNT(mm.match_no) 
FROM match_mast mm
INNER JOIN referee_mast rm ON rm.referee_id  = mm.referee_id  
INNER JOIN soccer_country sc ON sc.country_id = rm.country_id
GROUP BY rm.referee_name, sc.country_name
HAVING COUNT(mm.match_no) = (SELECT MAX(topRefGames.countGames)
							FROM (SELECT rm.referee_name, COUNT(mm.match_no) AS countGames
								  FROM match_mast mm
								  INNER JOIN referee_mast rm ON rm.referee_id = mm.referee_id
								  GROUP BY rm.referee_name) AS topRefGames
							)
ORDER BY COUNT(mm.match_no) DESC

-- 53. Write a query in SQL to find the referees managed the number of matches in each venue.
SELECT rm.referee_name, sv.venue_name, COUNT(mm.match_no) 
FROM match_mast mm
INNER JOIN referee_mast rm ON rm.referee_id  = mm.referee_id  
INNER JOIN soccer_country sc ON sc.country_id = rm.country_id
INNER JOIN soccer_venue sv ON sv.venue_id = mm.venue_id 
GROUP BY rm.referee_name, sv.venue_name
ORDER BY rm.referee_name

-- 54. Write a query in SQL to find the referees and number of booked he made.  
SELECT rm.referee_name, COUNT(pb.booking_time) 
FROM match_mast mm
INNER JOIN player_booked pb ON pb.match_no = mm.match_no  
INNER JOIN referee_mast rm ON mm.referee_id = rm.referee_id 
GROUP BY rm.referee_name
ORDER BY COUNT(pb.booking_time) DESC

-- 55. Write a query in SQL to find the referees who booked most number of players.
SELECT rm.referee_name, COUNT(pb.player_id) 
FROM match_mast mm
INNER JOIN player_booked pb ON pb.match_no = mm.match_no  
INNER JOIN referee_mast rm ON mm.referee_id = rm.referee_id 
GROUP BY rm.referee_name
HAVING COUNT(pb.player_id) = (SELECT MAX(topBooked.playerCount)
							  FROM (SELECT rm.referee_name, COUNT(pb.player_id) AS playerCount
									FROM match_mast mm
									INNER JOIN player_booked pb ON pb.match_no = mm.match_no  
									INNER JOIN referee_mast rm ON mm.referee_id = rm.referee_id
									GROUP BY rm.referee_name) AS topBooked)

-- 56. Write a query in SQL to find the player of each team who wear jersey number 10. 
SELECT pm.player_name, sc.country_name       
FROM player_mast pm
INNER JOIN soccer_country sc ON pm.team_id = sc.country_id 
WHERE pm.jersey_no = 10
ORDER BY sc.country_name

-- 57. Write a query in SQL to find the defender who scored goal for his team. 
SELECT pm.player_name, sc.country_name       
FROM player_mast pm
INNER JOIN goal_details gd ON pm.player_id = gd.player_id 
									AND pm.team_id = gd.team_id
INNER JOIN soccer_country sc ON sc.country_id = gd.team_id
WHERE pm.posi_to_play = 'DF'
ORDER BY pm.player_name

-- 58. Write a query in SQL to find the position of a player to play who scored own goal.
SELECT pm.player_name, sc.country_name, pm.posi_to_play        
FROM player_mast pm
INNER JOIN goal_details gd ON pm.player_id = gd.player_id 
INNER JOIN soccer_country sc ON sc.country_id = gd.team_id
WHERE gd.goal_type = 'O'
ORDER BY pm.player_name

-- 59. Write a query in SQL to find the results of penalty shootout matches. 
SELECT DISTINCT match_no, sc.country_name
FROM match_details md
INNER JOIN soccer_country sc ON md.team_id = sc.country_id
WHERE md.decided_by = 'P' AND md.win_lose = 'W'

-- 60. Write a query in SQL to find the goal scored by the players according to their playing position. 
SELECT pm.player_name, sc.country_name, pm.posi_to_play, COUNT(gd.goal_id)        
FROM player_mast pm
INNER JOIN goal_details gd ON pm.player_id = gd.player_id 
INNER JOIN soccer_country sc ON sc.country_id = gd.team_id
GROUP BY pm.player_name, sc.country_name, pm.posi_to_play
ORDER BY sc.country_name, 
	CASE 
		WHEN pm.posi_to_play = 'FD' THEN 1
		WHEN pm.posi_to_play = 'DF' THEN 2
		WHEN pm.posi_to_play = 'MD' THEN 3
	END

-- 61. Write a query in SQL to find those players who came into the field in the most last time of play.
SELECT pio.time_in_out, pm.player_name, sc.country_name
FROM player_mast pm
INNER JOIN player_in_out pio ON pm.player_id = pio.player_id 
INNER JOIN soccer_country sc ON sc.country_id = pio.team_id
WHERE pio.in_out = 'I' AND pio.time_in_out = (SELECT MAX(time_in_out)
											 FROM player_in_out)
GROUP BY pio.time_in_out, pm.player_name, sc.country_name
ORDER BY MAX(pio.time_in_out) DESC
