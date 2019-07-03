
--Ѕыли ли брони, по которым не совершались перелеты? 15

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