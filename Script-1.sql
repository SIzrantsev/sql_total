--� ����� ������� ������ ������ ���������? 10

select city 
from airports 
group by city 
having count(1)>1;
