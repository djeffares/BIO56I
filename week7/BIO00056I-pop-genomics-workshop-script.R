################################################
#INTRODUCTION
#This script should be run in RStudio
#The script plots principal component data that describes 
#populations of Leishmania collected from Manaus and elsewhere

################################################
#AIM
#The aim of your work here is to understand
#how principal components analysis (PCA)
#can help us to understand natural populations 
################################################

################################################
#Step 1. Setting up R and data
################################################

#clear all previous data
rm(list=ls())

#set your working directory to where you want to save the plots
#you can use the command below, or use menus: Session > Set Working Directory > Choose Directory
setwd("some folder")

#load the tidyverse
library(tidyverse)
library(ggpubr)

#load the data
load("BIO00056I-pop-genomics-workshop-data.Rda")

#look at the data we have
ls()

#pca.meta
  #contains the PCA coordinates and also some meta data
  #for a tidyverse data analysis is makes sens to have all this data together
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

#only Manaus samples
plot2 <-ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
            aes(x=PC1,y=PC2,colour=Species), shape=1,size=2,width = jitter,height = jitter)+
  theme_light()

#plot the Manaus and other samples side by side
plot1.plot2 <- ggarrange(
  plot1,plot2,
  ncol = 2, nrow = 1, labels  = "AUTO", hjust = c(-2.5, -2.5)
)

#view your plot:
plot1.plot2 

#everything together, with Manaus samples as black circles
plot3 <-  ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species != "Manaus"),
              aes(x=PC1,y=PC2,colour=Species),alpha = 0.25, shape=1,size=2,
              width = jitter,height = jitter)+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
              aes(x=PC1,y=PC2,colour=Species),alpha = 1,shape=1,size=2,
              colour=1,width = jitter,height = jitter)+
  theme_light()
plot3

#now lets save the plots
ggsave("Lguy.PC1PC2.Species-colours.side-by-side.20231111.png", 
       plot1.plot2, width = 15, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.non-manaus.20231111.png", 
       plot1, width = 7, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.only-manaus.20231111.png", 
       plot2, width = 7, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.everything.20231111.png", 
       plot3, width = 7, height = 7)


################################################
#END
################################################

