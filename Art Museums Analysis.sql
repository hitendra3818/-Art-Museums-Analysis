create database Project2;
use Project2;

select * from artist;
select * from canvas_size;
select * from image_link;
select * from museum;
select * from museum_hours;
select * from product_size;
select * from subject;
select * from work;



/*1) How many paintings have an asking price of more than their regular price?*/

select count(*) as total_product from product_size
where sale_price > regular_price;


/*2) Identify the paintings whose asking price is less than 50% of its regular price*/

select * from product_size
where sale_price < (0.50 * regular_price);

/*3) Which canva size costs the most?*/

select * from canvas_size;
select * from product_size;

select a.label,b.sale_price 
from canvas_size as a inner join product_size as b
on
a.size_id = b.size_id
group by a.label,b.sale_price
order by b.sale_price desc limit 1;

/*4) Identify the museums with invalid city information in the given dataset*/

select * from museum
where city regexp '^[0-9]';


/*5) Fetch the top 10 most famous painting subject*/

select * from work;
select * from subject;
select * from product_size;

select  distinct a.subject,b.name , c.sale_price as cost
from subject as a inner join work as b
on 
a.work_id = b.work_id
inner join product_size as c
on 
a.work_id = c.work_id
group by a.subject,b.name,c.sale_price
order by c.sale_price desc limit 10;


/*6) Identify the museums which are open on both Sunday and Monday. Display museum name, city.*/

select * from museum;
select * from museum_hours;

select a.name,a.city,b.day
from museum as a inner join museum_hours as b
on
a.museum_id = b.museum_id
group by a.name,a.city,b.day
having b.day  in ('Sunday','Monday');

/*7) How many museums are open every single day?*/

select * from museum;
select * from museum_hours;

select count(*) from
(SELECT museum_id,COUNT(museum_id)
FROM museum_hours
GROUP BY museum_id
HAVING COUNT(day) =7) Count;

/*8)A Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)*/

select * from museum;
select * from work;

select a.museum_id,count(*),a.name as Museum
from museum as a left join work as b
on a.museum_id = b.museum_id
group by a.museum_id,a.name
order by count(*) desc limit 5;


/*9) Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)*/

select * from artist;
select * from work;

select a.full_name as Name_of_Artist,a.nationality ,count(*) as total_No_Painting
from artist as a left join work as b
on 
a.artist_id = b.artist_id
group by a.nationality,a.full_name
order by count(*) desc limit 5;



 /*10) Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?*/

select a.name,a.state, b.day, b.open-b.close as long_e
from museum as a inner join museum_hours as b
ON a.museum_id = b.museum_id
order by b.open-b.close desc
limit 1;


/*11)A Which museum has the most no of most popular painting style?*/
select a.name, b.style, count(*) as no_of_paint
from museum as a inner join work as b
on a.museum_id = b.museum_id
group by a.name, b.style
order by count(*) desc limit 1;

/*12) Identify the artists whose paintings are displayed in multiple countries*/
select a.full_name, a.style, count(*) as no_of_pain
from artist as a inner join work as b
on a.artist_id= b.artist_id
inner join museum as c
on a.museum_id = c.museum_id
group by a.full_name, a.style
order by count(*) desc limit 5;
select * from museum;
select * from artist;
select * from work;

select a.full_name ,a.style,count(*)

/*20) A Which country has the 5th highest no of paintings?*/

select m.country, count(*) as no_of_pain
from artist a
JOIN work w ON a.artist_id= w.artist_id
JOIN museum m ON m.museum_id = w.museum_id
group by m.country
order by count(*) desc
LIMIT 1
OFFSET 4
;

/*21) A Which are the 3 most popular and 3 least popular painting styles?*/

(select style, count(*) as no_of_paintings, 'Most Popular' as remarks
from work
group by style
order by count(*) desc
limit 3)

UNION

(select style, count(*) as no_of_paintings, 'Least Popular' as remarks
from work
group by style
order by count(*) asc
limit 3)
;

/*22)A Which artist has the most no of Portraits paintings outside USA?. Display artist name, no of paintings and the artist nationality.*/
select a.full_name, a.nationality, count(*) as no_of_paintings
from work w
join artist a on a.artist_id=w.artist_id
join subject s on s.work_id=w.work_id
join museum m on m.museum_id=w.museum_id
where m.country <> 'USA' AND s.subject = 'Portraits'
group by a.full_name, a.nationality
order by count(*) desc
limit 1;

