rm(list = ls(all = TRUE))
library(maps)## load maps first to avoid map conflict with purrr
library(MASS) ## load MASS and matrixStats first to avoid select and count conflict
library(matrixStats) 
library(tidyverse)
library(dslabs)
ds_theme_set()

## Adapted from Hadley Wickham and Garrett Grolemund's r4ds
options(digits = 3, width = 72, formatR.indent = 2)

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  cache = TRUE,
  width = 72,
  tidy.opts=list(width.cutoff=72, tidy=TRUE),
  out.width = "70%",
  fig.align = 'center',
  fig.width = 6,
  fig.height = 3.708,  # width * 1 / phi
  fig.show = "hold")

options(dplyr.print_min = 5, dplyr.print_max = 5)

