WITH
	cr_complete AS (SELECT COUNT(*) AS completed
		FROM clubready_reservations
		WHERE signed_in_at IS NOT NULL
			AND (MONTH(signed_in_at) = 01 OR MONTH(signed_in_at) = 02)),
	mb_complete AS (SELECT COUNT(*) AS completed
		FROM mindbody_reservations
		WHERE checked_in_at IS NOT NULL
			AND (MONTH(checked_in_at) = 01 OR MONTH(checked_in_at) = 02))
SELECT (cr_complete.completed + mb_complete.completed) AS total_completed
FROM cr_complete JOIN mb_complete;