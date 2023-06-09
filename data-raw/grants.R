library(tidyverse)
library(janitor)
library(cld2)

# https://data.snf.ch/datasets
grants_raw <- read_csv2("https://data.snf.ch/exportcsv/GrantWithAbstracts.csv")

grants <- grants_raw |>
  clean_names() |>
  filter(call_decision_year %in% c(2012, 2022)) |>
  filter(detect_language(abstract) == "en") |>
  select(abstract, amount = amount_granted_all_sets, decision_year = call_decision_year, grant_number) |>
  drop_na()

write_csv(grants, "data/grants.csv.gz")
