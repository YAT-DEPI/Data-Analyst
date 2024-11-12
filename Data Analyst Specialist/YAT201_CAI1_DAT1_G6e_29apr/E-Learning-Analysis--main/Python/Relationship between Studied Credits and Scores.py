import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load your student_info DataFrame (adjust the path as necessary)
# student_info = pd.read_csv('path_to_student_info.csv')

# Check the columns in student_assessment
print(student_assessment.columns)

# Merge DataFrames to include studied_credits
merged_data = student_assessment.merge(student_info[['id_student', 'studied_credits']], on='id_student', how='left')

# Create the scatter plot
plt.figure(figsize=(10, 6))
sns.scatterplot(x='studied_credits', y='score', data=merged_data)
plt.title('Relationship Between Studied Credits and Scores')
plt.xlabel('Studied Credits')
plt.ylabel('Score')
plt.show()
