SELECT sub.class_tag, COUNT(sub.id) AS completed
FROM
	(SELECT id, class_tag, signed_in_at
    FROM clubready_reservations
    UNION ALL
    SELECT id, class_tag, checked_in_at
    FROM mindbody_reservations) AS sub
WHERE sub.signed_in_at IS NOT NULL
	AND MONTH(sub.signed_in_at) = 02
GROUP BY sub.class_tag
ORDER BY completed DESC
LIMIT 1;