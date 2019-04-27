USE sakila;

-- 1a. Display the first and last names of all actors from the table actor.
ALTER TABLE actor
DROP COLUMN Actor_Name;
ALTER TABLE actor
ADD COLUMN actor_name VARCHAR(95);

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
UPDATE actor SET actor_name = CONCAT(
	UCASE(SUBSTRING(first_name, 1, 1)),LOWER(SUBSTRING(first_name, 2)),
	" ",
	UCASE(SUBSTRING(last_name, 1, 1)),LOWER(SUBSTRING(last_name, 2))
);