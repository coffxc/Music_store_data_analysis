# Music_store_data_analysis(using SQL)

## Project Objective:
To help the store undertstand its business growth by answering simple questions.

# Dataset used:
The dataset for this project has 11 tables: Employee, Customer, Invoice, InvoiceLine, Track, MediaType, Genre, Album, Artist, PlaylistTrack, and Playlist, as well as their associations.

![music_database_schema](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/22ef4412-92d9-4897-89fc-ba9167119bb1)

# Database and Tools:
The following Were the database and tools Used for a project:
+ PostgreSQL
+ pgAdmin4

# Questions to be answered:
+ Who is the senior most employee based on the job title?
+ Which Country has the most invoices?
+  What are top 3 values of total invoice?
+ Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.
+ Who is the best customer? The customer who has spent the most money will be declared the best customer.Write a query that returns the person who has spent the most money.
+ Write query to return the email, first name, last name, & Genre of all Rock Music listeners.Return your list ordered alphabetically by email starting with A.
+ Let's invite the artists who have written the most rock music in our dataset.Write a query that returns the Artist name and total track count of the top 10 rock bands.
+ Return all the track names that have a song length longer than the average song length.Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

# Solutions:
Q1. Who is the most senior employee based on job title? 

```sql
SELECT * FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1;
```

![Q1 answer](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/3a55c173-846b-4e77-8dab-d9ce0a79fef3)

Q2. Which countries have the most Invoices?

```sql
SELECT billing_country,COUNT(*) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY 2 DESC
```
![Q2](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/9b5bd677-7e86-47f8-9c39-31994a52a8e7)


Q3.What are top 3 values of total invoice?
```sql
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;
```
![Q3](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/e86b718d-c0f0-4670-8fd2-f5d12cee894d)

Q4. Which city has the best customers? 
- We would like to throw a promotional Music Festival in the city we made the most money. 
- Write a query that returns one city that has the highest sum of invoice totals. 
- Return both the city name & sum of all invoice totals.
```sql
SELECT billing_city,SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY 2 DESC
LIMIT 1;
```
![Q4](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/674f1072-83b9-43ba-a60c-eb80a96d3656)

Q5. Who is the best customer? 
- The customer who has spent the most money will be declared the best customer. 
- Write a query that returns the person who has spent the most money.

```sql
SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, SUM(I.TOTAL) AS TOTAL_AMOUNT
FROM CUSTOMER AS C
JOIN INVOICE AS I
ON C.CUSTOMER_ID = I.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID
ORDER BY TOTAL_AMOUNT DESC
LIMIT 1;
```
![q5](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/1a3c4340-5e4f-460d-82b0-05f175e7d32d)

Q6. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
- Return your list ordered alphabetically by email starting with A.

```sql
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
```
![q6](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/4dee57d5-45d0-4cbe-b6a8-40e997478b03)


Q7. Let's invite the artists who have written the most rock music in our dataset. 
- Write a query that returns the Artist name and total track count of the top 10 rock bands.

```sql
SELECT a.artist_id,a.name,COUNT(*) AS number_of_songs
FROM artist a
JOIN album al ON a.artist_id=al.artist_id
JOIN track t ON al.album_id=t.album_id
JOIN genre g ON t.genre_id=g.genre_id
WHERE g.name='Rock'
GROUP BY  a.artist_id
ORDER BY 3 DESC
LIMIT 10;
```
![q7](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/7198c966-cf3d-49da-9e72-c332d942e262)

Q8. Return all the track names that have a song length longer than the average song length. 
- Return the Name and Milliseconds for each track. 
- Order by the song length with the longest songs listed first.

```sql
SELECT name,milliseconds
FROM track
WHERE milliseconds>
(SELECT AVG(milliseconds) AS  avg_milliseconds 
FROM track)
ORDER BY 2 DESC
```
![q8](https://github.com/coffxc/Music_store_data_analysis/assets/102975079/611c1f6b-c1a1-45ff-8bc2-510dc5a301fd)


