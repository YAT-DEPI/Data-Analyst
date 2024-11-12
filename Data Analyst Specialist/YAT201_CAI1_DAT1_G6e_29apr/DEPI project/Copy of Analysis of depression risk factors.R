####import the data
dep_data<-read.csv('C:\\Users\\Owner\\Downloads\\archive (4)\\depression_data.csv')
head(dep_data)
##data structure
str(dep_data)
##handling missing values of all columns
missing_values<-sapply(dep_data, function(x)sum(is.na(x)))
missing_values
## Remove duplicates
dep_dataa<-dep_data %>% distinct()
summary(dep_data)

#### Analysing Demographic Factors:
###[age,marital status, number of children,and educational level]####

hist(dep_dataa$Age,main = 'age')

Marital_Status_counts<- table(dep_dataa$Marital.Status)
Marital_Status_counts
barplot(Marital_Status_counts,main = 'marital status',Width = 2,col = c('blue','green','red','black'))
legend('topleft',c('Divorced','Married','Single','Widowed'),fill = c('blue','green','red','black'))

# Filter the data frame to only include married individuals
married_individuals <- dep_dataa[dep_dataa$Marital.Status == "Married", ]

# Count the number of children for each married individual
children_counts <- table(married_individuals$Number.of.Children)

# Print the results
print(children_counts)(children_counts,col='green',main = 'no of children for married individuals')
barplot

# Count occurrences of each unique value in the "Education.Level" column
education_level_counts <- table(dep_dataa$Education)
print(education_level_counts)
# Print the results
bp <- barplot(education_level_counts, names.arg = NA, main = "education_level_counts")
text(x = bp, 
     y = par("usr")[3] - 1,  # Position just below the x-axis
     labels = names(education_level_counts), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)

### count the individuals with high risk demographic factors
count_grouped <- dep_dataa %>%
  group_by(`Marital.Status`, `Education.Level`) %>%
  count()
print(count_grouped)
ggplot(count_grouped, aes(x=`Marital.Status`, y=n, fill=`Education.Level`)) +
  geom_bar(stat="identity") +
  ggtitle("Count of depressed individuals with Education Levels within 
          Marital Status Categories") +
  xlab("Marital.Status") +
  ylab("Count") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")                             


####Analyzing life style factors[smoking status,physical activity
###,employment status,income,acohol consumption,dietary habbits,sleep patterns]
boxplot(dep_data$Income,main='annual income',ylab='USD')
hist(dep_data$Income,main = 'annual income', Xlab = 'USD',
     ylab = 'no of depressded individuals',col='blue')

smoking_status_count<-table(dep_dataa$Smoking.Status)
print(smoking_status_count)                         
pie(smoking_status_count,main = 'Smoking Status')

physical_activity_count<-table(dep_dataa$Physical.Activity.Level)
pie(physical_activity_count,main = 'Physical Activity')

count_grouped <- dep_dataa %>%
  group_by(`Smoking.Status`, `Physical.Activity.Level`) %>%
  count()
ggplot(count_grouped, aes(x=`Smoking.Status`, y=n, fill=`Physical.Activity.Level`)) +
  geom_bar(stat="identity") +
  ggtitle("Count physical activity levels within Smoking Status Categories") +
  xlab("Smoking.Status") +
  ylab("Count") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")

employment_status_count<-table(dep_dataa$Employment.Status)
barplot(employment_status_count,main= 'employment_status',col = 'blue')

dietary_habbits_count<-table(dep_dataa$Dietary.Habits)
barplot(dietary_habbits_count,main= 'Dietary Habbits',col = 'blue')

alcohol_consumption_status_count<-table(dep_dataa$Alcohol.Consumption)
barplot(alcohol_consumption_status_count,main='Alcohol consumption',col='blue')

sleep_patterns_status_count<-table(dep_dataa$Sleep.Patterns)
barplot(sleep_patterns_status_count,main='Sleep patterns',col='blue')

count_grouped <- dep_dataa %>%
  group_by(`Alcohol.Consumption`, `Sleep.Patterns`) %>%
  count()
ggplot(count_grouped, aes(x=`Alcohol.Consumption`, y=`Sleep.Patterns`, fill=n)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +  # Color scale for the heatmap
  geom_text(aes(label=n), color="black", size=3) +  # Adds text labels with counts
   ggtitle("Heatmap of Alcohol.Consumption vs.Sleep.Patterns ") +
  xlab("Alcohol.Consumption") +
  ylab("Sleep.Patterns") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


##### Analyzing medical Condition [History of Mental Illness,History of Substance Abuse
######Family History of Depression,Chronic Medical Conditions]

history_of_mental_illness_count<-table(dep_dataa$History.of.Mental.Illness)
print(history_of_mental_illness_count)
pie_values<-c(history_of_mental_illness_count)
pie_labels<-c('No','Yes')
slice_colors<-c('green','red')
pie_labels_with_counts <- paste(pie_labels,"\n", pie_values,sep="")
pie3D(pie_values, 
      labels = pie_labels_with_counts,
      explode = 0.1,  # Slightly separate the slices for better visibility
      main = "History of mental illness",
      col = slice_colors,  # Set the colors
      labelcex = 1.2) 

history_of_substance_abuse_count<-table(dep_dataa$History.of.Substance.Abuse)
print(history_of_substance_abuse_count)
pie_values<-c(history_of_substance_abuse_count)
pie_labels<-c('NO','yES')
slice_colors<-c('green','red')
pie_labels_with_counts <- paste(pie_labels,"\n", pie_values,sep="")
pie3D(pie_values, 
      labels = pie_labels_with_counts,
      explode = 0.1,  # Slightly separate the slices for better visibility
      main = "History of substance abuse",
      col = slice_colors,  # Set the colors
      labelcex = 1.2)

family_history_of_depression_count<-table(dep_dataa$Family.History.of.Depression)
print(family_history_of_depression_count)
pie_values<-c(family_history_of_depression_count)
pie_labels<-c('no','yes')
slice_colors<-c('green','red')
pie_labels_with_counts <- paste(pie_labels,"\n", pie_values,sep="")
pie3D(pie_values, 
      labels = pie_labels_with_counts,
      explode = 0.1,  # Slightly separate the slices for better visibility
      main = "Family history of depression",
      col = slice_colors,  # Set the colors
      labelcex = 1.2)

chronic_medical_condition_count<-table(dep_dataa$Chronic.Medical.Conditions)
print(chronic_medical_condition_count)
pie_values<-c(chronic_medical_condition_count)
pie_labels<-c('No','Yes')
slice_colors<-c('green','red')
pie_labels_with_counts <- paste(pie_labels,"\n", pie_values,sep="")
pie3D(pie_values, 
      labels = pie_labels_with_counts, 
      explode = 0.1,  # Slightly separate the slices for better visibility
      main = "chronic medical condition",
      col = slice_colors,  # Set the colors
      labelcex = 1.2)

### analyzing individuals with family history of depression 
###and history of mental illness###
count_grouped <- dep_dataa %>%
  group_by(`Family.History.of.Depression`, `History.of.Mental.Illness`) %>%
  count()
print(count_grouped)
ggplot(count_grouped, aes(x=`Family.History.of.Depression`, y=n, fill=`History.of.Mental.Illness`)) +
  geom_bar(stat="identity") +
  ggtitle("Count of individuals with history of mental illness within those with family history of depression Categories") +
  xlab("Family.History.of.Depression") +
  ylab("Count") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")



