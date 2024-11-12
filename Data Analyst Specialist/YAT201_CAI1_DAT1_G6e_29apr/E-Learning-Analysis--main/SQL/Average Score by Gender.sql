-- Average Score by Gender
--
--  is there's a performance gap between genders.
SELECT 
    gender,
    AVG(sa.score) AS avg_score
FROM 
    studentInfo si
JOIN 
    studentAssessment sa ON si.id_student = sa.id_student
JOIN 
    assessments a ON sa.id_assessment = a.id_assessment
    AND si.code_module = a.code_module
    AND si.code_presentation = a.code_presentation
GROUP BY 
    gender
ORDER BY 
    avg_score DESC;

