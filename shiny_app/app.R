library(shiny)
library(tidyverse)

## Data Preparation

### movie information

movies_path = "../data/small/movies.csv"

movies = read_csv(movies_path) %>% 
  janitor::clean_names()

cut_year = function(string){
  year_str = str_split(string, pattern = "\\(")[[1]]
  year_str = str_remove(year_str[length(year_str)], "\\)")
  return(as.integer(year_str))
}

movies = 
  movies %>% 
  mutate(
    year = map(title, cut_year),
    year = as.integer(year)
  ) %>% 
  arrange(desc(year)) %>% 
  drop_na(year) %>% 
  filter(year >= 1990)


genres = 
  movies %>% 
  select(genres) %>% 
  mutate(genres = map(genres, ~str_split(string = .x, pattern = "\\|"))) %>% 
  unnest(genres) %>% 
  unnest(genres) %>% 
  distinct() %>% 
  filter(!genres %in% c("(no genres listed)", "IMAX")) %>% 
  pull(genres) %>% 
  as_vector()

### recommendation algorithm

movieIds = movies %>% pull(movie_id) %>% as_vector()

ratings_path = "../data/small/ratings.csv"

ratings_tidy = read_csv(ratings_path) %>% 
  janitor::clean_names() %>% 
  select(-timestamp) %>% 
  filter(movie_id %in% movieIds)


mv_id_title = movies %>% select(movie_id, title)


## Main body


### ui

ui = fluidPage(
  
  # Custom css               
  tags$head(
    tags$style(HTML(".selectize-input {
                        white-space: nowrap;
                    }
                    .selectize-dropdown {
                        width: 500px !important;
                    }"
    ))
  ),
  
  titlePanel("Movie Recommender"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Choose and rate at least three movies from the below panel"),
      tags$p("1. you can rate on the three movies we adaptly provided"),
      tags$p("2. you can provide ratings on any other movies you'd like to rate"),
      tags$p("3. click \"add (custom) rating\" to store your (custom) ratings"),
      tags$p("4. click \"get recommendation\" in the bottom of main panel to see movies we recommend (computation may take several minutes)"),
      tags$hr(),
      
      h4("Rate on movies we provided"),
      htmlOutput("selectFirst"),
      selectInput("firstRating", "select a rating (5 = best; 1 = worst; or choose \"Never watched it\")", append(c("Never watched it"), seq(1.0, 5.0, 0.5))),
      
      htmlOutput("selectSecond"),
      selectInput("secondRating", "select a rating (5 = best; 1 = worst; or choose \"Never watched it\")", append(c("Never watched it"), seq(1.0, 5.0, 0.5))),
      
      htmlOutput("selectThird"),
      selectInput("thirdRating", "select a rating (5 = best; 1 = worst; or choose \"Never watched it\")", append(c("Never watched it"), seq(1.0, 5.0, 0.5))),
      
      actionButton("addRating", "Add rating"),
      
      tags$hr(),
      
      h4("Rate on any other movies in addition"),
      sliderInput("yearFilter", "Filter movie year", 1990, 2018, c(1990, 2018), sep = ""),
      selectInput("genreFilter", "Filter movie by genre", genres),
      htmlOutput("selectCustomMovie"),
      selectInput("customRatingInput", "Select rating (5 = best; 1 = worst)", seq(1.0, 5.0, 0.5)),
      actionButton("addCustomRating", "Add custom rating")
    ),
    
    mainPanel(
      tags$em(textOutput("error"), style = "color: red"),
      h4("Custom movie recommendations"),
      dataTableOutput("recommendations"),
      tags$hr(),
      h4("User movie ratings"),
      dataTableOutput("customSelections"),
      tags$hr(),
      actionButton("getRecommendation", "Get recommendations (computation may cost minutes)")
    )
  )
  
  
)

### server

server = function(input, output) {
  
  #### rating on adaptively provided movies
  
  
  output$selectFirst = renderUI({
   selectizeInput("firstMovieInput", "Please rate on the first movie:", c("Last Samurai, The (2003)")) 
  })
  
  generate_second = reactive({
    if (input$firstRating == "Never watched it") {
      return("City of God (Cidade de Deus) (2002)	")
    } else if (input$firstRating >= 3.5) {
      return("Lord of the Rings: The Two Towers, The (2002)")
    }
    return("Finding Nemo (2003)")
  })
  
  # create dynamic input options based on filters selected
  output$selectSecond = renderUI({
    selectizeInput("secondMovieInput", "Please rate on the second movie:", generate_second())
  })
  
  generate_third = reactive({
    second_movie = generate_second()
    if(second_movie == "Lord of the Rings: The Two Towers, The (2002)"){
      
      if (input$secondRating == "Never watched it") {
        return("Lord of the Rings: The Return of the King, The (2003)")
      } else if (input$secondRating >= 3.5) {
        return("Lord of the Rings: The Return of the King, The (2003)")
      }
      return("Lord of the Rings: The Fellowship of the Ring, The (2001)")
      
    } else if (second_movie == "City of God (Cidade de Deus) (2002)") {
      
      if (input$secondRating == "Never watched it") {
        return("Prestige, The (2006)")
      } else if (input$secondRating >= 3.5) {
        return("Eternal Sunshine of the Spotless Mind (2004)")
      }
      return("Shrek (2001)")
      
    }
    
    if (input$secondRating == "Never watched it") {
      return("Lord of the Rings: The Fellowship of the Ring, The (2001)")
    } else if (input$secondRating >= 3.5) {
      return("Gladiator (2000)")
    }
    return("Lord of the Rings: The Fellowship of the Ring, The (2001)")
    
  })
  
  output$selectThird = renderUI({
    selectizeInput("thirdMovieInput", "Please rate on the third movie:", generate_third())
  })
  
  
  #### rating on custom chosen movies
  
  searchResults = reactive({
    movies %>% 
      filter(year %in% input$yearFilter) %>% 
      filter(str_detect(genres, input$genreFilter)) %>% 
      filter(!title %in% customDf$title) %>% 
      pull(title)
  })
  
  output$selectCustomMovie = renderUI({
    selectizeInput("customMovieInput", "Select movie name", searchResults()) 
  }
  )
  
  
  customDf = tibble()
  
  #### add rating in custom df
  observeEvent(input$addRating, {
    # add selected movie and rating to custom data frame
    
    tmpDf1 = tibble(title = "Last Samurai, The (2003)", rating = input$firstRating)
    tmpDf2 = tibble(title = input$secondMovieInput, rating = input$secondRating)
    tmpDf3 = tibble(title = input$thirdMovieInput, rating = input$thirdRating)
    
    tmpDf = bind_rows(tmpDf1, tmpDf2, tmpDf3)
    
    tmpDf = tmpDf %>% 
      filter(!rating == "Never watched it") %>% 
      filter(!title %in% customDf$title)
    
    # note the <<- which allows search to be made through parent environments
    customDf <<- bind_rows(tmpDf, customDf)
    output$customSelections = renderDataTable({ customDf },
                                              options = list(lengthMenu = c(10, 25, 50), 
                                                             pageLength = 10,
                                                             autoWidth = TRUE,
                                                             columnDefs = list(list(width = "15px", targets = c(1)))))
  }
  )
  
  #### add custom rating data in custom df
  observeEvent(input$addCustomRating, {
    # add selected movie and rating to custom data frame
    
    tmpDf = tibble(title = input$customMovieInput, rating = input$customRatingInput)
    tmpDf = tmpDf %>% 
      filter(!title %in% customDf$title)
    
    # note the <<- which allows search to be made through parent environments
    customDf <<- bind_rows(tmpDf, customDf)
    output$customSelections = renderDataTable({ customDf },
                                              options = list(lengthMenu = c(10, 25, 50), 
                                                             pageLength = 10,
                                                             autoWidth = TRUE,
                                                             columnDefs = list(list(width = "15px", targets = c(1)))))
    }
  )
  
  
  #### Get recommendation based on user similarity
  
  # action for seeRecommendation button
  observeEvent(input$getRecommendation, {
    # check of ratings are varied
    if (nrow(customDf) < 3) {
      
      output$error = renderText("Error: Please input at least 3 ratings.")
      
    } else {
      
      output$error = renderText("")
      
      user_data = customDf %>% 
        mutate(
          rating = as.numeric(rating),
          title = as.character(title)) %>% 
        left_join(mv_id_title, by = "title") %>% 
        mutate(user_id = 0) %>% 
        select(-title) %>% 
        nest(movie_id, rating)
      
      ratings = ratings_tidy %>% 
        nest(movie_id, rating)
      
      ratings = bind_rows(user_data, ratings)
      
      acquired_data = function(user){
        return(ratings %>% filter(user_id == user) %>% pull(data))
      }
      
      get_similar = function(user){
        
        user_data = acquired_data(user)
        calc_df = ratings %>% 
          filter(user_id != user) %>%
          rename(v_data = data) %>% 
          mutate(u_data = user_data) %>% 
          mutate(
            sim = map2_dbl(u_data, v_data, calc_sim)
          ) %>% 
          select(-u_data, -v_data) %>% 
          arrange(desc(sim)) %>% 
          head(10)
        
        return(calc_df)
      }
      
      
      
      calc_sim = function(u_data, v_data){
        
        calc_df = u_data %>% 
          inner_join(v_data, by = "movie_id", suffix = c("_u", "_v"))
        
        # two users should at least watched 3 same movie
        if (nrow(calc_df) < 3) {
          return(-1)
        }
        
        r_mean_u = u_data %>% pull(rating) %>% mean()
        r_mean_v = v_data %>% pull(rating) %>% mean()
        
        calc_df = calc_df %>% 
          mutate(
            r_u_ct = rating_u - r_mean_u,
            r_v_ct = rating_v - r_mean_v,
            r_uv_ct = r_u_ct * r_v_ct,
            r_u_ct_sq = r_u_ct^2,
            r_v_ct_sq = r_v_ct^2
          )
        
        sum_r_uv_ct = calc_df %>% pull(r_uv_ct) %>% sum()
        sum_r_u_ct_sq = calc_df %>% pull(r_u_ct_sq) %>% sum()
        sum_r_v_ct_sq = calc_df %>% pull(r_v_ct_sq) %>% sum()
        
        sim = sum_r_uv_ct / sqrt(sum_r_u_ct_sq * sum_r_v_ct_sq)
        
        return(sim)
      }
      
      predict_rating = function(user, movie, sim_users){
        
        r_means = ratings_tidy %>% 
          group_by(user_id) %>% 
          summarize(r_mean = mean(rating))
        
        calc_df = 
          ratings_tidy %>% 
          filter(movie_id == movie) %>% 
          inner_join(sim_users, by = "user_id") %>% 
          left_join(r_means, by = "user_id") %>% 
          mutate(
            sim_r_diff = sim * (rating - r_mean),
            abs_sim = abs(sim)
          )
        
        sum_sim_r_diff = calc_df %>% pull(sim_r_diff) %>% sum()
        sum_abs_sim = calc_df %>% pull(abs_sim) %>% sum()
        
        r_u_mean = acquired_data(user)[[1]] %>% pull(rating) %>% mean()
        
        rating = r_u_mean + sum_sim_r_diff/sum_abs_sim
        
        return(rating)
      }
      
      main = function(user){
        
        sim_users = get_similar(user)
        
        movies = sim_users %>% 
          select(user_id) %>% 
          left_join(ratings_tidy, by = "user_id") %>% 
          distinct(movie_id) %>% 
          pull(movie_id) 
        
        calc_df = tibble(
          user_id = user,
          movie_id = movies
        )
        
        watched = acquired_data(user)[[1]] %>% pull(movie_id) %>% as.vector()
        
        rec_movies = 
          calc_df %>% 
          filter(!movie_id %in% watched) %>% 
          mutate(
            r_pred = map2_dbl(user_id, movie_id, ~predict_rating(user = .x, movie = .y, sim_users = sim_users))
          ) %>% 
          arrange(desc(r_pred)) %>% 
          select(movie_id, pred_rating = r_pred)
        
        return(rec_movies)
      }
      
      rec_movies = main(0)
      
      rec_movies = 
        rec_movies %>% 
        inner_join(mv_id_title, by = "movie_id") %>% 
        select(-movie_id) %>% 
        head(10)
      
      if (nrow(rec_movies) == 0) {
        
        output$error = renderText("Error: No recommendations found. Please make additional selections and rerun.")
        
      } else {
        output$recommendations = renderDataTable({ rec_movies },
                                               options = list(lengthMenu = c(10, 25, 50), 
                                                              pageLength = 10,
                                                              autoWidth = TRUE,
                                                              columnDefs = list(list(width = "15px", targets = c(0)))))
      }
    }
  }
  )   
      
}


shinyApp(ui = ui, server = server)
