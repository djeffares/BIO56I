################################################################################################
#Population Genetics & Evolution - BIO00056I
#Influenza Virus Practical
################################################################################################

#set your working directory
#Your working directory will be different!
setwd("~/Library/CloudStorage/GoogleDrive-daniel.jeffares@york.ac.uk/My Drive/modules/BIO56I/workshops/influenza/workshop-files")

#You can use the Session menu to set this with:
#Session menu  > Set Working Directory > Choose Directory
#then select the directory where your files are.

################################################################################################
#Wellington data
################################################################################################
#load the tidyverse
library(tidyverse)

#open your distances file, into a data frame:
#Your distance file may have a different name
flu <- as_tibble(read.table("H3N2_wellington.distances.txt",h=T))

#calculate how many years between two groups
flu$time.passed <- flu$date2 - flu$date1

#see if distance increases with time, as mutations accumulate
#make the plot
flu_plot<-ggplot(flu,aes(x=time.passed, y= Distance))+
  geom_point()+
  xlab("time distance between groups (years)")+
  ylab("genetic distance between groups")+
  theme_classic()

#view the plot
flu_plot 

#now add a line of best fit:
flu_plot +
  geom_smooth(method="lm")


#examine whether the correlation is statistically significant: 
cor.test(flu$time.passed,flu$Distance)

#################################################################################################
#You should see a good correlation between genetic distance and time distance.
#What causes this? (Which processes of evolution) 
#Why is there such a strong correlation?
  #We can observe this relationship over just a few decades*. 
  #What does this tell us about the rate of change*?
#################################################################################################

#NOW GO BACK TO THE WORKSHOP EXERCISES



################################################################################################
#Tasman sea data
################################################################################################


#open the Tasman genetic distance data
tas <- read_csv("H3N2_tasman.distances.csv")

#add country1 and country2 columns
tas$country1 <- NA
tas$country2 <- NA

#label the countries using grep
tas[grep("NZ", tas$region1),]$country1 = "NZ"
tas[grep("AUS", tas$region1),]$country1 = "AUS"

tas[grep("NZ", tas$region2),]$country2 = "NZ"
tas[grep("AUS", tas$region2),]$country2 = "AUS"


#add a comparison.type column
tas$comparison.type <- NA

#get the within country data
tas[which(tas$region1 == tas$region2),]$comparison.type <- 'within country'
tas[which(tas$region1 != tas$region2),]$comparison.type <- 'between country'

#plot this data 
#to examine whether genetic distances differ
#within a country vs between countries
ggplot(tas,aes(y=Distance,x=comparison.type))+
  geom_boxplot()+
  xlab("genetic distance comparison")+
  ylab("genetic distance")

#test whether there is any significant difference
#between the Distance within vs between countries
wilcox.test(Distance ~ comparison.type, data = tas)

#Now go back to the exercises, to think about this data.


################################################################################################
#END
################################################################################################

