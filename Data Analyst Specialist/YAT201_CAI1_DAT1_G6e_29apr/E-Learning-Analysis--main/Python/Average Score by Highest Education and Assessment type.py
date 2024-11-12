# Create a pivot table for the heatmap
pivot_table = merged_data.pivot_table(values='score', index='highest_education', columns='assessment_type', aggfunc='mean')

plt.figure(figsize=(12, 8))
sns.heatmap(pivot_table, annot=True, fmt='.1f', cmap='coolwarm', linewidths=0.5)
plt.title('Average Score by Highest Education and Assessment Type')
plt.xlabel('Assessment Type')
plt.ylabel('Highest Education Level')
plt.show()
