# BIO00056I GWAS workshop script ----

# SET UP ----
#clear all the previous data
rm(list = ls())

#load the tidyverse
library(tidyverse)

#set working directory
#your working directory will be different!
#setwd("/Users/dj757/gd/modules/BIO56I/workshops/gwas")

#load the data
load("data/gwas-data.Rda")

# CLEAN THE DATA
salt <- salt |>
  select(Predictor,Chr, BP, Effect_size, Wald_P, MAF) |>
  filter(Chr > 0)
view(salt)

gluc <- gluc |>
  select(Predictor,Chr, BP, Effect_size, Wald_P, MAF) |>
  filter(Chr > 0)
view(gluc)

heat <- heat |>
  select(Predictor,Chr, BP, Effect_size, Wald_P, MAF) |>
  filter(Chr > 0)
view(heat)

rich <- rich |>
  select(Predictor,Chr, BP, Effect_size, Wald_P, MAF) |>
  filter(Chr > 0)


rm(twotraits)

# save data
save.image("BIO00056I-GWAS-workshop.Rda")

# SALT TRAIT -----

# examine what is in the salt data frame
head(salt)
nrow(salt)
summary(salt)
View(salt)

## Manhattan plot ----
salt |>
  filter(Chr > 0) |>
  ggplot(aes(x=BP, y=-log10(Wald_P)))+
    geom_point(size = 0.5)+
    facet_wrap(~Chr)+
    xlab("position")+
    ylab("-log10(P-value)")+
  geom_hline(yintercept=-log10(1e-5),col=2,lty=2)

ggsave("workshop9/plots/manhattan-salt.pdf")


## Histogram of Effect sizes ----
salt |>
  ggplot(aes(Effect_size)) +
  geom_histogram(bins = 50)
ggsave("workshop9/plots/hist-salt.pdf")


# GLUCOSE & FRUCTOSE GROWTH ----

## Manhattan plot ----
gluc |>
  filter(Chr > 0) |>
  ggplot(aes(x=BP, y=-log10(Wald_P)))+
  geom_point(size = 0.5)+
  facet_wrap(~Chr)+
  xlab("position")+
  ylab("-log10(P-value)")+
  geom_hline(yintercept=-log10(1e-5),col=2,lty=2)

ggsave("workshop9/plots/manhattan-glucose.pdf")


## Histogram of Effect sizes ----
gluc |>
  ggplot(aes(Effect_size)) +
  geom_histogram(bins = 50)

ggsave("workshop9/plots/hist-glucose.pdf")


# TWO TRAITS TOGETHER ----

## Make combined data frame

twotraits <- inner_join(
  gluc,salt,by="Predictor",suffix = c(".gluc", ".salt"))
view(twotraits)
  
names(salt)  
  

## Manhattan plot ----



gluc |>
  filter(Chr > 0) |>
  ggplot(aes(x=BP, y=-log10(Wald_P)))+
  geom_point(size = 0.5)+
  facet_wrap(~Chr)+
  xlab("position")+
  ylab("-log10(P-value)")+
  geom_hline(yintercept=-log10(1e-5),col=2,lty=2)+
  
  




