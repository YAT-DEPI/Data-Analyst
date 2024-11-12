install.packages("ggplot2")
library(ggplot2)

install.packages("tidyverse")                   # Install tidyverse packages
library("tidyverse")
#to read excel file or csv file we need readr , readxl and xlsx
library(readr)
library(readxl)
install.packages(xlsx)
library(xlsx)
library(dplyr)   # For the %>% operator
library(tibble)  # For the view() function
data <- read.csv("final_data.csv")
data%>%
  view()


itcnt <- table(data$item_type)
itcnt_df <- as.data.frame(itcnt)
ggplot(itcnt_df, aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal() +
  labs(title = "Count of Each Item Type", x = "Item Type", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


itname_quant <- data %>%
  filter(item_type == 'Fastfood') %>%
  group_by(item_name) %>%
  summarise(total_quantity = sum(quantity, na.rm = TRUE))

ggplot(itname_quant, aes(x = item_name, y = total_quantity)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  theme_minimal() +
  labs(title = "Total Quantity of Fastfood Items", x = "Item Name", y = "Total Quantity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




itname_quant_beverages <- data %>%
  filter(item_type == 'Beverages') %>%
  group_by(item_name) %>%
  summarise(total_quantity = sum(quantity, na.rm = TRUE))
ggplot(itname_quant_beverages, aes(x = item_name, y = total_quantity)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  theme_minimal() +
  labs(title = "Total Quantity of Beverages", x = "Item Name", y = "Total Quantity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Set up the plot
ggplot(data, aes(x = item_name, y = total_cost)) +
  stat_summary(fun = sum, geom = "bar", fill = "skyblue", color = "black") +
  theme_minimal() +  # Similar to sns.set(style="whitegrid")
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Rotate x-axis labels
  labs(title = "Total Cost by Item Name", x = "Item Name", y = "Total Cost") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title


# Ensure 'date' column is in Date format
data$date <- as.Date(data$date)

# Aggregate total cost by date
daily_revenue <- data %>%
  group_by(date) %>%
  summarise(total_cost = sum(total_cost, na.rm = TRUE))

# Create an area plot of total cost over time
ggplot(daily_revenue, aes(x = date, y = total_cost)) +
  geom_area(fill = "skyblue", alpha = 0.4) +  # Area under the curve
  geom_line(color = "Slateblue", alpha = 0.6, size = 1.5) +  # Line on top
  labs(title = "Daily Total Cost Over Time (Area Plot)", 
       x = "Date", 
       y = "Total Cost") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels


# Create a histogram of total cost with density plot (kde=True equivalent in Python)
ggplot(data, aes(x = total_cost)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "purple", alpha = 0.6) +
  geom_density(color = "black", size = 1) +  # Add density (kde) line
  labs(title = "Distribution of Total Cost", 
       x = "Total Cost", 
       y = "Density") +
  theme_minimal()



#  Pie chart: Proportion of Total Cost by Item Type
# Summarize total cost by item type
cost_summary <- data %>%
  group_by(item_type) %>%
  summarize(total_cost = sum(total_cost))

# Create the pie chart
ggplot(cost_summary, aes(x="", y=total_cost, fill=item_type)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  labs(title="Proportion of Total Cost by Item Type") +
  theme_void() +
  geom_text(aes(label = paste0(round((total_cost/sum(total_cost))*100, 1), "%")),
            position = position_stack(vjust = 0.5))

#  Bar chart: Count of Transaction Types
ggplot(data, aes(x=transaction_type)) +
  geom_bar(fill=c('#66c2a5', '#fc8d62')) +
  labs(title="Count of Transaction Types", x="Transaction Type", y="Count")
