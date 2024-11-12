-- final result distribution by age

SELECT 
    CASE 
        WHEN age_band = '55<=' THEN '>=55'
        WHEN age_band = '0-35' THEN '<=35'
        ELSE '35-55' 
    END AS age_group,
    final_result,
    COUNT(*) AS student_count
FROM 
    studentInfo
GROUP BY 
    age_group, final_result
ORDER BY
    age_group, final_result;
