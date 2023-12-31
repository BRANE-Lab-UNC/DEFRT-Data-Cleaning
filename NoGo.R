#' ---
#' title: "NoGo"
#' date: "`r Sys.Date()`"
#' output: github_document
#' ---
#' 
## ----results='hide'-----------------------------------------------------------------------------------
#Installs packages if not previously installed
if(!require(readr)) { install.packages("readr", repos = "http://cran.us.r-project.org"); library(readr) }
if(!require(dplyr)) { install.packages("dplyr", repos = "http://cran.us.r-project.org"); library(dplyr) }
if(!require(tidyr)) { install.packages("tidyr", repos = "http://cran.us.r-project.org"); library(tidyr) }
if(!require(knitr)) { install.packages("knitr", repos = "http://cran.us.r-project.org"); library(knitr) }
if (!require(here)) {install.packages("here", repos = "http://cran.us.r-project.org"); library(here) }
setwd(here())

#' 
## ----results='hide'-----------------------------------------------------------------------------------
original_colnames <- c(
  "subj",
  "Session1_smoking_correct_responses",
  "Session1_smoking_correct_commissions",
  "Session1_smoking_errors_of_omission",
  "Session1_smoking_mean_response_time",
  "Session1_smoking_errors_of_commission",
  "Session1_neutral_correct_responses",
  "Session1_neutral_correct_commissions",
  "Session1_neutral_errors_of_omission",
  "Session1_neutral_mean_response_time",
  "Session1_neutral_errors_of_commission",
  "Session1_trials",
  "Session1_goTrials",
  "Session1_nogoTrials"
  )

# Create a data frame with the original column names and one row of NA values
summaryTotal <- data.frame(matrix(NA, nrow = 1, ncol = length(original_colnames)))
colnames(summaryTotal) <- original_colnames

# Define the sessions
sessions <- c("Session2", "Session3", "Session4")

# Iterate through sessions and append columns with the desired names
for (session in sessions) {
  new_colnames <- gsub("Session1", session, original_colnames)
  new_cols <- data.frame(matrix(NA, nrow = 1, ncol = length(original_colnames)-1))
  colnames(new_cols) <- new_colnames[2:length(original_colnames)]
  summaryTotal <- cbind(summaryTotal, new_cols)
}
data_list <- c("4_1_Blocks_1and2_may25_2023_Y2023_M06_D02_H11_M41_S10", "4_2_Blocks_1and2_may25_2023_Y2023_M06_D02_H11_M46_S02", "4_3_Blocks_3and4_may25_2023_Y2023_M06_D02_H11_M51_S03", "4_4_Blocks_3and4_may25_2023_Y2023_M06_D02_H11_M55_S43", "007_1_Blocks_3and4_may25_2023_Y2023_M06_D07_H11_M16_S41", "007_2_Blocks_3and4_may25_2023_Y2023_M06_D07_H11_M21_S27", "007_3_Blocks_1and2_may25_2023_Y2023_M06_D07_H11_M26_S12", "007_4_Blocks_1and2_may25_2023_Y2023_M06_D07_H11_M31_S38", "008_1_Blocks_1and2_may25_2023_Y2023_M06_D08_H11_M10_S11", "008_2_Blocks_1and2_may25_2023_Y2023_M06_D08_H11_M15_S10", "008_3_Blocks_3and4_may25_2023_Y2023_M06_D08_H11_M20_S06", "008_4_Blocks_3and4_may25_2023_Y2023_M06_D08_H11_M24_S55", "008_4_Blocks_3and4_may25_2023_Y2023_M06_D08_H11_M24_S55", "009_1_Blocks_3and4_may25_2023_Y2023_M06_D20_H11_M09_S09", "009_2_Blocks_3and4_may25_2023_Y2023_M06_D20_H11_M14_S05", "009_3_Blocks_1and2_may25_2023_Y2023_M06_D20_H11_M18_S45", "009_4_Blocks_1and2_may25_2023_Y2023_M06_D20_H11_M23_S22", "012_1_Blocks_1and2_may25_2023_Y2023_M07_D05_H12_M02_S51", "012_2_Blocks_1and2_may25_2023_Y2023_M07_D05_H12_M07_S31", "012_3_Blocks_3and4_may25_2023_Y2023_M07_D05_H12_M12_S21", "012_4_Blocks_3and4_may25_2023_Y2023_M07_D05_H12_M16_S55", "15_1_Blocks_3and4_may25_2023_Y2023_M07_D03_H11_M54_S12", "15_2_Blocks_3and4_may25_2023_Y2023_M07_D03_H11_M59_S11", "15_3_Blocks_1and2_may25_2023_Y2023_M07_D03_H12_M04_S09", "15_4_Blocks_1and2_may25_2023_Y2023_M07_D03_H12_M09_S05", "017_1_Blocks_1and2_may25_2023_Y2023_M08_D25_H17_M29_S40", "017_2_Blocks_1and2_may25_2023_Y2023_M08_D25_H17_M34_S29", "017_3_Blocks_3and4_may25_2023_Y2023_M08_D25_H17_M39_S29", "017_4_Blocks_3and4_may25_2023_Y2023_M08_D25_H17_M44_S31", "20_1_Blocks_3and4_may25_2023_Y2023_M08_D21_H15_M52_S04", "20_2_Blocks_3and4_may25_2023_Y2023_M08_D21_H15_M56_S42", "20_3_Blocks_1and2_may25_2023_Y2023_M08_D21_H15_M58_S20", "20_4_Blocks_1and2_may25_2023_Y2023_M08_D21_H16_M01_S12", "022_1_Blocks_1and2_may25_2023_Y2023_M06_D28_H11_M56_S01", "022_2_Blocks_1and2_may25_2023_Y2023_M06_D28_H12_M10_S22", "022_3_Blocks_3and4_may25_2023_Y2023_M06_D28_H12_M15_S38", "022_4_Blocks_3and4_may25_2023_Y2023_M06_D28_H12_M20_S32", "024_1_Blocks_1and2_may25_2023_Y2023_M07_D11_H11_M12_S23", "024_2_Blocks_1and2_may25_2023_Y2023_M07_D11_H11_M17_S00", "024_3_Blocks_3and4_may25_2023_Y2023_M07_D11_H11_M22_S25", "024_4_Blocks_3and4_may25_2023_Y2023_M07_D11_H11_M27_S37", "025_1_Blocks_3and4_may25_2023_Y2023_M07_D12_H11_M58_S57", "025_2_Blocks_3and4_may25_2023_Y2023_M07_D12_H12_M03_S37", "025_3_Blocks_1and2_may25_2023_Y2023_M07_D12_H12_M08_S17", "025_4_Blocks_1and2_may25_2023_Y2023_M07_D12_H12_M12_S57", "26_1_Blocks_3and4_may25_2023_Y2023_M07_D10_H11_M42_S17", "26_2_Blocks_3and4_may25_2023_Y2023_M07_D10_H11_M47_S02", "26_3_Blocks_1and2_may25_2023_Y2023_M07_D10_H11_M53_S32", "26_4_Blocks_1and2_may25_2023_Y2023_M07_D10_H11_M58_S12", "028_1_Blocks_1and2_may25_2023_Y2023_M07_D14_H13_M45_S11", "028_2_Blocks_1and2_may25_2023_Y2023_M07_D14_H13_M49_S58", "028_3_Blocks_3and4_may25_2023_Y2023_M07_D14_H13_M54_S44", "028_4_Blocks_3and4_may25_2023_Y2023_M07_D14_H13_M59_S16", "30_3_Blocks_1and2_may25_2023_Y2023_M07_D19_H11_M24_S12", "30_4_Blocks_3and4_may25_2023_Y2023_M07_D19_H11_M28_S56", "30_Block 1_Blocks_3and4_may25_2023_Y2023_M07_D19_H11_M14_S28", "30_Block 2_Blocks_1and2_may25_2023_Y2023_M07_D19_H11_M18_S52", "031_1_Blocks_3and4_may25_2023_Y2023_M07_D25_H11_M08_S54", "031_2_Blocks_3and4_may25_2023_Y2023_M07_D25_H11_M13_S36", "031_3_Blocks_1and2_may25_2023_Y2023_M07_D25_H11_M18_S27", "031_4_Blocks_1and2_may25_2023_Y2023_M07_D25_H11_M23_S15", "34_block 2_Blocks_3and4_may25_2023_Y2023_M07_D28_H12_M24_S03", "34_block1_Blocks_3and4_may25_2023_Y2023_M07_D28_H12_M18_S45", "34_block3_Blocks_1and2_may25_2023_Y2023_M07_D28_H12_M28_S40", "34_block4_Blocks_1and2_may25_2023_Y2023_M07_D28_H12_M33_S51", "036_1_Blocks_1and2_may25_2023_Y2023_M07_D27_H10_M15_S14", "036_2_Blocks_1and2_may25_2023_Y2023_M07_D27_H10_M19_S55", "036_3_Blocks_3and4_may25_2023_Y2023_M07_D27_H10_M24_S57", "036_4.5_Blocks_3and4_may25_2023_Y2023_M07_D27_H10_M31_S27")
for (i in data_list) {
  #Replace with your filename
  filename <- i
  #Place the data into a folder titled data within the same wd
  data <- read_csv(paste0("./data/", filename, ".csv"), show_col_types = F)
  countedData <- data %>%
    group_by(imType, trialType, accuracy) %>%
    summarize(count = n(), .groups = 'drop')
  
  #Number of correct responses for neutral and smoking
  correct_responses <- countedData %>%
    group_by(imType) %>%
    summarize(correct_responses = sum(ifelse(accuracy == 1, count, 0)))
  
  #Number of correct commissions for neutral and smoking
  correct_commissions <- countedData %>%
    group_by(imType) %>%
    summarize(correct_commissions = sum(ifelse(accuracy == 1 & trialType == "go", count, 0)))
  
  #Number of errors of omission for neutral and smoking
  errors_of_omission <- countedData %>%
    group_by(imType) %>%
    summarize(errors_of_omission = sum(ifelse(accuracy == 0 & trialType == "go", count, 0)))
  
  #Mean response time
  mean_response_time <- data %>%
    group_by(imType) %>%
    summarize(mean_response_time = mean(respTime))
  
  #Number of errors of commission for neutral and smoking
  errors_of_commission <- countedData %>%
    group_by(imType) %>%
    summarize(errors_of_commission = sum(ifelse(accuracy == 0 & trialType == "nogo", count, 0)))
  
  #Total number of trials in the session
  trials <- sum(countedData$count)
  
  #Total number of go trials in the session
  goTrials <- countedData %>%
    summarize(goTrials = sum(ifelse(trialType == "go", count, 0)))
  
  #Total number of nogo trials in the session
  nogoTrials <- countedData %>%
    summarize(nogoTrials = sum(ifelse(trialType == "nogo", count, 0)))
    
  
  #Creates data frame for subj, session, imType, correct_reponses, correct_comissions, errors_of_omission, mean_response_time, errors_of_commission, trials, goTrials, nogoTrials
  summarydata <- mutate(data[1:2,1], data[1:2,2], correct_responses, correct_commissions, errors_of_omission, mean_response_time, errors_of_commission, trials, goTrials, nogoTrials)
  
  #Takes everything before trials and binds it to everything after session for the other imType
  summarydata1 <- cbind(summarydata[1, 1:(ncol(summarydata) - 3)], summarydata[2, 3:ncol(summarydata)])
  
  #Renames columns based on their session and imType
  colnames(summarydata1)[4:8] <- paste0("Session", summarydata1[1,2], "_", summarydata1[1, 3], "_", colnames(summarydata1)[4:8])
  colnames(summarydata1)[10:(ncol(summarydata1) - 3)] <- paste0("Session", summarydata1[1,2], "_", summarydata1[1, 9], "_", colnames(summarydata1)[10:(ncol(summarydata1) - 3)])
  
  #Renames Trials column based solely on session
  colnames(summarydata1)[15:ncol(summarydata1)] <- paste0("Session", summarydata[1,2], "_", colnames(summarydata1)[15:ncol(summarydata1)])
  
  summarydatasession <- summarydata1[c(1, 4:8, 10:ncol(summarydata1))]
  assign(paste0("summarydata", data[1, 1], ".", data[1, 2]), summarydata)
  if (nrow(summarydata) > 0) {
    # Match the columns in summaryTotal and summarydatasession
    matching_cols <- intersect(names(summaryTotal), names(summarydatasession))

    # Ensure at least one matching column exists
    if (length(matching_cols) < 1) {
      stop("No matching columns found to append.")
    }

    # Add missing columns in summarydatasession with NA values
    missing_cols <- setdiff(names(summaryTotal), names(summarydatasession))
    summarydatasession[missing_cols] <- NA

    # Reorder columns to match summaryTotal
    summarydatasession <- summarydatasession[names(summaryTotal)]

    # Append to summaryTotal
    summaryTotal <- rbind(summaryTotal, summarydatasession)
  }
}
summaryTotal <- summaryTotal[-1,]

#' 
## ----results='hide'-----------------------------------------------------------------------------------
data_list <- c("037_2_Blocks_1and2_may25_2023_Y2023_M08_D01_H12_M41_S21", "037_3_Blocks_3and4_may25_2023_Y2023_M08_D01_H12_M46_S30", "037_4_Blocks_3and4_may25_2023_Y2023_M08_D01_H12_M47_S33", "37_block 1_Blocks_1and2_may25_2023_Y2023_M08_D01_H12_M37_S05", "38_2_Blocks_1and2_may25_2023_Y2023_M07_D21_H12_M40_S20", "043_1_Blocks_3and4_may25_2023_Y2023_M08_D04_H11_M39_S19", "043_2_Blocks_3and4_may25_2023_Y2023_M08_D04_H11_M44_S21", "043_3_Blocks_1and2_may25_2023_Y2023_M08_D04_H11_M49_S27", "043_4_Blocks_1and2_may25_2023_Y2023_M08_D04_H11_M54_S12", "44_1_Blocks_1and2_may25_2023_Y2023_M08_D15_H12_M02_S33", "44_2_Blocks_1and2_may25_2023_Y2023_M08_D15_H12_M05_S54", "44_3_Blocks_3and4_may25_2023_Y2023_M08_D15_H12_M11_S08", "44_4_Blocks_3and4_may25_2023_Y2023_M08_D15_H12_M14_S52", "049_1_Blocks_1and2_may25_2023_Y2023_M09_D22_H14_M21_S37", "049_2_Blocks_1and2_may25_2023_Y2023_M09_D22_H14_M26_S16", "049_3_Blocks_3and4_may25_2023_Y2023_M09_D22_H14_M31_S07", "049_4_Blocks_3and4_may25_2023_Y2023_M09_D22_H14_M35_S39", "50_1_Blocks_3and4_may25_2023_Y2023_M09_D29_H16_M03_S17", "50_2_Blocks_3and4_may25_2023_Y2023_M09_D29_H16_M06_S09", "50_3_Blocks_1and2_may25_2023_Y2023_M09_D29_H16_M10_S53", "50_4_Blocks_1and2_may25_2023_Y2023_M09_D29_H16_M14_S32", "51_1_Blocks_1and2_may25_2023_Y2023_M10_D02_H16_M50_S31", "51_2_Blocks_1and2_may25_2023_Y2023_M10_D02_H16_M55_S20", "51_3_Blocks_3and4_may25_2023_Y2023_M10_D02_H16_M59_S59", "51_4_Blocks_3and4_may25_2023_Y2023_M10_D02_H17_M05_S06", "054_1_Blocks_3and4_may25_2023_Y2023_M10_D06_H14_M43_S35", "054_2_Blocks_3and4_may25_2023_Y2023_M10_D06_H14_M48_S23", "054_3_Blocks_1and2_may25_2023_Y2023_M10_D06_H14_M53_S44", "054_4_Blocks_1and2_may25_2023_Y2023_M10_D06_H14_M58_S33")
for (i in data_list) {
  #Replace with your filename
  filename <- i
  #Place the data into a folder titled data within the same wd
  data <- read_csv(paste0("./data/", filename, ".csv"), show_col_types = F)
  countedData <- data %>%
    group_by(imType, trialType, accuracy) %>%
    summarize(count = n(), .groups = 'drop')
  
  #Number of correct responses for neutral and smoking
  correct_responses <- countedData %>%
    group_by(imType) %>%
    summarize(correct_responses = sum(ifelse(accuracy == 1, count, 0)))
  
  #Number of correct commissions for neutral and smoking
  correct_commissions <- countedData %>%
    group_by(imType) %>%
    summarize(correct_commissions = sum(ifelse(accuracy == 1 & trialType == "go", count, 0)))
  
  #Number of errors of omission for neutral and smoking
  errors_of_omission <- countedData %>%
    group_by(imType) %>%
    summarize(errors_of_omission = sum(ifelse(accuracy == 0 & trialType == "go", count, 0)))
  
  #Mean response time
  mean_response_time <- data %>%
    group_by(imType) %>%
    summarize(mean_response_time = mean(respTime))
  
  #Number of errors of commission for neutral and smoking
  errors_of_commission <- countedData %>%
    group_by(imType) %>%
    summarize(errors_of_commission = sum(ifelse(accuracy == 0 & trialType == "nogo", count, 0)))
  
  #Total number of trials in the session
  trials <- sum(countedData$count)
  
  #Total number of go trials in the session
  goTrials <- countedData %>%
    summarize(goTrials = sum(ifelse(trialType == "go", count, 0)))
  
  #Total number of nogo trials in the session
  nogoTrials <- countedData %>%
    summarize(nogoTrials = sum(ifelse(trialType == "nogo", count, 0)))
    
  
  #Creates data frame for subj, session, imType, correct_reponses, correct_comissions, errors_of_omission, mean_response_time, errors_of_commission, trials, goTrials, nogoTrials
  summarydata <- mutate(data[1:2,1], data[1:2,2], correct_responses, correct_commissions, errors_of_omission, mean_response_time, errors_of_commission, trials, goTrials, nogoTrials)
  
  #Takes everything before trials and binds it to everything after session for the other imType
  summarydata1 <- cbind(summarydata[1, 1:(ncol(summarydata) - 3)], summarydata[2, 3:ncol(summarydata)])
  
  #Renames columns based on their session and imType
  colnames(summarydata1)[4:8] <- paste0("Session", summarydata1[1,2], "_", summarydata1[1, 3], "_", colnames(summarydata1)[4:8])
  colnames(summarydata1)[10:(ncol(summarydata1) - 3)] <- paste0("Session", summarydata1[1,2], "_", summarydata1[1, 9], "_", colnames(summarydata1)[10:(ncol(summarydata1) - 3)])
  
  #Renames Trials column based solely on session
  colnames(summarydata1)[15:ncol(summarydata1)] <- paste0("Session", summarydata[1,2], "_", colnames(summarydata1)[15:ncol(summarydata1)])
  
  summarydatasession <- summarydata1[c(1, 4:8, 10:ncol(summarydata1))]
  assign(paste0("summarydata", data[1, 1], ".", data[1, 2]), summarydata)
  if (nrow(summarydata) > 0) {
    # Match the columns in summaryTotal and summarydatasession
    matching_cols <- intersect(names(summaryTotal), names(summarydatasession))

    # Ensure at least one matching column exists
    if (length(matching_cols) < 1) {
      stop("No matching columns found to append.")
    }

    # Add missing columns in summarydatasession with NA values
    missing_cols <- setdiff(names(summaryTotal), names(summarydatasession))
    summarydatasession[missing_cols] <- NA

    # Reorder columns to match summaryTotal
    summarydatasession <- summarydatasession[names(summaryTotal)]

    # Append to summaryTotal
    summaryTotal <- rbind(summaryTotal, summarydatasession)
  }
}
merged_summary <- summaryTotal %>%
  group_by(subj) %>%
  mutate(subj = gsub("^0+", "", subj)) %>%  # Remove leading zeros from subj
  summarize_all(list(~ first(.[!is.na(.)]))) %>%
  arrange(as.numeric(subj))
merged_summary

#' 
## ----results='hide', eval = F-------------------------------------------------------------------------
## write_csv(merged_summary, file = paste0("./data/summaryTotal.csv"))

