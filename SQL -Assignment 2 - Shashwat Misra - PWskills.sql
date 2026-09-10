-- Question 1 --
-- Display the names of customers who have rented more movies than the average number of rentals made by all customers.
-- Answer 1 --

USE mavenmovies;
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > (
    SELECT AVG(rental_count)
    FROM (
        SELECT COUNT(rental_id) AS rental_count
        FROM rental
        GROUP BY customer_id
    ) AS avg_rentals
);


-- Question 2 --
-- Display each film along with its rental rate and assign a rank based on rental rate from highest to lowest.
-- Answer 2 --

SELECT title,
rental_rate,
RANK() OVER (ORDER BY rental_rate DESC) AS rate_rank
FROM film;


-- Question 3 --
-- Create a view that displays customer names along with their email and active status.
-- Answer 3 --

CREATE VIEW customer_contact_status AS
SELECT CONCAT(first_name, ' ', last_name) AS customer_name,
email,
active
FROM customer;


-- Question 4 --
-- Find the top 10 customers who generated the highest payment amount.
-- Answer 4 --

SELECT c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_payment DESC
LIMIT 10;


-- Question 5 --
-- Identify the customers whose total spending on rentals falls within the top 20% of all customers.
-- Answer 5 --

WITH customer_spending AS (
SELECT c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
SUM(p.amount) AS total_spent,
PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS p_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, customer_name, total_spent
FROM customer_spending
WHERE p_rank <= 0.20;


-- Question 6 --
-- Display every actor along with the number of movies they acted in and assign Dense Rank based on movie count.
-- Answer 6 --

SELECT a.actor_id,
CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
COUNT(fa.film_id) AS movie_count,
DENSE_RANK() OVER (ORDER BY COUNT(fa.film_id) DESC) AS movie_count_rank
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;


-- Question 7 --
-- Create a view showing movie title, category, rental rate and replacement cost.
-- Answer 7 --

CREATE VIEW film_details_view AS
SELECT f.title,
c.name AS category,
f.rental_rate,
f.replacement_cost
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;


-- Question 8 --
-- Create a stored procedure that returns the top 20 most rented movies.
-- Answer 8 --

DELIMITER //

CREATE PROCEDURE GetTop20MostRentedMovies()
BEGIN
SELECT f.film_id,
f.title,
COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 20;
END //

DELIMITER ;


-- Question 9 --
-- Create a procedure that accepts a movie rating and returns all movies of that rating.
-- Answer 9 --

DELIMITER //

CREATE PROCEDURE GetMoviesByRating(IN p_rating VARCHAR(10))
BEGIN
SELECT film_id, title, rating, rental_rate, replacement_cost
FROM film
WHERE rating = p_rating;
END //

DELIMITER ;


-- Question 10 --
-- Identify the top 3 films in each category based on their rental counts.
-- Answer 10 --

WITH film_rentals AS (
SELECT f.film_id,
f.title,
c.name AS category_name,
COUNT(r.rental_id) AS rental_count,
RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rnk
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, c.category_id, c.name
)
SELECT film_id, title, category_name, rental_count
FROM film_rentals
WHERE rnk <= 3;


-- Question 11 --
-- Calculate the running total of rentals per category, ordered by rental count.
-- Answer 11 --

WITH category_rentals AS (
SELECT c.name AS category_name,
COUNT(r.rental_id) AS rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name
)
SELECT category_name,
rental_count,
SUM(rental_count) OVER (ORDER BY rental_count DESC, category_name) AS running_total
FROM category_rentals;


-- Question 12 --
-- Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
-- Answer 12 --

WITH actor_pairs AS (
SELECT fa1.actor_id AS actor1_id,
fa2.actor_id AS actor2_id,
fa1.film_id
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT ap.film_id,
f.title,
CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name
FROM actor_pairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
JOIN film f ON ap.film_id = f.film_id;  


-- Question 13 --
-- Create a procedure that accepts a customer ID as input and returns the customer's total payment as an output parameter.
-- Answer 13 --

DELIMITER //

CREATE PROCEDURE GetCustomerTotalPayment(
IN p_customer_id INT,
OUT p_total_payment DECIMAL(10,2)
)
BEGIN
SELECT COALESCE(SUM(amount), 0.00)
INTO p_total_payment
FROM payment
WHERE customer_id = p_customer_id;
END //

DELIMITER ;