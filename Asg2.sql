Use mavenmovies;
-- Q1 reterive total number of rental made in the sakilla db 
Select * from rental;
select count(*) from rental;
-- Q2 find the average rental duration of the movies rented from sakilla db
select * from film;
Select Avg(rental_duration) from  film;
--- String function
-- Q3  Display  the first name and last name of the customer in the upper case 
Select *  from customer ;
Select upper(First_name)As FN, Upper (last_name) As LN from customer;
-- Q4 Display the month along with rental date and display along with rental id 
select * from rental;
select Rental_id,month(rental_date) from rental;
-- group by 
-- Q5 reterive the count of rental for the each customer 
select customer_id, count(rental_id ) from rental group by customer_id;
-- Q6 find the revenue genrated by each store 
Select * from payment ;
Select * from staff;
Select Sum(p.amount)As total_amount,S.store_id from store s join staff st on s.store_id=st.store_id join payment p on st.staff_id=p.staff_id group by s.store_id;
-- Q7 Display the title of the movie customer first name ,last name who rented it --film ,inventory ,customer,rental
select * from film ;
select * from inventory;
select * from rental;
select f.title as title,C.First_name,C.Last_name from Film  f join inventory i on f.film_id= i.film_id join rental r on i.inventory_id=r.inventory_id
join customer c on c.customer_id=r.customer_id;
-- Q8  Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Select * from actor;
Select * from film_actor;
Select * from film;
Select a.first_name,a.last_name from actor a join film_actor fa on  fa.actor_id=a.actor_id join film f on f.film_id=fa.film_id where f.title='Gone with the wind';
-- Q9 Determine the total number of rentals for each category of movies. 
-- Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
Select * from film_category;
Select * from film;
Select * from Rental;
SELECT fc.category_id, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;
-- Q10 find the average rental rate in each langugae
Select * from language;
Select * from film ;
select l.name as language_name ,avg(f.rental_rate) from film f join language l on f.language_ID =l.language_ID group by l.name;
-- Q11 reterive the customer name along with the total amount they have spent on rental 
select concat(C.first_name ," ",c.last_name) as Full_name ,sum(p.amount)as total_amount from customer c join payment p on p.customer_id=c.customer_id join rental r on c.customer_id=r.customer_id group by c.customer_id;
-- Q12 list the title of movies rented by each customer in a particular city ( london ) 
Select c.first_name ,c.Last_name ,f.title as rented_movie from customer c join address a on c.address_id=a.address_id join city ci on ci.city_id=a.city_id join rental r on r.customer_id=c.customer_id join inventory i on i.inventory_id=r.inventory_id join film f on f.film_id=i.film_id where ci.city="London" order by c.first_name,c.last_name,f.title;
-- Q13 -- Display the top 5 rented movies along with the number of times they've been rented.
select f.title As movie_title ,count(*) as rental_count from film f join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id group by f.title order by Rental_count Desc limit 5;
-- Q14 -- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
WHERE s.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT s.store_id) = 2;