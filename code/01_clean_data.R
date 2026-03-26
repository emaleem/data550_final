here::i_am("code/01_clean_data.R")

data <- read.csv(here::here("raw_data/RSS_LF_Data.csv"))
library(dplyr)
library(tidyr)

clean_data <- data |>
  arrange(iuCode, year) |>
  group_by(iuCode) |>
  mutate(endemicity_filled = ifelse(endemicity == "Not reported", 
                                    NA, endemicity)) |>
  fill(endemicity_filled, .direction = "down") |>
  mutate(
    mda_status_final = case_when(
      endemicity_filled == "Non-endemic" ~ "Non-endemic",
      endemicity_filled == "Endemic (under MDA)" ~ "MDA Started",
      TRUE ~ "MDA Not Started")
  ) |>
  mutate(mda_started_flag = ifelse(mda_status_final == "MDA Started", 1, 0)) |>
  mutate(ever_started = cummax(mda_started_flag)) |>
  mutate(mda_status_final = case_when(
    endemicity_filled == "Non-endemic" ~ "Non-endemic",
    ever_started == 1 ~ "MDA Started",
    TRUE ~ "MDA Not Started"
  )) |>
  ungroup()

saveRDS(
  clean_data,
  file = here::here("output", "clean_data.rds")
)