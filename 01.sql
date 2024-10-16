-- moderate questions
--1- Write the query to return email, first_name, last_name, Genreof all rock music listeners.
--Return your list alphabetically by email starting with A

select distinct email, first_name, last_name from customer
join invoice on
customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in( select track_id from track
					join genre on track.genre_id = genre.genre_id
					where genre.name like 'Rock'
)
order by email;

select * from track;

--2 - let's invite the artist who have written the most rock music in our dateset. Write the query that returns
--the artist name and total track counts of the top 10 rock bands.

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album on
album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10


--3 - Return all the tracks name that have a song length longer than the average song length. return the
--name and miliseconds for each track. Order by the song length with the longest songs listed first.

select name, milliseconds
from track
where milliseconds > (select avg(milliseconds) as avg_track_length from track)
order by milliseconds desc;