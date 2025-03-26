/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */





SELECT Name, Title, "total rentals"
FROM (
    SELECT Name, Title, COUNT(*) AS "total rentals",
           RANK() OVER (
               PARTITION BY Name
               ORDER BY COUNT(*) DESC, Title DESC
           ) AS Rank
    FROM Category
    JOIN Film_Category USING (Category_ID)
    JOIN Film USING (Film_ID)
    JOIN Inventory USING (Film_ID)
    JOIN Rental USING (Inventory_ID)
    GROUP BY Name, Title
) Sub
WHERE Rank < 6
ORDER BY Name, "total rentals" DESC, Title;











