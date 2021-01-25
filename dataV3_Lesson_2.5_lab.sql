-- # Lab | SQL Queries - Lesson 2.5

-- 1. Select all the actors with the first name ‘Scarlett’.
select * from sakila.actor
where first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?
select
	count(*) as films_available,
    count(distinct film_id) as titles_available
from sakila.inventory;
select
    count(*) as films_rented
from sakila.rental;

-- 3. What are the shortest and longest movie duration? Name the values `max_duration` and `min_duration`.
select
	max(length) as max_duration,
    min(length) as min_duration
from sakila.film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?
select
    time_format(str_to_date(concat(floor(avg(length)/60),',',round(avg(length)%60)), '%H,%i'), '%H:%i') as average_length
from sakila.film;

-- 5. How many distinct (different) actors' last names are there?
select
	count(distinct last_name) as distinct_last_names
from sakila.actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
select
    datediff(current_date(), str_to_date(min(rental_date), '%Y-%m-%d')) as days_operating
from sakila.rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
select
	*,
    month(rental_date) as month,
    dayname(rental_date) as weekday
from sakila.rental
limit 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select
	*,
    dayname(rental_date) as weekday,
    case
		when weekday(rental_date) in (0,1,2,3,4) then 'workday'
        when weekday(rental_date) in (5,6) then 'weekend'
	end as day_type
from sakila.rental;

-- 9. How many rentals were in the last month of activity?
select
	*,
    year(rental_date) as year,
    month(rental_date) as month,
    count(*) as rentals
from sakila.rental
group by year(rental_date), month(rental_date)
order by rental_date desc;