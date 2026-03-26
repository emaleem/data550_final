here::i_am("code/03_make_graph.R")

clean_data <- readRDS(here::here("output/clean_data.rds"))

library(ggplot2)
library(dplyr)

graph <- clean_data |>
  filter(mda_status_final != "Non-endemic") |>
  group_by(year, mda_status_final) |>
  summarize(n_ius = n_distinct(iuCode), .groups = "drop") |>
  ggplot(aes(x = n_ius, y = factor(year), fill = mda_status_final)) +
  geom_col() +
  scale_fill_manual(values = c("MDA Started" = "orange",
                               "MDA Not Started" = "red")) +
  labs(title = "South Sudan Progress in LF Elimination by IU",
       x = "Number of LF Endemic IUs",
       y = "Year",
       fill = "Endemicity Status") +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

saveRDS(
  graph,
  file = here::here("output/graph.rds"))