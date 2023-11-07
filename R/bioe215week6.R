bioe215week6

## browser()

# Error in summarize()

library(palmerpenguins)
library(tidyverse)

traits_r2 <- function(trait1, trait2) {
  browser()
  summary(lm(trait1 ~ trait2))$rsquared #r.squared
}

penguins %>% 
  summarize(flipper_bill_r2 = traits_r2(flipper_length_mm, bill_length_mm))



# Q1: How would you describe the error? I’m not asking you describe the cause of the error yet. Describe how the output is different than what you would expect.

expecting tibble with data, but tibble: 1 × 0


# Q2: Where would you add browser() to explore the cause of the error?
  
not in the middle of function


# Q3: Does the body of traits_r2 use list or atomic vector indexing? Does it use indexing by position, logic, or name?


  
# Q4: What’s the cause of the error? How would you fix it?



_______________________________________________________

# adding group_by()

The following pipeline is similar to the one above, with an added layer of complexity. Use it to answer the following questions.


traits_r2 <- function(trait1, trait2) {
  summary(lm(trait1 ~ trait2))$r.squared
}



# Pipeline 1
penguins %>% 
  group_by(species) %>% 
  summarize(flipper_bill_r2 = traits_r2(flipper_length_mm, bill_length_mm))

# Pipeline 2
penguins %>% 
  group_by(species, island) %>% 
  summarize(flipper_bill_r2 = traits_r2(flipper_length_mm, bill_length_mm),
            .groups = "drop")



# Q5: How many times does Pipeline 1 call traits_r2()? How about Pipeline 2?
  
once per group

pipeline1... 3 times
pipeline2... 5 times


# Q6: Create Pipeline 3 that additionally groups by sex. How many times does Pipeline 3 call traits_r2()?

penguins %>% 
  group_by(species, island, sex) %>% 
  summarize(flipper_bill_r2 = traits_r2(flipper_length_mm, bill_length_mm),
            .groups = "drop")


_______________________________________________________________

# Error in group_by()-summarize()

The following code creates an error in Pipeline 3. Change your Pipeline 3 to use penguins2 instead of penguins, then answer the following questions.


traits_r2 <- function(trait1, trait2) {
  browser()
  summary(lm(trait1 ~ trait2))$r.squared
}


set.seed(12345)
penguins2 <- penguins %>% 
  drop_na(sex) %>%
  sample_n(25)
penguins2[7, 3:6] <- NA

penguins2 %>% 
  group_by(species, island, sex) %>% 
  summarize(flipper_bill_r2 = traits_r2(flipper_length_mm, bill_length_mm),
            .groups = "drop")


# Q7: How would you describe the error?
  
?lm.fit()


# Q8: Use browser() to diagnose the error. Hint: c will tell the debugger to continue until the next time it’s called.




# Q9: How would you fix the error?


______________________________________________________________

# ggplot

library(palmerpenguins)
library(tidyverse)

ggplot(data = penguins, aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point()


# Q10: Change the aesthetics of the plot to show bill_depth_mm on the y-axis.

ggplot(data = penguins, aes(x = body_mass_g, y = bill_depth_mm)) +
  geom_point()

# Q11: Add an aesthetic for color, so points will be color-coded by species.

ggplot(data = penguins, aes(x = body_mass_g, y = bill_depth_mm, color = species)) +
  geom_point()

______________________________________________________________________

# Customizing scales

In addition to adding geometries with geom_*(), we can add scales with scale_*_*() to customize how scales appear in the figure. The first * is the name of the aesthetic, and the second * is the type of scale.


ggplot(data = penguins) +
  # You can also define aesthetics directly inside the geometries
  geom_point(aes(x = body_mass_g, 
                 y = flipper_length_mm,
                 color = species)) +
  # x aesthetic, continuous scale
  scale_x_continuous(
    # change the axis name
    name = "Body mass (g)",
    # change the limits
    limits = c(2000, 8000)
  ) +
  # color aesthetic, manual scale
  scale_color_manual(
    # set the values for the colors
    values = c(Adelie = "cornflowerblue",
               Chinstrap = "firebrick",
               Gentoo = "darkorchid")
  )


# Q12: What function would you use to customize the y-axis? Use that function to expand the y-axis limits to include 150 and 250.

ggplot(data = penguins) +
  # You can also define aesthetics directly inside the geometries
  geom_point(aes(x = body_mass_g, 
                 y = flipper_length_mm,
                 color = species)) +
  # x aesthetic, continuous scale
  scale_x_continuous(
    # change the axis name
    name = "Body mass (g)",
    # change the limits
    limits = c(2000, 8000)
  ) +
  # y aesthetic
  scale_y_continuous(
    # change the axis name
    name = "Flipper length (mm)",
    # change the limits
    limits = c(150, 250)
  ) +
  # color aesthetic, manual scale
  scale_color_manual(
    # set the values for the colors
    values = c(Adelie = "cornflowerblue",
               Chinstrap = "firebrick",
               Gentoo = "darkorchid")
  )



# Q13: Look up the help for scale_color_brewer(). Change the color scale to use the “Dark2” color palette.

?scale_color_brewer()

ggplot(data = penguins) +
  # You can also define aesthetics directly inside the geometries
  geom_point(aes(x = body_mass_g, 
                 y = flipper_length_mm,
                 color = species)) +
  # x aesthetic, continuous scale
  scale_x_continuous(
    # change the axis name
    name = "Body mass (g)",
    # change the limits
    limits = c(2000, 8000)
  ) +
  # y aesthetic
  scale_y_continuous(
    # change the axis name
    name = "Flipper length (mm)",
    # change the limits
    limits = c(150, 250)
  ) +
  # color aesthetic, manual scale
  scale_color_brewer(palette = "Dark2")
  )
























