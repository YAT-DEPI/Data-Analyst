plt.figure(figsize=(10, 6))
sns.countplot(y='highest_education', data=merged_data, order=merged_data['highest_education'].value_counts().index)
plt.title('Count of Students by Highest Education Level')
plt.xlabel('Count of Students')
plt.ylabel('Highest Education Level')
plt.show()
