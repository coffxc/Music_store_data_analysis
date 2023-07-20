
--Q1:Who is the senior most employee based on the job title?

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1

--Q2:Which Country has the most invoices?

SELECT COUNT(*)AS c,billing_country
FROM invoice
GROUP BY billing_country
ORDER BY 1  DESC;

--Q3.What are top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

--Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--Write a query that returns one city that has the highest sum of invoice totals. 
--Return both the city name & sum of all invoice totals

SELECT billing_country, SUM(total) AS total_sum
FROM invoice
GROUP BY billing_country;


Q5--Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--Write a query that returns the person who has spent the most money.*/


SELECT c.first_name,c.last_name,SUM(i.total) total
FROM Customer c
JOIN invoice i
ON c.customer_id=i.customer_id
GROUP BY c.customer_id
ORDER BY 3 DESC
LIMIT 1;



/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

--Q7 Let's invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT a.artist_id,a.name,COUNT(*) AS number_of_songs
FROM artist a
JOIN album al ON a.artist_id=al.artist_id
JOIN track t ON al.album_id=t.album_id
JOIN genre g ON t.genre_id=g.genre_id
WHERE g.name='Rock'
GROUP BY  a.artist_id
ORDER BY 3 DESC
LIMIT 10;


/* Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,milliseconds
FROM track
WHERE milliseconds>
(SELECT AVG(milliseconds) AS  avg_milliseconds 
FROM track)
ORDER BY 2 DESC


