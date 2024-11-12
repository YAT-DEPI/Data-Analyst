-- final result distribution by highest education 
SELECT 
    highest_education,
    final_result,
    COUNT(*) AS student_count
FROM 
    studentInfo
GROUP BY 
    highest_education, final_result
ORDER BY
    highest_education, final_result;
