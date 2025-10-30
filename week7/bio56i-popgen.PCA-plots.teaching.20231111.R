##date 20231111
##summary plotting of Leishmania guyanensis PCA 
##author dj757
##keywords guyanensis, PCA
#data from João Cunha
#see: BIO00056I-pop-genomics-data.20231111.txt

################################################
#Step 1. Setting up R and data
################################################

#clear all previous data
rm(list=ls())

#set your working directory
#You will need to alter this, perhaps to bio56I-popgen
setwd("some folder")

#load the tidyverse
library(tidyverse)
library(ggpubr)

#load the data
load("bio00056i-popgen.pca.teaching.20231111.Rda")

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
#non-manuas samples
plot1 <- ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species != "Manaus"),
      aes(x=PC1,y=PC2,colour=Species), shape=1,size=2,width = jitter,height = jitter)+
  theme_light()

#only manuas samples
plot2 <-ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
            aes(x=PC1,y=PC2,colour=Species), shape=1,size=2,width = jitter,height = jitter)+
  theme_light()

#plot the Manuas and other samples side by side
plot1.plot2<- ggarrange(
  plot1,plot2,
  ncol = 2, nrow = 1, labels  = "AUTO", hjust = c(-2.5, -2.5)
)

#everything together, with Manuas samples as black circles
plot3 <-  ggplot(pca.meta,aes(x=PC1,y=PC2,colour=Species))+
  geom_jitter(data = subset(pca.meta, Species != "Manaus"),
              aes(x=PC1,y=PC2,colour=Species),alpha = 0.25, shape=1,size=2,
              width = jitter,height = jitter)+
  geom_jitter(data = subset(pca.meta, Species == "Manaus"),
              aes(x=PC1,y=PC2,colour=Species),alpha = 1,shape=1,size=2,
              lwd=3,colour=1,width = jitter,height = jitter)+
  theme_light()

#now lets save the plots
ggsave("Lguy.PC1PC2.Species-colours.side-by-side.20231111.png", 
       plot1.plot2, width = 15, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.non-manuas.20231111.png", 
       plot1, width = 7, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.only-manuas.20231111.png", 
       plot2, width = 7, height = 7)
ggsave("Lguy.PC1PC2.Species-colours.everything.20231111.png", 
       plot3, width = 7, height = 7)

################################################
#make PCA plots: PC3 and PC4
################################################

#As this is a course about Population Genetics & Evolution (not R)
#we have created all the same plots for PC3 and PC4 for you :-)

################################################
#END OF PLOTTING FOR NOW
################################################

#You are done with plotting for now
#You can go back to the workshop exercises via this link
#https://docs.google.com/document/d/1dvmV0aZ6c8_3s1ocDujeHWq_4FHVoyBto8cGFVo8Bhw/edit#heading=h.3316bdg9eiod

################################################



################################################
