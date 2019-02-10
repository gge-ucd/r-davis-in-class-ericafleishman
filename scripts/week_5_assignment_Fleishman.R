# week_5_assignment_Fleishman.R

# Read combined.csv into R with the tidyverse command read_csv(), and assign it to an object named "surveys"

library(tidyverse)
surveys <- read_csv("data/combined.csv")

# Using tidyverse functions and pipes, subset to keep all the rows where weight is between 30 and 60, then print the first few (maybe… 6?) rows of the resulting tibble.

surveys %>%
  filter (weight >= 30) %>% 
  filter (weight <= 60)  

# Make a tibble that shows the max (hint hint) weight for each species+sex combination, and name it biggest_critters. Use the arrange function to look at the biggest and smallest critters in the tibble (use ?, tab-complete, or Google if you need help with arrange).

biggest_critters <- surveys %>% 
  group_by(species_id, sex) %>% 
  filter (!is.na (weight)) %>% 
  summarize (max_weight = max(weight)) %>% 
  arrange (max_weight) %>% 
  view()

# Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

surveys %>% 
  group_by(species_id, weight) %>%
  filter(is.na(weight)) %>% 
  tally () %>% 
  view()

surveys %>% 
  group_by(plot_id, weight) %>%
  filter(is.na(weight)) %>% 
  tally () %>% 
  arrange (weight) %>% 
  view()

# Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight. The resulting tibble should have 32,283 rows.

surveys_avg_weight <- surveys %>%
  filter (!is.na (weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate (avg_weight = mean(weight)) %>% 
  select (species_id, sex, weight, avg_weight)

# Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).

surveys_avg_weight %>% 
  mutate (above_average = (weight >= avg_weight)) %>% 
  view

# Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?

surveys_scaled <- surveys %>% 
  mutate (scaled_weight = scale (weight, center = TRUE, scale = TRUE)) %>% 
  filter (!is.na (scaled_weight)) %>% 
  sort (scaled_weight, decreasing = FALSE) %>% 
  view # what am I doing wrong here -- I can get the code to run but cannot view



  
