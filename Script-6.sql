
--ћежду какими городами нет пр€мых рейсов*? 35
--—начала создаем представление
CREATE OR REPLACE view city_combo as
with cities as
	(select city, row_number() OVER() city_id
	from airports
	group by city
	order by city)
select c1.city city_1,c2.city city_2
from cities c1,cities c2
where c1.city_id < c2.city_id;

--“еперь ищем пары городов без пр€мого сообщени€
select c.*
from city_combo c
left join (select departure_city,arrival_city 
	from routes r
	group by departure_city,arrival_city) r on r.departure_city = c.city_1 and r.arrival_city = c.city_2
where r.arrival_city is null;

