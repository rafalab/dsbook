library(tidyverse)
library(readr)

## download data (takes a few minutes)
url <- "http://files.grouplens.org/datasets/movielens/ml-latest.zip"
td <- tempdir()
print(td)
tf <- tempfile(tmpdir=td, fileext=".zip")
download.file(url, tf)

## read the data
movielens <- read_csv(unz(tf, "ml-latest/ratings.csv"))
movielens_titles <- read_csv(unz(tf, "ml-latest/movies.csv"))

## separate year from title and keep only recent movies
movielens_titles <- movielens_titles %>% 
  extract(title, c("title", "year"), regex = "(.*)\\s\\((\\d+)\\)", convert = TRUE) %>%
  filter(year >= 1972) 

movielens <- movielens %>% 
  filter(movieId %in% movielens_titles$movieId) %>%
  group_by(userId) %>%
  filter(n()>=1500) %>%
  ungroup() %>%
  group_by(movieId) %>%
  filter(n()>4) %>%
  ungroup() %>%
  select(movieId, userId, rating) %>%
  mutate(rating = as.integer(rating*2))

movielens_titles <- semi_join(movielens_titles, movielens, by = "movieId")

movielens_titles <- as.data.frame(movielens_titles)
movielens <- as.data.frame(movielens)

length(unique(movielens$userId))
## check
movielens %>% left_join(movielens_titles) %>% group_by(movieId) %>% summarize(avg = mean(rating), n=n(), title= title[1]) %>% arrange(desc(avg))
movielens %>% left_join(movielens_titles) %>% group_by(movieId) %>% summarize(avg = mean(rating), n=n(), title= title[1]) %>% filter(n>100) %>% arrange(desc(avg))
movielens %>% left_join(movielens_titles) %>% group_by(movieId) %>% summarize(avg = mean(rating), n=n(), title= title[1]) %>% filter(n>100) %>% arrange(avg)
