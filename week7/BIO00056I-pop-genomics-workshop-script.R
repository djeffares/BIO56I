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

# SET UP ----

#clear all previous data
rm(list=ls())

#set your working directory to where you want to save the plots
#you can use the command below, or use menus: Session > Set Working Directory > Choose Directory
setwd("/Users/dj757/gd/modules/BIO56I")

#load the tidyverse
library(tidyverse)
library(ggpubr)

## LOAD AND CLEAN DATA ----
load("BIO00056I-pop-genomics-workshop-data.Rda")

#look at the data we have
ls()
view(pca.meta)

#in pca.meta replace all instance sof Species=Manaus with Species='?'
pca.meta$Species[pca.meta$Species=="Manaus"] <- "?"

#Add new column called Manaus
pca.meta <- pca.meta |>
  mutate(Manaus = ifelse(Species == "?", "Manaus", "Other"))

#remove thos with unknown location
pca.meta<- pca.meta |>
  filter(!is.na(Location))
  

save.image("BIO00056I-pop-genomics-workshop-data2.Rda")

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

# PLOTS BY SPECIES ----

#PCA plot: PC1, PC2 colour by species
#non-Manaus samples
#non-Manaus samples
#Species-colours.non-manuas: populations5.jpg
populations3 <- ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(
    data = subset(pca.meta, Manaus != "Manaus"),
    aes(x=PC1,y=PC2,colour=Species), shape=1,size=3,stroke=2,alpha=0.5,
    width = 0.01, height = 0.01)+
  xlim(-0.45,0.1)+ylim(-0.1,0.3)+
  geom_hline(yintercept=0.05, linetype="dashed", color = "blue")+
  geom_vline(xintercept=0.05, linetype="dashed", color = "blue")+
  theme_light()+
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14,face="bold"))
populations3

#save plot as  populations3.jpg
ggsave("images/populations3.jpg", populations3, width = 7, height = 7)



#only Manaus samples
populations4 <-  ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(
    data = subset(pca.meta, Manaus == "Manaus"),
    aes(x=PC1,y=PC2,colour=Species), shape=1,size=3,stroke=2,alpha=0.5,
    width = 0.01, height = 0.01)+
  xlim(-0.45,0.1)+ylim(-0.1,0.3)+
  geom_hline(yintercept=0.05, linetype="dashed", color = "blue")+
  geom_vline(xintercept=0.05, linetype="dashed", color = "blue")+
  theme_light()+
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14,face="bold"))
populations4

#save plot as  populations4.jpg
ggsave("images/populations4.jpg", populations4, width = 12, height = 7)


#plot the Manaus and other samples side by side
populations3.populations4 <- ggarrange(
  populations3,populations4,
  ncol = 2, nrow = 1, hjust = c(-2.5, -2.5)
)
populations3.populations4

#view your plot:
populations3.populations4
#save plot as  populations3.populations4.jpg
ggsave("images/populations3.populations4.jpg", populations3.populations4, width = 15, height = 7)

#PLOTS BY LOCATION ----
view(pca.meta)

# colour by location: not Manaus
populations5 <-
  pca.meta |>
  filter(Manaus != "Manaus") |>
  #filter(!is.na(Location)) |>
  ggplot(aes(x=PC1,y=PC2,colour=Location))+
  geom_jitter(
    aes(x=PC1,y=PC2,colour=Location), shape=1,size=3,stroke=2,alpha=0.5,
    width = 0.01, height = 0.01)+
  xlim(-0.45,0.1)+ylim(-0.1,0.3)+
  geom_hline(yintercept=0.05, linetype="dashed", color = "blue")+
  geom_vline(xintercept=0.05, linetype="dashed", color = "blue")+
  theme_light()+
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14,face="bold"))
populations5

#save this image
ggsave("images/populations5.jpg", populations5, width= 10, height = 7)

# colour by location: Only Manaus
populations6 <-  
  #pca.meta |> 
  filter(pca.meta, Manaus == "Manaus") |>
  ggplot(aes(x=PC1,y=PC2,colour=Location))+
  geom_jitter(
    aes(x=PC1,y=PC2,colour=Location), shape=1,size=3,stroke=2,alpha=0.5,
    width = 0.01, height = 0.01)+
  xlim(-0.45,0.1)+ylim(-0.1,0.3)+
  geom_hline(yintercept=0.05, linetype="dashed", color = "blue")+
  geom_vline(xintercept=0.05, linetype="dashed", color = "blue")+
  theme_light()+
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14,face="bold"))
populations6

#save this image
ggsave("images/populations6.jpg", populations6, width= 10, height = 7)


#plot the Manaus and other samples side by side
populations5.populations6 <- ggarrange(
  populations5,populations6,
  ncol = 2, nrow = 1, hjust = c(-2.5, -2.5)
)
populations5.populations6

#save this image
ggsave("images/populations5.populations6.jpg", populations5.populations6, width= 15, height = 7)

view(pca.meta)


################################################
#END
################################################

