USE sakila;

-- REMOVE FROM
SELECT * FROM address LIMIT 15;

SELECT * FROM staff LIMIT 15;

SELECT SUM(amount) FROM payment WHERE staff_id = 2 AND payment_date LIKE "2005-08%";
-- REMOVE TO

SELECT 
	address,
    first_name,
    last_name
FROM address
JOIN staff
ON address.address_id = staff.address_id;

SELECT
	first_name,
    last_name,
    SUM(amount),
    payment_date
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment_date LIKE "2005-08%"
GROUP BY payment.staff_id;

SELECT
	film.title,
	film_actor.film_id,
	COUNT(actor_id)
FROM film_actor
JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id;

SELECT
	film.title,
    COUNT(film.title)
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible"