-- Relationship Between Number of Previous Attempts and Final Result
-- 
-- students who previously failed were more likely to fail again?
SELECT 
    num_of_prev_attempts,
    final_result,
    COUNT(*) AS student_count
FROM 
    studentInfo
GROUP BY 
    num_of_prev_attempts, final_result
ORDER BY
    num_of_prev_attempts, final_result;
