-- 08_course_cohort_ranking.sql
-- Purpose: rank every course/cohort combination that ha run in the program 
-- by attendance rate, alongside is completion rate, to spot which specific 
-- offering are underperforming and wheather any course repeats near the
-- buttom across multiple cohort

WITH att AS (
  SELECT
    e.course_id,
    e.cohort_id,
    ROUND (100.0 * SUM(a.status IN ('Present', 'Late'))
      / COUNT(*), 1) AS attendance_rate
	FROM enrolments e
    JOIN attendance a ON a.enrolment_id = e.enrolment_id
    WHERE a.status != 'Not Recorded'
    GROUP BY e.course_id, e.cohort_id
),
comp AS (
   SELECT 
   
     e.course_id,
     e.cohort_id,
     ROUND(100.0 * SUM(e.status = 'Completed')
      / COUNT(*), 1) AS enrolled
	FROM enrolments e
    GROUP BY e.course_id, e.cohort_id
)
SELECT 
 c.course_name,
 att.cohort_id,
 att.attendance_rate,
 comp.completion_rate,
 comp.enrolled
FROM att
JOIN comp
   ON att.course_id = comp.course_id
   AND att.cohort_id = comp.cohort_id
JOIN courses c ON c.course_id = att.course_id
ORDER BY att.attendance_rate ASC;

-- Resuts: data Analysis appers twice in the weakest five(cohort 2 and 
-- cohort 5), suggesting a course level pattern rather than one bad cohort
-- completion rates for cohort 4,5 and 6 read low across almost every row
-- here because of the unkown status data quality issues documented in
-- 01_data_quality_checks.sql, not because those cohorts genuinely performed
-- worse. Read completion fingures for those cohorts with that cavest attached.