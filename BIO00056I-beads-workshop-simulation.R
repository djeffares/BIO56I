# BIO00056I beads workshop test script -----------------------------------------

## Principles -----------------------------------------

#The working principles we identified were:
  
# Allele-frequency change as the central quantity.
# Genetic drift vs. natural selection as alternative explanations for change.
# Population size and its effect on drift.
# Gene flow between populations and population structure.
# Most importantly: a pattern in genetic data does not uniquely identify its cause
# students should learn to consider multiple explanations.


# Narrative summary  -----------------------------------------

# You'd use 10 groups of up to six students, with about 400 beads total, so you can
# reuse them across experiments. Have 20 beads per population per group, half one color
# half the other. For drift, groups Yeah, for drift, groups randomly sample into the
# next generations, record allele frequencies in the shared spreadsheet, then briefly
# compare across groups. For two populations, start them identical, run drift separately
# for a few generations. Then let a couple of beads migrate between them, and watch how
# that changes divergence. For selection, use the die rule. White beads always reproduce,
# but black beads only reproduce on certain die rolls. Then compare the trend to drift.
# And finally, discuss what evidence would help distinguish mechanisms if they only saw a
# graph.


## Code  -----------------------------------------

### Libraries and command line params  -----------------------------------------

# tidyverse, readxl, something to parse command line options

# All variables are (Ne, Gn, M)
# command line options are: 
# Ne (population size), 
# Gn (number of generations): we can refer to this as G1, G2, G3 etc
# M (migration rate) (as NUMBER of beads exchanged)
# S selection coefficient (not sure how to do this yet

###  




## How to play the game --------------------------------------------------------

# We have 10 tables, with 5 students each
# Run the simulation for each table separately

# Step 0: set up
# Each table has a bag that contains black and white beads
# They do not know the allele frequency!

# Step 1: birth
# Each table selects B beads from a jar (at random), so the total beads selected = Ne

# Step 2: Selection & breeding
# If no selection (default): everyone breeds: double the number, keeping the total proportions the same
# With selection: how many more bklack beads

# Step 3: 



