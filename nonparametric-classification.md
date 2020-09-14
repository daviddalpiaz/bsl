# Nonparametric Classification

Coming soon! By end of day on Monday! Check the videos for now!


<!-- ```{r setup, include = FALSE} -->
<!-- knitr::opts_chunk$set(echo = TRUE, fig.align = "center", cache = TRUE, autodep = TRUE) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- library(tibble)     # data frame printing -->
<!-- library(dplyr)      # data manipulation -->

<!-- library(knitr)      # creating tables -->
<!-- library(kableExtra) # styling tables -->


<!-- library(rpart) -->
<!-- library(caret) -->

<!-- library(palmerpenguins) -->

<!-- library(ggplot2) -->

<!-- ``` -->




<!-- ```{r} -->
<!-- penguins = na.omit(palmerpenguins::penguins) -->
<!-- ``` -->


<!-- ```{r} -->
<!-- penguins -->
<!-- ``` -->

<!-- ```{r} -->
<!-- mass_flipper <- ggplot(data = penguins, -->
<!--                        aes(x = flipper_length_mm, -->
<!--                            y = body_mass_g)) + -->
<!--   geom_point(aes(color = species, -->
<!--                  shape = species), -->
<!--              size = 3, -->
<!--              alpha = 0.8) + -->
<!--   theme_minimal() + -->
<!--   scale_color_manual(values = c("darkorange","purple","cyan4")) + -->
<!--   labs(title = "Penguin size, Palmer Station LTER", -->
<!--        subtitle = "Flipper length and body mass for Adelie, Chinstrap and Gentoo Penguins", -->
<!--        x = "Flipper length (mm)", -->
<!--        y = "Body mass (g)", -->
<!--        color = "Penguin species", -->
<!--        shape = "Penguin species") + -->
<!--   theme(legend.position = c(0.2, 0.7), -->
<!--         legend.background = element_rect(fill = "white", color = NA), -->
<!--         plot.title.position = "plot", -->
<!--         plot.caption = element_text(hjust = 0, face= "italic"), -->
<!--         plot.caption.position = "plot") -->

<!-- mass_flipper -->

<!-- ``` -->

<!-- https://allisonhorst.github.io/palmerpenguins/articles/examples.html -->



<!-- ```{r} -->
<!-- predict(rpart(species ~ flipper_length_mm + body_mass_g, data = penguins), penguins, type = "prob") -->
<!-- ``` -->

<!-- ```{r} -->
<!-- GGally::ggpairs(penguins, mapping = aes(color = species),  -->
<!--         columns = names(penguins)[-1]) -->

<!-- ``` -->


