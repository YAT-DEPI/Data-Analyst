library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')


query <- "
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
"
results <- dbGetQuery(db, query)


dbDisconnect(db)


ggplot(results, aes(x = age_group, y = student_count, fill = final_result)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Final Result Distribution by Age Group", x = "Age Group", y = "Student Count") +
  theme_minimal()

###############################################

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')
query2 <- "
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
"
results2 <- dbGetQuery(db, query2)

dbDisconnect(db)

ggplot(results2, aes(x = highest_education, y = student_count, fill = final_result)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Final Result Distribution by Highest Education", x = "Highest Education", y = "Student Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  

##########################################################

library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query3 <- "
SELECT 
    a.code_module,
    CASE
        WHEN sa.score BETWEEN 0 AND 50 THEN '0-50'
        WHEN sa.score BETWEEN 51 AND 75 THEN '51-75'
        WHEN sa.score BETWEEN 76 AND 90 THEN '76-90'
        WHEN sa.score > 90 THEN '91+'
        ELSE 'No Score'
    END AS score_group,
    COUNT(*) AS student_count
FROM 
    studentAssessment sa
JOIN 
    assessments a ON sa.id_assessment = a.id_assessment
GROUP BY 
    a.code_module, score_group
ORDER BY
    a.code_module, score_group;
"
results3 <- dbGetQuery(db, query3)

dbDisconnect(db)

# Plot the data
ggplot(results3, aes(x = code_module, y = student_count, fill = score_group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Assessment Score Distribution by Code Module", x = "Code Module", y = "Student Count") +
  theme_minimal()

#############################################################


library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query4 <- "
SELECT 
    a.assessment_type,
    CASE
        WHEN sa.score BETWEEN 0 AND 50 THEN '0-50'
        WHEN sa.score BETWEEN 51 AND 75 THEN '51-75'
        WHEN sa.score BETWEEN 76 AND 90 THEN '76-90'
        WHEN sa.score > 90 THEN '91+'
        ELSE 'No Score'
    END AS score_group,
    COUNT(*) AS student_count
FROM 
    studentAssessment sa
JOIN 
    assessments a ON sa.id_assessment = a.id_assessment
GROUP BY 
    a.assessment_type, score_group
ORDER BY
    a.assessment_type, score_group;
"
results4 <- dbGetQuery(db, query4)

dbDisconnect(db)


ggplot(results4, aes(x = assessment_type, y = student_count, fill = score_group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Assessment Score Distribution by Assessment Type", x = "Assessment Type", y = "Student Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  

##########################################################################################

library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query5 <- "
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
"
results5 <- dbGetQuery(db, query5)

dbDisconnect(db)


ggplot(results5, aes(x = reorder(code_module, -avg_score), y = avg_score)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Average Assessment Score by Code Module", x = "Code Module", y = "Average Score") +
  theme_minimal()
###############################################################################

library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query6 <- "
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
"
results6 <- dbGetQuery(db, query6)

dbDisconnect(db)

ggplot(results6, aes(x = factor(num_of_prev_attempts), y = student_count, fill = final_result)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Relationship Between Number of Previous Attempts and Final Result", x = "Number of Previous Attempts", y = "Student Count") +
  theme_minimal()
############################################################################3

library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query <- "
SELECT 
    a.code_module,
    CASE
        WHEN sa.score BETWEEN 0 AND 50 THEN '0-50'
        WHEN sa.score BETWEEN 51 AND 75 THEN '51-75'
        WHEN sa.score BETWEEN 76 AND 90 THEN '76-90'
        WHEN sa.score > 90 THEN '91+'
        ELSE 'No Score'
    END AS score_group,
    COUNT(*) AS student_count
FROM 
    studentAssessment sa
JOIN 
    assessments a ON sa.id_assessment = a.id_assessment
GROUP BY 
    a.code_module, score_group
ORDER BY
    a.code_module, score_group;
"
results <- dbGetQuery(db, query)

dbDisconnect(db)

ggplot(results, aes(x = code_module, y = student_count, fill = score_group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Assessment Score Distribution by Code Module", x = "Code Module", y = "Student Count") +
  theme_minimal()
##########################################################################################

library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query <- "
SELECT 
    WEEK(sa.date_submitted) AS week_of_year,
    COUNT(sa.id_student) AS submissions_count
FROM 
    studentAssessment sa
GROUP BY 
    WEEK(sa.date_submitted)
ORDER BY 
    week_of_year;
"
results <- dbGetQuery(db, query)

dbDisconnect(db)

ggplot(results, aes(x = week_of_year, y = submissions_count)) +
  geom_bar(stat = "identity", fill = "#748") +
  labs(title = "Assessment Submission Pattern by Week", x = "Week of Year", y = "Submissions Count") +
  theme_minimal()
###################################################################################################

library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query <- "
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
"
results <- dbGetQuery(db, query)

dbDisconnect(db)

ggplot(results, aes(x = gender, y = avg_score, fill = gender)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Score by Gender", x = "Gender", y = "Average Score") +
  theme_minimal()

################################################################################################
library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query <- "
SELECT 
    id_student,
    code_module,
    COUNT(*) AS num_repeats,
    MAX(final_result) AS final_result
FROM 
    studentInfo
GROUP BY 
    id_student, code_module
HAVING 
    num_repeats > 1
ORDER BY 
    num_repeats DESC;
"
results <- dbGetQuery(db, query)

dbDisconnect(db)

ggplot(results, aes(x = code_module, y = num_repeats, fill = final_result)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Students Who Repeated Modules and Their Final Results", x = "Code Module", y = "Number of Repeats") +
  theme_minimal()

###################################################################################

library(RMySQL)
library(ggplot2)

db <- dbConnect(MySQL(), 
                user = 'root', 
                password = 'root', 
                dbname = 'project', 
                host = '127.0.0.1')

query <- "
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
"
results <- dbGetQuery(db, query)

dbDisconnect(db)

ggplot(results, aes(x = assessment_type, y = total_assessments, fill = avg_score)) +
  geom_bar(stat = "identity") +
  labs(title = "Assessment Type Popularity and Average Scores", x = "Assessment Type", y = "Total Assessments") +
  theme_minimal()
