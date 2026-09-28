SELECT 
  SUM(email ='') Missing_email,
  SUM(phone ='') Missind_phone
FROM students;

-- 75% of students have missing contanct details

-- How many attendance sessions have no status recorded at all
SELECT status, COUNT(*) AS n
FROM attendance
GROUP BY status
ORDER BY n DESC;

-- Not Recorded Sessions as a share of the whole attendance table
SELECT 
    ROUND(100.0* SUM(status = 'Not Recorded') / COUNT(*),2) AS Pct_Not_Recorded
    FROM attendance;

-- 