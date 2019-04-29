SELECT "clubready" AS partner, id, member_id, studio_key, class_tag, canceled, reserved_for, signed_in_at
FROM clubready_reservations
UNION ALL
SELECT "mindbody" AS partner, id, member_id, studio_key, class_tag, 
	CASE WHEN canceled_at IS NOT NULL THEN 't'
    ELSE 'f' END AS canceled,
    class_time_at, checked_in_at
FROM mindbody_reservations;