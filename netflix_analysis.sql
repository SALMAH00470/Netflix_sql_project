-- netflik_project solution
drop table if exists netflix;
CREATE TABLE netflix
(
    show_id VARCHAR(10),
    type VARCHAR(20),
    title VARCHAR(255),
    director VARCHAR(255),
    cast TEXT,
    country VARCHAR(255),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(50),
    listed_in VARCHAR(255),
    description TEXT
);

-- 15 business problems 
-- Q1.count the number of movies vs tv show
select
type,
count(*) as total_content
from netflix
group by 1;

-- Q2.find the most common rating for movies and tv show
select
type,
rating
from
(
select 
type,
rating,
-- max(rating)
count(*),
rank() over(partition by type order by count(*)) as ranking
from netflix
group by 1,2) as T1
where
ranking = 1;

-- Q3.list all the movies released in a specified year (eg., 2020)
-- filter 2020
-- filter the data
select *from netflix
where
 type = 'movie'
 and
 release_year = 2020;
 
 -- Q4. find the top 5 countries with the most content on netflix
 select 
 country,
 count(show_id) as total_content
 from netflix
 group by 1;

-- Q5. identify the longest movie?
select *from netflix
where 
type = 'movie'
and
duration = (select max(duration) from netflix);

-- Q6. find all the movies/tv show by director 'mike flanagan  '
select *from netflix
where director = 'mike flanagan';

-- Q7.list all the tv shows with more than 5 seasons
select 
type,
duration
from netflix
where 
type = 'movies'
and lower(duration) like '%90min%'
and substring_index(duration,'',1)+0 > 5;

-- Q8. list all the movies that are documentaries
select *from netflix
where 
listed_in like '%documentaries%';


-- Q9. find all content without director
select *from netflix
where director = '';

-- Q10. find how many movies actor 'salman khan' appeared in the last 5 years
select *from netflix
where 
cast like '%nancy kim%';


-- Q11. find the top 10 actors who appeared in the highest number of movies produced in united states

select 
-- show_id
-- cast,
substring_index(cast,',', 1) as actors,
count(*) as total
from netflix
where country  ='united states'
group by 1
order by 2 desc
limit 10;

-- Q12. categorize the content based on keyword 'kill' and violece in the description field.label
-- content containing these keywords as "bad'and all others content as 'good'.count how many items fall 
-- in each category 


with New_table
as
(
select *,
case
when description like  '%kill%'
or 
  description like  '%abusive%' then 'Bad_movie'
  else 'good_movie'
  end category
from netflix
)
select 
category,
count(*) as total_content
from new_table
group by 1;





















































