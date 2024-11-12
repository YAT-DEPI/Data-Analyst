-- Average Assessment Score by Code Module
-- 
-- overall performance in different modules
SELECT 
    a.code_module,
    AVG(sa.score) AS avg_score
FROM 
    studentAssessment sa
JOIN 
    assessments a ON sa.id_assessment = a.id_assessment
GROUP BY 
    a.code_module
ORDER BY
    avg_score DESC;
