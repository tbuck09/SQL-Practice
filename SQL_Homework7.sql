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

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT
	first_name,
    last_name,
    email,
    customer.address_id
FROM customer
JOIN
	(SELECT
		address_id
	FROM address
	JOIN
		(SELECT
			city_id
		FROM city
		JOIN
			(SELECT
				country_id
			FROM country
			WHERE country = "Canada"
			) AS canada
		ON city.country_id = canada.country_id
		) AS canada_city
	ON address.city_id = canada_city.city_id
	) AS canada_address
ON customer.address_id = canada_address.address_id
;

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT
	title
FROM film
JOIN
	(SELECT
		film_id
	FROM film_category
	JOIN
		(SELECT
			category_id
		FROM category
		WHERE name = "Family"
		) AS family_film
	ON film_category.category_id = family_film.category_id
	) AS family_film_id
ON film.film_id = family_film_id.film_id
;

-- 7e. Display the most frequently rented movies in descending order.
SELECT
	title,
    film_times_rented
FROM film
JOIN
	(SELECT
		film_id,
		SUM(inventory_id_counts.inventory_times_rented) AS film_times_rented
	FROM inventory
	JOIN
		(SELECT 
			inventory_id,
			COUNT(inventory_id) AS inventory_times_rented
		FROM rental
		GROUP BY inventory_id
		) AS inventory_id_counts
	ON inventory.inventory_id = inventory_id_counts.inventory_id
	GROUP BY film_id
	) AS film_id_counts
ON film.film_id = film_id_counts.film_id
ORDER BY film_times_rented DESC