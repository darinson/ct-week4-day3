-- 1. List all customers who live in Texas (use JOINs)
-- 5 names: Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still
SELECT first_name, last_name, district
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
-- 1406 rows
SELECT first_name, last_name, amount
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
-- 6 names: Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Tommy Collazo, Karl Seal
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
)

-- 4. List all customers that live in Nepal (use the city table) 
-- 1 customer - Kevin Schuler
SELECT first_name, last_name
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN(
		SELECT city_id
		FROM city
		WHERE country_id IN(
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
)

-- JOIN Style, to double check my work above
SELECT first_name, last_name, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
-- Jon Stephens had the most transactions (7304)
SELECT first_name, last_name, COUNT(payment_id) as Num_Transactions
FROM staff
LEFT JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY Num_Transactions DESC;

-- 6. How many movies of each rating are there? 
-- PG-13 = 223 movies
-- NC-17 = 210 movies
-- R = 195 movies
-- PG = 194 movies
-- G = 178 movies
SELECT rating, COUNT(film_id) as Num_Movies
FROM film
GROUP BY rating
ORDER BY Num_Movies DESC;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
-- 45 customers
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
)

--JOIN Style (to check if my subquery came out as expected)
SELECT first_name, last_name, amount
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 8. How many free rentals did our stores give away?
-- 24 free rentals were given away
SELECT COUNT(payment_id)
FROM payment
WHERE amount = 0;