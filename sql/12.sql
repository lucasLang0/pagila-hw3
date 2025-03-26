/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */





SELECT 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name
FROM customer
LEFT JOIN LATERAL (
    SELECT 
        customer_id, 
        category_id
    FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
    WHERE name = 'Action'
    AND rental.customer_id = customer.customer_id
    LIMIT 5
) recent ON true
GROUP BY 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name
HAVING 
    COUNT(CASE WHEN category_id = (
        SELECT category_id 
        FROM category 
        WHERE name = 'Action'
    ) THEN 1 END) = 4
ORDER BY customer_id;

