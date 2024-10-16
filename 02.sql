1- who is the seniot most employee based on job title

select * from employee
order by levels desc
limit 1

2- Which countres have the most invoices?

select count(*) as c, billing_country
from invoice 
group by billing_country
order by c desc

3- What are top 3 values of total invoice?

select * from invoice
order by total desc
limit 3

4 - Which city has the best customer? We would like to throw apromotional Music festival
in the city we made the most money. Write a query that return one city that has the highest 
sum of invoice totals. Returns both the city & sum of all invoice totals

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc
--limit 1

5- Who is the best customer? The customer who has spent the most money will be declared the best customer
write a query that returns the person who has spent the most money

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on
customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

