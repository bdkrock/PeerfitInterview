SELECT
	sub.studio_key,
    COUNT(sub.id) AS total_abandoned
FROM 
	(SELECT id, studio_key, canceled, signed_in_at
	FROM clubready_reservations
	UNION ALL
    SELECT id, studio_key, canceled_at, checked_in_at
    FROM mindbody_reservations) AS sub
WHERE signed_in_at IS NULL 
	AND (canceled = 'f' OR canceled IS NULL)
GROUP BY studio_key
ORDER BY total_abandoned DESC
LIMIT 1;