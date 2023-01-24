CREATE TEMP TABLE t1 AS
SELECT issue_key, 
	   status,
	   DATETIME(started_at / 1000, 'unixepoch') AS started_datetime
FROM history
WHERE status != "Closed" AND status != "Resolved";

CREATE TEMP TABLE variable (name TEXT PRIMARY KEY, value TEXT);
INSERT OR REPLACE INTO variable VALUES ('Дата для поиска открытых задач', DATETIME()); -- Вместо DATETIME() тут можно написать любую дату для которой будут искать задачи
																					   -- сейчас запрос выдает все до текущей даты и времени
SELECT DISTINCT(issue_key),
	   LAST_VALUE(status) OVER (PARTITION BY issue_key) AS last_status,
	   MAX(started_datetime) OVER (PARTITION BY issue_key) AS last_time
FROM t1
WHERE started_datetime <= (SELECT value FROM variable)
