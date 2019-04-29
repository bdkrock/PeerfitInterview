WITH book_hours AS
		(SELECT id, HOUR(reserved_at) AS book_hour
        FROM mindbody_reservations)
        
SELECT "time of booking",
	SUM(CASE WHEN book_hour BETWEEN 7 AND 11 THEN 1 ELSE 0 END) AS morning,
	SUM(CASE WHEN book_hour BETWEEN 12 AND 16 THEN 1 ELSE 0 END) AS afternoon,
    SUM(CASE WHEN book_hour BETWEEN 17 AND 22 THEN 1 ELSE 0 END) AS evening,
    SUM(CASE WHEN (book_hour BETWEEN 0 AND 6) OR book_hour = 23 THEN 1 ELSE 0 END) AS other
FROM book_hours;