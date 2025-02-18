# Google Data Analytics Capstone: Case Study 1 (Cyclistic)
Certificate program: [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics)
## Basics
In this case study, I'm a junior data analyst who works for a fictional company, Cyclistic, along with some key team members. In order to answer the
business questions, I will be following the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.
## Settings
### Characters and teams
**Cyclistic**: A bike-share program that features more than 5,800 bicycles and 600
docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand
tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities
and riders who can’t use a standard two-wheeled bike. The majority of riders opt for
traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more
likely to ride for leisure, but about 30% use the bikes to commute to work each day.

**Lily Moreno**: The director of marketing and my manager, responsible for
the development of campaigns and initiatives to promote the bike-share program.
These may include email, social media, and other channels.

**Cyclistic marketing analytics team**: A team of data analysts who are responsible for
collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
I've joined this team six months ago and have been busy learning about Cyclistic’s
mission and business goals -as well as how I, as a junior data analyst, can help
Cyclistic achieve them.

**Cyclistic executive team**: The notoriously detail-oriented executive team will decide
whether to approve the recommended marketing program.

### About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown
to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations
across Chicago. The bikes can be unlocked from one station and returned to any other station
in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to
broad consumer segments. One approach that helped make these things possible was the
flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships.
Customers who purchase single-ride or full-day passes are referred to as casual riders.
Customers who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable
than casual riders. Although the pricing flexibility helps Cyclistic attract more customers,
Moreno believes that maximizing the number of annual members will be key to future growth.
Rather than creating a marketing campaign that targets all-new customers, Moreno believes
there is a solid opportunity to convert casual riders into members. She notes that casual riders
are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into
annual members. In order to do that, however, the team needs to better understand how
annual members and casual riders differ, why casual riders would buy a membership, and how
digital media could affect their marketing tactics. Moreno and her team are interested in
analyzing the Cyclistic historical bike trip data to identify trends.

### Scenario
I'm a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share
company in Chicago. The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships. Therefore, my team wants to
understand how casual riders and annual members use Cyclistic bikes differently. From these
insights, my team will design a new marketing strategy to convert casual riders into annual
members. But first, Cyclistic executives must approve our recommendations, so they must be
backed up with compelling data insights and professional data visualizations.

## Ask
### Business task
Design of marketing strategies to convert casual riders to members.
### Data Analysis Questions
Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

## Prepare
I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2024 to Dec 2024. Data is downloaded from 
[divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available by
Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement). 

This is public data that can be used to explore
how different customer types are using Cyclistic bikes. But note that data-privacy issues
prohibit from using riders’ personally identiable information. This means that we won’t be
able to connect pass purchases to credit card numbers to determine if casual riders live in the
Cyclistic service area or if they have purchased multiple single passes.

### Data Organization
There are 12 files, each following the naming convention of YYYYMM-divvy-tripdata, with each file representing data for a single month. The contents of these files correspond to the following columns: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, and member_casual.

## Process
**SSMS** is used for combining, exploration and cleaning of the data.

**Reason**: Cyclistic dataset has more than 5,86 millions of rows, and because Microsoft Excel is unable to manage large ammounts of data (the maximum number of rows that a worksheet can support is 1,048,576 rows), it is reasonable to use such platform like SSMS is.

### Data Combining
SQL Query: [Data Combining](https://github.com/nevena-rogic/Google-Data-Analytics-Capstone-Case-Study-1/blob/main/1.%20Data%20Combining.sql)

12 CSV files are uploaded and imported as tables in the datasets formatted as '2024_tripdata'. The table named '2024_tripdata.combined_data' is created, and contains 5,860,568 of rows.

### Data Exploration
SQL Query: [Data Exploration](https://github.com/nevena-rogic/Google-Data-Analytics-Capstone-Case-Study-1/blob/main/2.%20Data%20Exploration.sql)

In order to get introduced to data before cleaning them, I've explored them.

I have noted following:

1. Number of **null values** in each column is shown in the following table:
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika1.PNG)

2. **Ride_id** column. It has been checked for duplicate values, as it doesn't have null values, and **211 duplicate** rows were found.

   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika2.PNG)

3. **Ride_id** column. Length of all values in this column is 16, so there is no need for cleaning.

4. **Rideable_type** column. There are 3 unique types of bikes in our dataset.
   
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika3.PNG)

5. **Ride_length** column. New column ride_length can be created based on the values of existing columns started_at and ended_at. There 
   are 7,490 rides with a duration longer then a day, and 131,256 rides that lasted less then a minute, and they will be excluded 
   during data cleaning process.

6. Other two columns that may be created are **day_of_week** and **month**.

7. **Start_station_name** and **start_station_id** columns. There are 1,073,951 missing rows in either of these columns which need to 
   be excluded.

8. **End_station_name** and **end_station_id** columns. There are 1,104,653 missing rows in either of these columns which need to be 
   excluded.

9. **Member_casual** column. This column contains 2 unique types of users.

10. **Start_station_id** and **end_station_id** columns. These columns needs to be excluded since they do not add values to our analysis.

### Data Cleaning
SQL Query: [Data Cleaning](https://github.com/nevena-rogic/Google-Data-Analytics-Capstone-Case-Study-1/blob/main/3.%20Data%20Cleaning.sql)
1. 3 new columns are created: **ride_length**, **day_of_week** and **month**.
2. All the rows having missing values are excluded.
3. Trips that lasted longer then a day or less then a minute are excluded.
4. All the duplicate rows from the **ride_id** column are excluded.
5. **Ride_id** column is set as primary key.
6. New cleaned table 2024_tripdata.cleaned_combined_data is created, counting 4,138,022 of rows.

## Analyze and Share
SQL Query: [Data Analysis](https://github.com/nevena-rogic/Google-Data-Analytics-Capstone-Case-Study-1/blob/main/4.%20Data%20Analysis.sql)

Data Visualization: [Tableau](https://www.tableau.com/)

I queried 2024_tripdata.cleaned_combined_data and created visualizations in Tableau. Observations are in the following:

1. The following slide shows the distribution of users during 2024.
    ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika5.PNG)

   There are 63,79% of member users, and 36,21% of casual users.
   
3. This slide shows the comparation of member and casual users by the type of bikes have been used.
    ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika4.PNG)

   The values displayed in these 3 charts represent the distribution of total trips, expressed as a percentage of the overall 
   dataset. The most frequently used bike types, in descending order, are classic bikes, folowed by the electric bikes, and electric
   scooters. 

5. Next slides show distribution of rides per month, day of the week, and hour of a day by users.
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika9.PNG)
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika11.PNG)
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika8.PNG)

   **Per month**: Both casual users and members show similar patterns in their monthly trips, with higher trip numbers during the 
   spring and summer months and a decline in the winter.

   **Per day of week**: When comparing days of the week, it is observed that casual users take more trips on weekends, whereas members 
   tend to ride less on weekends compared to weekdays.

   **Per hour**: Members show two peak periods in the number of trips throughout the day: one in the morning between 6 AM and 9 AM and 
   another in the late afternoon and early evening from around 4 PM to 7 PM. In contrast, the number of trips taken by casual riders 
   increases steadily throughout the day, reaching a peak in the early evening before declining afterward.

   These observations suggest that members primarily use bikes for commuting to and from work on weekdays, whereas casual users tend 
   to ride throughout the day, especially on weekends, likely for leisure. Both groups show the highest activity levels during the 
   spring and summer months.
   
6. Next slides show duration of rides per month, day of week, and hour of a day by users.
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika12.PNG)
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika13.PNG)
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika14.PNG)

   It is important to note that casual users generally cycle for longer periods than members on average. While the average ride 
   duration for members remains relatively consistent throughout the year, week, and day, casual users show more variation in their 
   cycling patterns. They tend to have longer trips during the spring and summer months, on weekends, and between 10 AM and 2 PM each 
   day; in contrast, they take shorter trips between 5 AM and 8 AM.

7. Next slides show the analysis of locations of starting and ending stations by users.
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika18.PNG) ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika19.PNG)
   ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika16.PNG) ![image](https://github.com/nevena-rogic/slike-case-study-1/blob/main/slika17.PNG)

   In these 4 slides, the distribution of the starting and ending points of the rides is clearly visible.

## Act
Based on the analysis of behavior of users, some marketing strategies for converting casual riders into members are as follows:

1. **Seasonal Membership Offers**: Since casual riders are most active during the spring and summer months, discounted or special memberships can be offered during this period. 

2. **Weekend Promotions**: Casual riders tend to cycle more on weekends, so exclusive weekend deals can be introduced, such as "Weekend Rider Offer: Sign up for a membership this weekend and get 10% off for the first 3 months!".

3. **Location-Based Campaigns**: The data from the map can be used to target the most popular starting and ending locations. Location-based marketing campaigns can be implemented, offering promotions like "Join us at [popular location] and get a free ride or a discount on your first month of membership!" or setting up kiosks at these high-traffic areas where casual riders frequent.

4. **Membership Cards and Loyalty Programs**: A membership card that allows riders to collect points based on the number of trips or total ride duration can be introduced. Rewards such as free rides, discounts on renewals, or exclusive access to events can be offered. For example, "Earn points with every ride and unlock discounts or special perks with our membership card!"

5. **Time-Sensitive Offers for Peak Hours**: Casual riders are more likely to ride in the early evening and between 10 AM and 2 PM, so time-limited offers targeting those specific hours can be created. For example, "Sign up before 2 PM today and get a 20% discount on your membership for the next 3 months!" or "Ride during peak hours and get double points for membership rewards!".

 

