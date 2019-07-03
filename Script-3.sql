
--Узнать максимальное время задержки вылетов самолетов 25

select max(actual_departure - scheduled_departure) delay
from flights f;
