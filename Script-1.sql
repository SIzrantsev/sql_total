--В каких городах больше одного аэропорта? 10

select city 
from airports 
group by city 
having count(1)>1;
