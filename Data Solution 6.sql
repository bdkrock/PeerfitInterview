WITH 
	feb AS
		(SELECT id, CONCAT(member_id, '-cr') AS member, reserved_for, signed_in_at
		FROM clubready_reservations
		WHERE MONTH(reserved_for) = 02
		UNION ALL
		SELECT id, CONCAT(member_id, '-mb') AS member, class_time_at, checked_in_at
		FROM mindbody_reservations
		WHERE MONTH(class_time_at) = 02)

SELECT member, COUNT(reserved_for) AS reserved, COUNT(signed_in_at) AS completed
FROM feb
GROUP BY member
ORDER BY reserved DESC, completed DESC
LIMIT 5;