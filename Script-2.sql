
--¬ каких аэропортах есть рейсы, которые обслуживаютс€ самолетами с максимальной дальностью перелетов? 15

select f.departure_airport
from flights f
join (select aircraft_code
	from aircrafts
	order by "range" desc
	limit 1) t on t.aircraft_code = f.aircraft_code
group by f.departure_airport;