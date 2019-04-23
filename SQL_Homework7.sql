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
;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT
	store.store_id,
    SUM(amount) AS store_revenue
FROM store
JOIN
	(SELECT
		rental_amounts.amount,
		staff.staff_id,
		staff.store_id
	FROM staff
	JOIN
		(SELECT
			amount,
			payment.rental_id,
			rental.staff_id
		FROM payment
		JOIN rental
		ON payment.rental_id = rental.rental_id
		) AS rental_amounts
	ON staff.staff_id = rental_amounts.staff_id
	) AS staff_sales
ON store.store_id = staff_sales.store_id
GROUP BY store.store_id
;

-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT
	store_id,
    city,
    country
FROM country
JOIN
	(SELECT
		store_id,
		city,
		country_id
	FROM city
	JOIN
		(SELECT
			city_id,
			store_id
		FROM store
		JOIN address
		ON store.address_id = address.address_id
		) AS city_store_id
	ON city.city_id = city_store_id.city_id
	) AS city_country_id
ON country.country_id = city_country_id.country_id
;

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT
	name,
	SUM(amount) AS revenue
FROM category
JOIN
	(SELECT
		amount,
		category_id
	FROM film_category
	JOIN
		(SELECT
			amount,
			film_id
		FROM inventory
		JOIN
			(SELECT
				amount,
				inventory_id
			FROM payment
			JOIN rental
			ON payment.rental_id = rental.rental_id
			) AS rental_amount
		ON inventory.inventory_id = rental_amount.inventory_id
		) AS inventory_amount
	ON film_category.film_id = inventory_amount.film_id
	) AS film_amount
ON category.category_id = film_amount.category_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 5
;