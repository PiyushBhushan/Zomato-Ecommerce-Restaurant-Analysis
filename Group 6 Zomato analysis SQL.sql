Create database Zomato_Sales_Analysis;

USE zomato_sales_analysis;

Select * from main;
Select * from country;
Select * from currency;

Select count('restaurant name') from main;

---- 1.Find the Numbers of Resturants based on City and Country.

select city, count(restaurantid) from main
group by city;

select countryname, count(restaurantid) from main as m
left join country as c
on m.CountryCode = c.CountryID
group by Countryname;


select m.city, count(m.restaurantid) as city_count , c.countryname 
from main as m
left join country as c
on m.CountryCode = c.CountryID
group by m.city ,c.Countryname;


---- 2.Numbers of Resturants opening based on Year , Quarter , Month
#TOTAL RESTAURANT OPEN YEARWISE

select distinct year(year) as year, count(*)
from main
group by year(year);

#TOTAL RESTAURANT OPEN MONTHWISE

select distinct monthname(year) as month_name, count(*)
from main
group by monthname(year);

#TOTAL RESTAURANT OPEN QUARTERWISE

select Quarter, count(*) as Restaurantcount
from main
where quarter is not null
group by Quarter
order by Quarter;

-- 3.Percentage of Resturants based on "Has_Table_booking

select Has_Table_booking,
count(*) as TotalRestaurants,
round((count(*) / (select count(*) from main)) * 100, 2) as percentage
from main
group by Has_Table_booking;

-- 4.Percentage of Resturants based on "Has_Online_delivery"

select Has_Online_delivery,
count(*) as TotalRestaurants,
round((count(*) / (select count(*) from main)) * 100, 2) as percentage
from main
group by Has_Online_delivery;

-- 5.Count of Resturants based on Average Ratings

select rating as Individualrating,
count(*) as Restaurantcount
from main
where rating is not null
group by rating
order by rating asc;

-- 6.Find total cuisines

select cuisines, count(cuisines) from main
group by cuisines;

-- 7.Find cost bucket list and restaurant comes under bucket

select cost_range,
count(*) as Totalrestaurants
from(
select case
when Average_cost_for_two between 0 and 300 then '0-300'
when Average_cost_for_two between 301 and 600 then '301-600'
when Average_cost_for_two between 601 and 1000 then '601-1000'
when Average_cost_for_two between 1001 and 500000 then '1001-500000'
else 'other'
end as cost_range
from main)
 as subquery
 group by cost_range;





