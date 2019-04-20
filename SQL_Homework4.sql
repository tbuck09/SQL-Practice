USE sakila;
SELECT last_name,COUNT(last_name) FROM actor GROUP BY last_name;

SELECT last_name,COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) >= 2;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";


UPDATE actor
SET first_name = CASE
	WHEN first_name = "HARPO" AND last_name = "WILLIAMS" THEN first_name = "GROUCHO"
    ELSE first_name
END