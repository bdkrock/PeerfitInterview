WITH 
	hours AS 
		(SELECT id, HOUR(reserved_for) AS res_hour, HOUR(signed_in_at) AS att_hour
		FROM clubready_reservations
		UNION ALL
		SELECT id, HOUR(class_time_at) AS res_hour, HOUR(checked_in_at) AS att_hour
		FROM mindbody_reservations),
    att_hours AS
		(SELECT id, att_hour
        FROM hours
        WHERE att_hour IS NOT NULL)
	
SELECT "class time",
	SUM(CASE WHEN res_hour BETWEEN 7 AND 11 THEN 1 ELSE 0 END) AS morning,
	SUM(CASE WHEN res_hour BETWEEN 12 AND 16 THEN 1 ELSE 0 END) AS afternoon,
    SUM(CASE WHEN res_hour BETWEEN 17 AND 22 THEN 1 ELSE 0 END) AS evening
FROM hours
UNION
SELECT "attendance time",
	SUM(CASE WHEN att_hour BETWEEN 7 AND 11 THEN 1 ELSE 0 END) AS morning,
	SUM(CASE WHEN att_hour BETWEEN 12 AND 16 THEN 1 ELSE 0 END) AS afternoon,
    SUM(CASE WHEN att_hour BETWEEN 17 AND 22 THEN 1 ELSE 0 END) AS evening
FROM hours;