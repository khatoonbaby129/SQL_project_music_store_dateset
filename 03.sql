--1 - Find how much amount spent by each customer on artists? 
--Write a query to return customer_name, artist_name, spent_amount

with best_selling_artist as (
select artist.artist_id as artist_id, artist.name as artist_name,
sum(invoice_line.unit_price*invoice_line.quantity) as total_amount
from invoice_line
join track on track.track_id = invoice_line.track_id
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
group by 1
order by 3 desc
limit 1
)

select c.customer_id, c.first_name, c.last_name, bsa.artist_name, sum(il.unit_price*il.quantity) as amount_Spent
from invoice i
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id
join best_selling_artist bsa on bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc;


-- We want to find out most popular music genre for each country. We determine the most popular
--genre as the genre with the highest amount of purchases. Write a query to return each country
--along with the top genre for the countries where the maximum number of purchase is shared 
--return all genres

with popular_genre as (
select count (invoice_line.quantity) as purchase, customer.country, genre.name, genre.genre_id,
row_number() over(partition by customer.country order by count(invoice_line.quantity) desc )as RowNo
from invoice_line
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
group by 2, 3, 4
order by 2 asc, 1 desc 
)
select * from popular_genre where RowNo <= 1


---Write the query that determines the customer that has spent the most on music for each country.
--Write a query that returns the country along with the top customer and how much they spent. For countries
--where the top amount is spent is shared, provide all customers who spent this amount.

with customer_with_country as (
select customer.customer_id, first_name, last_name, billing_country, sum(total) as total_spending,
row_number() over(partition by billing_country order by sum(total) desc) as RowNo
from invoice
join customer on customer.customer_id = invoice.customer_id 
group by 1, 2, 3, 4
order by 4 asc, 5 desc)

select * from customer_with_country where RowNo <=1
	