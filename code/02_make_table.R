here::i_am("code/02_make_table.R")

data <- readRDS(here::here("output/clean_data.rds"))

library("gtsummary")
table <- data |>
  tbl_summary(
    include = mda_status_final,
    by = year,
    label = list(mda_status_final ~ "Endemicity"),
    statistic = all_categorical() ~ "{n}"
  ) |>
  modify_header(all_stat_cols() ~ "**{level}**") |>
  modify_caption("**LF Endemic IUs in South Sudan by Year**") |>
  modify_footnote(everything() ~ NA)

saveRDS(
  table,
  file = here::here("output/table.rds"))