Project Proposal: Movie Recommender
================
Haolin Zhong (hz2771), Shaocong Zhang (sz3030), Yuxuan Wang (yw3608),
Boqian Li (bl2898)

## Motivation

In the era of information overload, pushing to users information
matching their preference has been a valuable application and a major
challenge in the field of data science. In this project, we proposed to
explore the movielens dataset, a dataset consisting of users’ rating and
tagging towards movies, and implement a demo movie recommendation
system.

## Intended final products

-   A report summarizing exploratory analysis results, recommendation
    algorithms used and predicted user-movie rating

-   A shiny app or dashboard giving movie recommendation

## Anticipated data sources

-   [MoiveLens
    dataset](https://grouplens.org/datasets/movielens/latest/)

-   Movie information scraped from [IMDb](https://www.imdb.com/)

## Planned analyses/ visualizations / coding challenges

### Planned analyses

-   Find popular movies and high-rating movies

-   Investigate the relationship among ratings and various factors,
    including movie genre, release year, rating time

-   Evaluate the similarity among users and among movies

-   Test the average ratings of the users, to investigate whether the
    rating criteria are different.(ANOVA)

-   Analyze the changes in the ratings of the same movie every year, or
    the changes in the ratings of each category of movies,and try to get
    a rule through the analysis

-   Construct model to predict the rating of a specific user towards a
    specific movie. Preference on specific genre

-   Find the average rating after every year a movie published. And find
    the trend of that.

-   Find the the average rating of each categories in different year.

### Visualizations:

-   Boxplot regarding: ratings and years; ratings and genres;

-   Clustering map of users and movies

-   Heatmaps denoting user / movie similarity

-   maybe a linear regression graph to show a specific user’s rating on
    genre

### Coding challenges:

-   Convert collected-in-seconds timestamp into years

-   Split and group movie by different genre

-   Select proper loss function and decompose the user-movie rating
    matrix through gradient descent

-   Scrape movie basic information (length, director, actor, date…) from
    IMDb for calculating movie-movie similarity

-   Calculate movie-movie similarity based on movie description and
    user-generated tags

-   Build models to calculate user-similarity

### Planned timeline

| Date        | Task                                             | Due                    |
|:------------|:-------------------------------------------------|:-----------------------|
| Nov 4       | Brainstorm                                       | NA                     |
| Nov 9       | Finish draft proposal                            | NA                     |
| Nov 13      | Submit formal proposal                           | November 13 by 1:00 pm |
| Nov 15      | Assign tasks                                     | NA                     |
| Nov 16 - 19 | Project review meeting                           | November 16-19         |
| Nov 30      | Finish coding part                               | NA                     |
| Dec 7       | Construct website                                | NA                     |
| Dec 11      | Report & Webpage and screencast & Peer asessment | December 11 by 4:00 pm |
| Dec 14      | Presentation practice                            | NA                     |
| Dec 16      | In class discussion                              | November 16            |
