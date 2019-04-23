-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW top_five_genres AS
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

-- 8b. How would you display the view that you created in 8a?
SELECT * FROM top_five_genres;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_five_genres
