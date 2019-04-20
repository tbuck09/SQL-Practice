USE sakila;
SELECT * FROM actor WHERE first_name LIKE "JOE";

SELECT * FROM actor WHERE last_name LIKE "%GEN%";

SELECT * FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;

SELECT country_id, country FROM country WHERE country in ("Afghanistan","Bangladesh","China");