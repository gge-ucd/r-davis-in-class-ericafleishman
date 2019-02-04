# week_4_assignment_Fleishman

# Read the data file into R
read.csv(file = "~/Documents/Erica/2019/github/R_Davis/data/combined.csv")

# Create a dataframe named "surveys"
surveys <- read.csv(file = "~/Documents/Erica/2019/github/R_Davis/data/combined.csv")

# Subset to the first column and columns 5-8, and the first 400 rows
# I am sure there is a more elegant way to do this, but I do not know how
surveys_culled <- surveys[1:400,1:8]
surveys_culled2 <- surveys_culled[,-2]
surveys_culled3 <- surveys_culled2[,-2]
surveys_subset <- surveys_culled3[,-2]

# Select all rows that have a hindfoot_length greater than 32

subset (surveys_subset, hindfoot_length > 32)

# Save these in a new dataframe named surveys_long_feet

surveys_long_feet <- subset (surveys_subset, hindfoot_length > 32)

# Plot its hindfoot_length values as a histogram with the hist function

surveys_long_feet[,"hindfoot_length"]

hist (surveys_long_feet$hindfoot_length)

# Change the column hindfoot_lengths into a character vector

as.character(surveys_long_feet$hindfoot_length)

# Plot the hindfoot_lengths in a histogram

hist (surveys_long_feet$hindfoot_length)

