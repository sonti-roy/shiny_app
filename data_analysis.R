library(ggplot2)
library(dplyr)
library(readr)

source("statistics_function.R")


md <- read_csv("medical_data.csv")

descriptive_stats(md,"Length_of_Stay")
