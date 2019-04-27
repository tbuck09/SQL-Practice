USE sakila
;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT 
    first_name,
    last_name,
	address
FROM address
JOIN staff
ON address.address_id = staff.address_id
;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT
	first_name,
    last_name,
    SUM(amount) AS "total_august_sales"
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment_date LIKE "2005-08%"
GROUP BY payment.staff_id
;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT
	film.title,
-- 	film_actor.film_id,
	COUNT(actor_id) AS "number_of_actors"
FROM film_actor
JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id
;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT
	film.title,
    COUNT(film.title) AS "number_of_copies"
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible"
;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS "total_spending"
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name
;