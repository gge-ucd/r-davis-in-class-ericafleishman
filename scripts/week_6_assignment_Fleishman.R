# week 6 assignment

library (tidyverse)

gapminder <- read.csv ("~/Documents/Erica/2019/github/r-davis-in-class-ericafleishman/data/gapminder.csv")

# Modify the following code to make a figure that shows how life expectancy has changed over time

# ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
#  geom_point()

ggplot(gapminder, aes(x = year, y = lifeExp)) + 
  geom_point()

# Look at the following code. What do you think the scale_x_log10() line is doing? What do you think the geom_smooth() line is doing?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# I think the scale x log10() line is taking the log of gdpPercap, effectively transforming the data from a curve to a line and spreading out the data rather than compressing most of the data toward the smaller values along the x-axis
# And now I looked it up . . . yup it's a logarithmic transform

# I think geom_smooth() is adding a dashed black line through the plot that's essentially a regression line. 
# And now I looked it up on the tidyverse reference . . . "Aids the eye in seeing patterns in the presence of overplotting"

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?

gapminder %>% 
ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
