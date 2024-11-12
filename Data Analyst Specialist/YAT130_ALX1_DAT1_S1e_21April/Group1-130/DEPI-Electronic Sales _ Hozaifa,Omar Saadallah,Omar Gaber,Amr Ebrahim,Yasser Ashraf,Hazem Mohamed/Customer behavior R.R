data<-read.csv("D:/YAT LEARNING/Project/Python Project 2 tableau/Cleaned_ElectronicSales.csv")
head(data)
library(ggplot2)
library(dplyr)
#visulizing the data
#gender distribution according to sales
ggplot(data, aes(x=Gender,y=Total.Price)) +
    geom_bar(stat='identity') +
      geom_text(aes(label = Total.Price),vjust=-0.5) +
      labs(title = 'Gender based on sales',
           x='Gender',
           y='Total_Sales')
    
#we noticed from the prev graph that there is no diffrence between the two genders so there is no impact on the data
####visulizing the product type by Sales####
ggplot(data, aes(x=reorder(Product.Type,Total.Price) , y=Total.Price,fill = Product.Type)) +
  geom_col() +
  geom_text(aes(label = Total.Price),vjust=-0.5) +
  labs(title = 'Product based on sales',
       x='Product Type',
       y='Total_Sales')+
  scale_fill_manual(values =c("Headphones"='blue',"Laptop"='green',"Smartphone" = "red",'Smartwatch'='violet','Tablet'= 'orange'))
  theme_minimal()
  #the Smartphone is the most sold product
  
  ####How does the loyalty programs impact the total sales####
  ggplot(data, aes(x=reorder(Loyalty.Member,Total.Price) , y=Total.Price,fill = Loyalty.Member)) +
    geom_col() +
    geom_text(aes(label = Total.Price),vjust=-0.5) +
    labs(title = 'Sales Based on loyalty',
         x='Loyalty Member',
         y='Total_Sales')+
    scale_fill_manual(values =c("Yes"='blue',"No" = "red"))
  theme_minimal()
  ####most of the members doesn't have loyalty Membership####
  
  
  ####Analyzing Trends in Customer Purchasing Behvior by Dates###
  ggplot(data, aes(x=Purchase.Date,y=Total.Price)) +
    geom_line()+
    labs(title = 'Trends in Purchase Behavior',
         x='Total Sales',
         y='Purchase Dates') +
    theme_minimal()
  
  
  ggplot(data, aes(x =Purchase.Date , y = Total.Price)) +
    geom_line() +
    labs(title = "Sales Over Time", x = "Date", y = "Sales") +
    theme_minimal()
  
  data$Purchase.Date <- as.Date(data$Purchase.Date)
  
  ggplot(data, aes(x = Purchase.Date, y = Total.Price)) +
    geom_line(color = 'blue') +
    labs(title = 'Trends in Purchase Behavior',
         x = 'Purchase Dates',
         y = 'Total Sales') +
    theme_minimal()
  
  
  agg_data<- data%>%
    group_by(Purchase.Date)%>%
    summarize(Total_sales = sum(Total.Price))
  agg_data$Purchase.Date<-as.Date(agg_data$Purchase.Date)
  
  ggplot(agg_data, aes(x = Purchase.Date, y = Total_sales)) +
    geom_line(color = 'blue') +
    labs(title = 'Trends in Purchase Behavior',
         x = 'Purchase Dates',
         y = 'Total Sales') +
    theme_minimal()
  ####from Jan2024 To Apr2024 were the growth stage of the business####
  
  
  ggplot(data, aes(x = reorder(Shipping.Type,Total.Price) , y = Total.Price , fill = Shipping.Type)) +
    geom_col() +
    labs(title = 'Sales by Shipping Type',
         x = 'Shipping Type',
         y = 'Total Sales') +
    scale_fill_manual(values =c("Expedited"='blue',"Express"='green',"Overnight" = "red",'Same Day'='violet','Standard'= 'orange'))
    theme_minimal()
    ####standard was the most needed shipping Type####
    
    
    #which Product Type Generate most revenue
    ggplot(data, aes(x=reorder(SKU,Total.Price) , y=Total.Price)) +
      geom_col() +
      geom_text(aes(label = Total.Price),vjust=-0.5) +
      labs(title = 'Product based on sales',
           x='Product Type',
           y='Total_Sales')
       theme_minimal()
       
       
       # Plot SKU by Total Sales and facet by Product Type
       ggplot(data, aes(x = reorder(SKU, Total.Price), y = Total.Price)) +
         geom_col(fill = "skyblue") +
         geom_text(aes(label = round(Total.Price, 2)), vjust = -0.5, size = 3) +
         labs(title = 'Product Sales by SKU and Product Type',
              x = 'SKU',
              y = 'Total Sales') +
         theme_minimal() +
         facet_wrap(~ Product.Type, scales = "free_x") + 
         theme(axis.text.x = element_text(angle = 90, hjust = 1))  
       
       
       ggplot(data, aes(x = reorder(SKU, Total.Price), y = Total.Price, fill = Product.Type)) +
         geom_col() +
         geom_text(aes(label = round(Total.Price, 2)), vjust = -0.5, size = 3) +
         labs(title = 'Product Sales by SKU and Product Type',
              x = 'SKU',
              y = 'Total Sales') +
         theme_minimal() +
         theme(axis.text.x = element_text(angle = 90, hjust = 1))  
       
       ####The SMP234 of the Smartphone Product type is the most sold Product####
       
  
  
  
  
  
  
  

    