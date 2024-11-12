-- Assessment Type Popularity and Average Scores
--
-- Determine which assessment type is more common and their average scores.
SELECT 
    assessment_type,
    COUNT(sa.id_assessment) AS total_assessments,
    AVG(sa.score) AS avg_score
FROM 
    assessments a
JOIN 
    studentAssessment sa ON a.id_assessment = sa.id_assessment
GROUP BY 
    assessment_type
ORDER BY 
    total_assessments DESC;
