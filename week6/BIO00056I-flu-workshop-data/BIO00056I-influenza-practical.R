################################################################################################
#BIO00056I Practical 2
#Influenza Virus 
#Thanks to Francois Balloux (UCL), who designed this workshop.
################################################################################################
#First make a folder for this script, and all your work and data 
#Move all the data and the scripts to this folder

#clear all your previous variables
rm(list=ls())

#Now set your working directory to this folder
#Your working directory will be different, to this line of code will need an edit
setwd("/Users/dj757/gd/modules/BIO00056I-Genes-and-genomes-in-populations-and-evolution/workshops/influenza/2022")


################################################################################################
#Wellington data
################################################################################################

#Once you have downloaded the distances file from Mega, open it in a plan text editor
#such as Notepad. Do NOT open it in Microsoft Word!

#Delete the lines at the start of the file that are not data lines, like this:
#1985 1989 0.01817
#1985 1990 0.02176

#Also delete all non-data lines at the *end* of the file, like these ones:
#Table. Estimates of Evolutionary Divergence over Sequence Pairs between Groups

#Save the file as distancedata.txt in your folder 

#now open your distances file, into a data frame:
#Your distance file may have a different name
flu <-read.table("H3N2_Wellington_distancedata.txt",h=F)

#add column names
names(flu)<-c("strain1","strain2","distance")

#take a look at your file
#note that the year groups are called Strain.1 and Strain.2
#not so helpful, but it will do
#and the genetic distance is called distance

View(flu)

#calculate how many years between each group comparison
flu$time.passed = flu$strain2 - flu$strain1

#see if distance increases with time, as mutations accumulate
plot(flu$time.passed,flu$distance,
     xlab ="time (years between strains)",
     ylab ="genetic distance")

#add a line of best fit:
abline(lm(flu$distance ~ flu$time.passed),col=2,lty=2)

#wow! looks like there is a strong correlation
#let's test it to see if it statistically significant
cor.test(flu$time.passed,flu$distance)

#What does this indicate about genetic change over time?
#Hint Molecular Clock

#PS: to make a pdf of this plot:
pdf('-flu-clock.pdf')
plot(flu$time.passed,flu$distance,
     xlab ="time (years between strains)",
     ylab ="genetic distance")
abline(lm(flu$distance ~ flu$time.passed),col=2,lty=2)
dev.off()


################################################################################################
#Tasman sea data
################################################################################################
#Once you have downloaded the Tasman sea distance data
#Move it to your  directory
#remove all the non-data lines using Notepad
#and save it as "H3N2_tasman_distance_data.csv"

#Now open this data file
tas <-read.csv("H3N2_tasman_distance_data.csv",h=F)
#add column names and view the file
names(tas)<-c("region1","region2","distance")
View(tas)

#Now we adjust the regions, since we need to tell R which regions are from 
#New Zealand and which are from Australia (not common knowledge in São Paulo!)
#label all regions from NZ, using grep

#Create a new data frame column that defines 'within region'
#and between region genetic distances
tas$type = NA
#Now use grep to populate the columns
tas[which(tas$region1 == tas$region2), ]$type = "within"
tas[which(tas$region1 != tas$region2), ]$type = "between"

#check that it worked
View(tas)

#now load ggplot2 and plot all the genetic distances
library(ggplot2)
ggplot(tas, aes(factor(type), distance)) +
    geom_violin() +
    xlab("comparison type") +
    ylab("genetic distance") +
    theme_classic()

#If ggplot does not work, you can plot this with:
boxplot(
  subset(tas, type=="within")$distance,
  subset(tas, type=="between")$distance,
  ylab="genetic distance",
  xlab="comparison type",
  names=c("within","between")
)

View(tas)

#Doesn't look like there is any significant difference between  
#genetic distances between vs within regions

#make two subsets, and test for significant differences
within <- subset(tas, type == "within")
between <- subset(tas, type == "between")
wilcox.test(within$distance, between$distance)

#Note:
#The Wilcoxon Signed Rank Test is a non-parametric alternative to a T-test.
#It is useful,because it does not assume that data are normally distributed

###################################
#Discuss with your group:
###################################

#What would we expect if Australians and New Zealanders
#a) Shared viruses freely?
#b) Did not share viruses freely?

#Is there any other explanation for this data?
#Can you think of another application of this method other than sharing across geography?

#PS: to save all your data in an R Session, use
save.image("flu-workshop-data.Rda")
#to load it later, set work working directory, open R and type:
load("flu-workshop-data.Rda")

################################################################################################
#END
################################################################################################

