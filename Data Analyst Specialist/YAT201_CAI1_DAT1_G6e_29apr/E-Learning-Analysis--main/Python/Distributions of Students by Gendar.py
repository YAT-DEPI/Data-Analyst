gender_distribution = student_info['gender'].value_counts()
plt.figure(figsize=(8, 8))
plt.pie(gender_distribution, labels=gender_distribution.index, autopct='%1.1f%%', startangle=140)
plt.title('Distribution of Students by Gender')
plt.axis('equal')  # Equal aspect ratio ensures the pie chart is a circle.
plt.show()
