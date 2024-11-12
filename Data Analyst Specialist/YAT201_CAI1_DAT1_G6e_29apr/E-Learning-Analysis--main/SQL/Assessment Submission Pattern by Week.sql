-- Assessment Submission Pattern by Week
--
--  is there are specific weeks where students submit more assessments
SELECT 
    WEEK(sa.date_submitted) AS week_of_year,
    COUNT(sa.id_student) AS submissions_count
FROM 
    studentAssessment sa
GROUP BY 
    WEEK(sa.date_submitted)
ORDER BY 
    week_of_year;

