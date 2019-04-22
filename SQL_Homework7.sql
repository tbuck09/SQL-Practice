USE sakila;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT
	title
FROM
	(SELECT
		title,
		film.language_id,
		language.name
	FROM film
	JOIN language
	ON film.language_id = language.language_id
	WHERE film.language_id = 1
	) AS english_films
WHERE title LIKE "K%" OR title LIKE "Q%";

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT 
	actor_name AS alone_trip_actor_name
FROM actor
JOIN
	(SELECT
		film.title,
		film.film_id,
		film_actor.actor_id
	FROM film
	JOIN film_actor
	ON film.film_id = film_actor.film_id
	WHERE film.title = "Alone Trip"
	) AS alone_trip_actors
ON actor.actor_id = alone_trip_actors.actor_id
;

