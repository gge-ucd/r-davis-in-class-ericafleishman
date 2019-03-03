# week 8 assignment

library (tidyverse)
library(lubridate)

# Part 1

# Download the American River data set
am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

# Make a datetime column by using paste to combine the date and time columns
am_riv$datetime <- paste (am_riv$Date, " ", am_riv$Time, sep = "")

# Convert it to a datetime
am_riv$datetime <- ymd_hms (am_riv$datetime, tz = "America/Los_Angeles")

# Calculate the weekly mean, max, and min water temperatures

am_riv_2 <- am_riv %>% 
  filter (!is.na(datetime)) %>% 
  mutate (week = week(datetime)) %>% 
  group_by (week) %>% 
  mutate (week_mean_temp = mean(Temperature)) %>% 
  mutate (week_max_temp = max(Temperature)) %>% 
  mutate (week_min_temp = min(Temperature)) 
view (am_riv_2)
  
# Plot as a point plot on the same figure

am_riv_2 %>% ggplot ()+
  geom_point(aes(x = week, y = week_mean_temp), size = 2, color = "blue") + 
  geom_point(aes(x = week, y = week_max_temp), size = 2, color = "black") + 
  geom_point(aes(x = week, y = week_min_temp), size = 2, color = "orange")

# Calculate the hourly mean Level for April through June and make a line plot (y axis should be the hourly mean level, x axis should be datetime)

am_riv_3 <- am_riv_2 %>% 
  mutate (month = month(datetime)) %>% 
  filter (month==4:6) %>% 
  mutate (hour = hour(datetime)) %>% 
  mutate (hourly_mean_Level = mean(Level))

am_riv_3 %>% 
  ggplot (aes(x=datetime, y = hourly_mean_Level))+
  geom_line (alpha = 0.5)

# Part 2

# Use the mloa_2001 data. Remove the NAs (-99 and -999) and create a datetime column (we did this in class).

load("data/mauna_loa_met_2001_minute.rda")

mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)

# Write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column (so if your data set does not already have a datetime column, you’ll need to create one)

# if I was doing this in ggplot without writing a function
# mloa_2001_b <- mloa_2001 %>%
#  filter (month == 5) %>%
#  filter (temp_C_2m != -999.9)
# mloa_2001_b %>% ggplot ()+
# geom_point(aes(x = datetime, y = temp_C_2m), size = 1, color = "blue") 

mloa_2001_b <- mloa_2001 %>%
  filter (temp_C_2m != -999.9)

plot_temp <- function (month_to_plot, dat = mloa_2001_b) {
  df <- filter (dat, month == month_to_plot)
  plot <- df %>% 
    ggplot()+ geom_line(aes(x = datetime, y = temp_C_2m), color = "blue")
  return (plot)
}
plot_temp(5)
