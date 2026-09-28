-- 05_schedule_comparison.sql
-- 
-- Question:
-- Does the number of trainig days per week affect attandance?
-- 
-- Cohort 2 to 5 used a three day week (MWF), While Cohort 6
-- used a five day week (MTWF).

SELECT 
  c.schedule,
  ROUND(100 * SUM(a.status IN ('Presesnt', 'Late')) / COUNT(*)
  ) AS attendance_rate,
  COUNT(*) AS n
  
  FROM attendance a
  JOIN enrolments e ON a.enrolment_id = e.enrolment_id
  JOIN cohorts c ON e.cohort_id = c.cohort_id
  
WHERE a.status <> 'Not Recorded'
GROUP BY c.schedule;
-- Results
-- Attendance is almost the same both schedule:
-- 58.0%  for the five day week and 58.9% for the three day week 
-- that the change in weekly schedule had little difference in
-- attendance based on the avalaible data.