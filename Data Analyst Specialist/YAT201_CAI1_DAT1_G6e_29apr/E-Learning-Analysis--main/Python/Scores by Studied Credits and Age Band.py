# Make sure 'studied_credits' and 'age' are numeric
plt.figure(figsize=(12, 8))
sns.scatterplot(x='studied_credits', y='score', hue='age_band', data=merged_data, palette='viridis', alpha=0.7)
plt.title('Scores by Studied Credits and Age Band')
plt.xlabel('Studied Credits')
plt.ylabel('Score')
plt.legend(title='Age Band')
plt.show()
