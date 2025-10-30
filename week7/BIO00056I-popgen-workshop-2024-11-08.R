##date 2024-11-08
##Summary plotting of Leishmania guyanensis PCA 
##author dj757
##keywords guyanensis, PCA
#data from João Cunha

################################################
#Step 1. Setting up R and data
################################################

#clear all previous data
rm(list=ls())

#set your working directory
#You will need to alter this to YOUR working directory
setwd("/Users/dj757/gd/modules/BIO56I/workshops/population-genomics")

#load the tidyverse
library(tidyverse)
library(ggpubr)

#load the data
load("BIO00056I-popgen-workshop-2024-11-08.Rda")

#Lets look at the data
ls()

#pca.meta
  #contains the PCA coordinates and also some meta data
  #for a tidyverse data analyis is makes sens to have all this data together
#jitter is just a number, 0.005
  #this helps to make the plots look better

#look at pca.meta with:
view(pca.meta)

#Note that:
  #The samples we are interested in we just call the species 'Manaus'
  #We call their location 'Amazon'
  #We do this so we keep our minds open about what we have
  

################################################
#Step 2. Making PCA plots
################################################

#PCA plot: PC1, PC2 colour by species
#non-Manaus samples
plot1 <- ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species != "Manaus"),
      aes(x=PC1,y=PC2,colour=Species), shape=1,size=2,width = jitter,height = jitter)+
  theme_light()
plot1

#only Manaus samples
plot2 <-ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
            aes(x=PC1,y=PC2,colour=Species), shape=1,size=2,width = jitter,height = jitter)+
  theme_light()
plot2

#plot the Manaus and other samples side by side
plot1.plot2<- ggarrange(
  plot1,plot2,
  ncol = 2, nrow = 1, labels  = "AUTO", hjust = c(-2.5, -2.5)
)
plot1.plot2

################################################################################
#Look at the data:
#In this PCA plot different species occupy certain positions.
#What species do *most* of the samples from Manaus appear to be?
################################################################################


#now plot everything together
#with manaus samples as black circles
plot3 <-  ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species != "Manaus"),
              aes(x=PC1,y=PC2,colour=Species),alpha = 0.25, shape=1,size=2,
              width = jitter,height = jitter)+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
              aes(x=PC1,y=PC2,colour=Species),alpha = 1,shape=1,size=2,
              lwd=3,colour=1,width = jitter,height = jitter)+
  theme_light()
plot3

#now lets save the plots
ggsave("Lguy.PC1PC2.Species-colours.side-by-side.png", 
       plot1.plot2, width = 15, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.non-manaus.png", 
       plot1, width = 7, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.only-manaus.png", 
       plot2, width = 7, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.everything.png", 
       plot3, width = 7, height = 7)

################################################
#make PCA plots: PC3 and PC4
################################################

#As this is a module about Population Genetics & Evolution (not R)
#We have created all the same plots for PC3 and PC4 for you :-)

################################################
#END OF PLOTTING
#You can go back to the workshop exercises 
################################################


################################################
#Below we show how we created all the other plots.
#You do NOT need to run this code as we made the plot for you.
################################################


#PCA plot: PC3, PC4 colour by species
#non-Manaus samples
plot4 <- ggplot(pca.meta,aes(x=PC3,y=PC4,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species != "Manaus"),
              aes(x=PC3,y=PC4,colour=Species), shape=1,size=2,width = jitter,height = jitter)+
  theme_light()
plot4

#only Manaus samples
plot5 <-ggplot(pca.meta,aes(x=PC3,y=PC4,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
              aes(x=PC3,y=PC4,colour=Species), shape=1,size=2,width = jitter,height = jitter)+
  theme_light()
plot5

#plot the Manaus and other samples side by side
plot4.plot5<- ggarrange(
  plot4,plot5,
  ncol = 2, nrow = 1, labels  = "AUTO", hjust = c(-2.5, -2.5)
)
plot4.plot5



################################################################################
#Look at the data:
#In this PCA plot different species occupy certain positions.
#What species do *most* of the samples from Manaus appear to be?
################################################################################


#now plot everything together
#with manaus samples as black circles
plot6 <-  ggplot(pca.meta,aes(x=PC3,y=PC4,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species != "Manaus"),
              aes(x=PC3,y=PC4,colour=Species),alpha = 0.25, shape=1,size=2,
              width = jitter,height = jitter)+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
              aes(x=PC3,y=PC4,colour=Species),alpha = 1,shape=1,size=2,
              lwd=3,colour=1,width = jitter,height = jitter)+
  theme_light()
plot6

#now lets save the plots
ggsave("Lguy.PC3PC4.Species-colours.side-by-side.png", 
       plot4.plot5, width = 15, height = 7)
ggsave("Lguy.PC3PC4.Species-colours.non-manaus.png", 
       plot4, width = 7, height = 7)
ggsave("Lguy.PC3PC4.Species-colours.only-manaus.png", 
       plot5, width = 7, height = 7)
ggsave("Lguy.PC3PC4.Species-colours.everything.png", 
       plot6, width = 7, height = 7)

################################################
#End of script
################################################


