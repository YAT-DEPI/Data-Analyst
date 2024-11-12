# import data
library(readxl)
data <- read_excel("C:/Users/PC.DESKTOP-HOPA585/Desktop/R/data.xlsx")
View(data)

library(readxl)
data <- read_excel("C:/Users/PC.DESKTOP-HOPA585/Desktop/R/data.xlsx", sheet = "data r")
# Previewing Imported Data
str(data)
summary(data)
head(data)

# Filter for the two indicators of interest
filtered_data <- data %>%
  filter(INDICATOR %in% c("Generation per capita", "Collection coverage - tonnes"))

# Check the structure of filtered data
head(filtered_data)

# Summarize data by country, indicator, and year
summary_data <- filtered_data %>%
  group_by(COUNTRY, INDICATOR, YEAR) %>%
  summarize(Average_Value = mean(VALUE, na.rm = TRUE))

# View the summary data
print(summary_data)

# Plot for Generation per capita over time
ggplot(data = filtered_data %>% filter(INDICATOR == "Generation per capita"), 
       aes(x = YEAR, y = VALUE, color = COUNTRY)) +
  geom_line(size = 1) +
  labs(title = "Generation per Capita Over Time by Country",
       y = "kg/person-year", x = "Year") +
  theme_minimal()


# Filter for the two indicators and years between 2014 and 2018
filtered_data <- data %>%
  filter(INDICATOR %in% c("Generation per capita", "Collection coverage - tonnes") & 
           YEAR >= 2014 & YEAR <= 2018)

# View the first few rows of the filtered dataset
head(filtered_data)

# Summarize the data by country, indicator, and year
summary_data <- filtered_data %>%
  group_by(COUNTRY, INDICATOR, YEAR) %>%
  summarize(Average_Value = mean(VALUE, na.rm = TRUE))

# View the summary data
print(summary_data)

Step 3: Explore Trends Over Time for Each Indicator
Visualize how Generation per capita and Collection coverage - tonnes change over time.

Plot 1: Generation per Capita Over Time

# Plot Generation per capita over time by country
ggplot(data = filtered_data %>% filter(INDICATOR == "Generation per capita"), 
       aes(x = YEAR, y = VALUE, color = COUNTRY)) +
  geom_line(size = 1) +
  labs(title = "Generation per Capita (2014-2018) by Country", 
       y = "kg/person-year", x = "Year") +
  theme_minimal()

# Plot Collection coverage - tonnes over time by country
ggplot(data = filtered_data %>% filter(INDICATOR == "Collection coverage - tonnes"), 
       aes(x = YEAR, y = VALUE, color = COUNTRY)) +
  geom_line(size = 1) +
  labs(title = "Collection Coverage - Tonnes (2014-2018) by Country", 
       y = "Tonnes", x = "Year") +
  theme_minimal()
# Create a dataset that contains both indicators
correlation_data <- filtered_data %>%
  filter(INDICATOR %in% c("Generation per capita", "Collection coverage - tonnes")) %>%
  spread(INDICATOR, VALUE)

# Check for correlations between the two indicators
correlation_data_clean <- correlation_data %>%
  filter(!is.na(`Generation per capita`) & !is.na(`Collection coverage - tonnes`))

# Calculate the correlation between the two indicators
correlation_value <- cor(correlation_data_clean$`Generation per capita`, 
                         correlation_data_clean$`Collection coverage - tonnes`)

print(paste("Correlation between Generation per Capita and Collection Coverage (Tonnes):", correlation_value))

# Plot for Generation per capita by region
ggplot(data = filtered_data %>% filter(INDICATOR == "Generation per capita"), 
       aes(x = REGION, y = VALUE, fill = REGION)) +
  geom_boxplot() +
  labs(title = "Generation per Capita by Region",
       y = "kg/person-year", x = "Region") +
  theme_minimal()
# Boxplot comparing Collection coverage - tonnes by region
ggplot(data = filtered_data %>% filter(INDICATOR == "Collection coverage - tonnes"), 
       aes(x = REGION, y = VALUE, fill = REGION)) +
  geom_boxplot() +
  labs(title = "Collection Coverage - Tonnes by Region (2014-2018)",
       y = "Tonnes", x = "Region") +
  theme_minimal()
