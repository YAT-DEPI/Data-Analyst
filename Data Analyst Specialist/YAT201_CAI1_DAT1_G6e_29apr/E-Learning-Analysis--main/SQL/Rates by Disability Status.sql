--  Rates by Disability Status
-- 
-- students with disabilities

SELECT 
    disability,
    final_result,
    COUNT(*) AS student_count
FROM 
    studentInfo

GROUP BY 
    disability, final_result
ORDER BY 
    student_count DESC;
