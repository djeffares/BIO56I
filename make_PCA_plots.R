# make PCA plots

library(tidyverse)
library(ggpubr)

pca_coords <- read_tsv("Lguy_qual1000.MAC1.MAF0.01.renamed2_filtBialleli_annotate2_1_1_281361.pruned0.5_PCA.eigenvec")
pca_coords2 <- read_tsv("Lguy_qual1000.MAC1.MAF0.01.renamed2_filtBialleli_annotate.pruned0.5_full_set.eigenvec")

cluster_A <- as_vector(read_tsv("cluster_A_ind.txt",col_names=F)$X1)
cluster_B <- as_vector(read_tsv("cluster_B_ind.txt",col_names=F)$X1)

cluster_A
cluster_B
pca_coords

pca_coords <- pca_coords |>
  mutate(population = case_when(
    IID %in% cluster_A ~ "A",
    IID %in% cluster_B ~ "B",
    TRUE ~ NA_character_ # Assigns NA if an IID is in neither cluster
  ))

pca_coords2 <- pca_coords2 |>
  mutate(population = case_when(
    IID %in% cluster_A ~ "A",
    IID %in% cluster_B ~ "B",
    TRUE ~ NA_character_ # Assigns NA if an IID is in neither cluster
  ))


pca12plot <- pca_coords2 |>
  filter(!is.na(population)) |>
  ggplot(aes(x = PC1, y = PC2, colour = population, shape = population)) +
  geom_point(size = 5, stroke = 1.5) +
  scale_color_manual(values = c("A" = "red", "B" = "blue")) +
  scale_shape_manual(values = c("A" = 1, "B" = 2)) +
  theme_classic2()
pca12plot
ggsave("pca12plot.jpeg", pca12plot, height=7, width=7)



pca13plot <- pca_coords2 |>
  filter(!is.na(cluster)) |>
  ggplot(aes(x=PC1, y=PC2, colour = population)) +
  geom_point(size=3)+
  scale_color_manual(values = c("A" = "red", "B" = "blue")) +
  theme_classic()




pca13plot <- pca_coords2 |>
  filter(!is.na(cluster)) |>
  ggplot(aes(x=PC1, y=PC3, colour = cluster)) +
  geom_point(size=3)+
  scale_color_manual(values = c("A" = "red", "B" = "blue")) +
  theme_classic()

pca14plot <- pca_coords2 |>
  filter(!is.na(cluster)) |>
  ggplot(aes(x=PC1, y=PC4, colour = cluster)) +
  geom_point(size=3)+
  scale_color_manual(values = c("A" = "red", "B" = "blue")) +
  theme_classic()



