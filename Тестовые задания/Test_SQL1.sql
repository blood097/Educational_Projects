SELECT issue_type,
	   round(AVG(minutes_in_status/60),2) AS avg_time_in_hours
FROM (SELECT *, SUBSTRING(issue_key,1,1) AS issue_type
      FROM history)
WHERE status == "Open"
GROUP BY issue_type