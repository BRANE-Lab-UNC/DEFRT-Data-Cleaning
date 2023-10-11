Data Collapsing
================
2023-10-11

``` r
#replace with your filename
filename <- "defrtdata_original_RH"
sav <- read_sav(paste0("./data/", filename, ".sav"))
#getwd() # this is the folder it will save into unless you specify otherwise in the path below
write_csv(x = sav, file = paste0("./data/", filename, ".csv"))
data <- read_csv(paste0("./data/", filename, ".csv"), show_col_types = F)

merged_data <- data %>%
  group_by(record_id) %>%
  summarize_all(list(~ first(.[!is.na(.)])))
#merged sav file
write_sav(data = merged_data, path = paste0("./data/", filename, "_merged.sav"))
write_csv(x = merged_data, file = paste0("./data/", filename, "_merged.csv"))
```
