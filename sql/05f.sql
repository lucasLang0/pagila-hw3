/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

WITH AmericanCircusCategories AS (
    SELECT category_id
    FROM film_category
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
),
AmericanCircusActors AS (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
),
MoviesWithCategories AS (
    SELECT film_id
    FROM film_category
    WHERE category_id IN (SELECT category_id FROM AmericanCircusCategories)
    GROUP BY film_id
    HAVING COUNT(DISTINCT category_id) >= 2
),
MoviesWithActors AS (
    SELECT film_id
    FROM film_actor
    WHERE actor_id IN (SELECT actor_id FROM AmericanCircusActors)
)
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id FROM MoviesWithCategories
    INTERSECT
    SELECT film_id FROM MoviesWithActors
);


