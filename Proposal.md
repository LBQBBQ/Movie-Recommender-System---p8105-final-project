Team registration and proposal
================
Shaocong Zhang
11/9/2021

# The group members

Haolin Zhong (hz2771), Shaocong Zhang (sz3030), Yuxuan Wang (yw3608),
Boqian Li (bl2898)

# The tentative project title

Recommend movies for users

# The motivation for this project

We proposed to explore a dataset of users’ rating and tagging towards
movies and implement a demo movie recommendation system.

# The intended final products

## Models

-   Item-similarity based recommendation

-   User-similarity based recommendation

-   Collaborative filtering (Latent factor model (SVD)) based
    recommendation

## A shiny app

-   Recommends user movie after the user types his favorite 3 movies

# The anticipated data sources

Dataset from MoiveLens, the link is:
<https://grouplens.org/datasets/movielens/latest/>

# The planned analyses/ visualizations / coding challenges

## Planned analyses:

-   Which movies have the highest ratings? Are there any significant
    differences in the scores of different categories of films? Is there
    any relationship between the film score and the year of film
    release? Is there any relationship between film rating and comment
    time?

-   Test the average ratings of the users, to investigate whether the
    rating criteria are different.(ANOVA)

-   Average ratings over years – to investigate whether ratings are
    different because of the year the movie displayed.

-   Construct a linear model to predict the underlying rating of a
    specific user. Preference on specific genre. Whether there is a
    difference between genre and ratings.

## Visualizations:

-   Boxplot regarding the rating and years; boxplot regarding the genre
    and ratings; maybe a linear regression graph to show a specific
    user’s rating on genre

## Coding challenges:

-   To acheive collaborative filtering (Latent factor model (SVD)) based
    recommendation, we may construct a M\*N matrix to calculate the
    item-similarity and the user-similarity. We may also pick up the
    most frequent tags from the movie and used the tag to recommend the
    similar movies.

-   SVD

## The planned timeline

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.4     v dplyr   1.0.7
    ## v tidyr   1.1.3     v stringr 1.4.0
    ## v readr   2.0.1     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

| date        | task                                             |
|:------------|:-------------------------------------------------|
| Nov 4       | Brainstorm                                       |
| Nov 9       | Finish draft proposal                            |
| Nov 13      | Submit formal proposal                           |
| Nov 15      | Assign tasks                                     |
| Nov 16 - 19 | Project review meeting                           |
| Nov 30      | Finish coding part                               |
| Dec 7       | Construct website                                |
| Dec 11      | Report & Webpage and screencast & Peer asessment |
| Dec 14      | Presentation practice                            |
| Dec 16      | “In class” discussion                            |
