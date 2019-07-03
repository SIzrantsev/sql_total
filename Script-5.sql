
--Самолеты каких моделей совершают наибольший % перелетов? 25

select a.model,round(cnt_flights/SUM(cnt_flights) over() *100,2) as share_flights 
from (select aircraft_code,count(1) cnt_flights
	from flights f
	group by aircraft_code) c
join aircrafts a on a.aircraft_code = c.aircraft_code 
order by cnt_flights desc
limit 1;
