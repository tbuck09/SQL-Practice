USE sakila;
-- SELECT first_name,last_name FROM actor;

ALTER TABLE actor
DROP COLUMN Actor_Name;
ALTER TABLE actor
ADD COLUMN Actor_Name VARCHAR(95);

UPDATE actor SET Actor_Name = CONCAT(
	UCASE(SUBSTRING(first_name, 1, 1)),LOWER(SUBSTRING(first_name, 2)),
	" ",
	UCASE(SUBSTRING(last_name, 1, 1)),LOWER(SUBSTRING(last_name, 2))
);