--В каких городах больше одного аэропорта? 10

select city 
from airports 
group by city 
having count(1)>1;

--В каких аэропортах есть рейсы, которые обслуживаются самолетами с максимальной дальностью перелетов? 15

select f.departure_airport
from flights f
join (select aircraft_code
	from aircrafts
	order by "range" desc
	limit 1) t on t.aircraft_code = f.aircraft_code
group by f.departure_airport;

--Были ли брони, по которым не совершались перелеты? 15

select b.book_ref
from bookings b
left join (select b.book_ref
	from bookings b 
	join tickets t on t.book_ref = b.book_ref
	join ticket_flights tf on tf.ticket_no = t.ticket_no
	join flights f on f.flight_id = tf.flight_id
	where f.status = 'Arrived'
	group by b.book_ref) b1 on b.book_ref = b1.book_ref
where b1.book_ref is null;

--Самолеты каких моделей совершают наибольший % перелетов? 25

select a.model,round(cnt_flights/SUM(cnt_flights) over() *100,2) as share_flights 
from (select aircraft_code,count(1) cnt_flights
	from flights f
	group by aircraft_code) c
join aircrafts a on a.aircraft_code = c.aircraft_code 
order by cnt_flights desc
limit 1;

--Узнать максимальное время задержки вылетов самолетов 25

select max(actual_departure - scheduled_departure) delay
from flights f;

--Между какими городами нет прямых рейсов*? 35
--Сначала создаем представление
CREATE OR REPLACE view city_combo as
with cities as
	(select city, row_number() OVER() city_id
	from airports
	group by city
	order by city)
select c1.city city_1,c2.city city_2
from cities c1,cities c2
where c1.city_id < c2.city_id;

--Теперь ищем пары городов без прямого сообщения
select c.*
from city_combo c
left join (select departure_city,arrival_city 
	from routes r
	group by departure_city,arrival_city) r on r.departure_city = c.city_1 and r.arrival_city = c.city_2
where r.arrival_city is null;

