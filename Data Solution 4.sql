WITH 
	jan AS
		(SELECT id, CONCAT(member_id, '-cr') AS member, canceled, reserved_for, signed_in_at
		FROM clubready_reservations
		WHERE MONTH(reserved_for) = 01
		UNION ALL
		SELECT id, CONCAT(member_id, '-mb') AS member, canceled_at, class_time_at, checked_in_at
		FROM mindbody_reservations
		WHERE MONTH(class_time_at) = 01),
    cancels_above_one AS
		(SELECT jan.member, COUNT(jan.canceled) AS cancel_count
		FROM jan
        WHERE jan.canceled = 't' OR MONTH(jan.canceled) = 01
		GROUP BY jan.member)

SELECT COUNT(member) AS members
FROM (SELECT jan.member, COUNT(signed_in_at) AS completed, can.cancel_count
	FROM jan
    LEFT JOIN cancels_above_one AS can ON jan.member = can.member
	GROUP BY jan.member
	HAVING completed >= 1) AS pop
WHERE pop.cancel_count = 1 OR pop.cancel_count IS NULL;