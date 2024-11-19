# Load necessary libraries
library(dplyr)
library(readr)

# ----- USER INPUT REQUIRED -----
# Define the folder containing the CSV files 
folder_path <- "~/Library/CloudStorage/OneDrive-UniversityofBergen/Thomas/ALL CSV THOMAS2"

# ----- USER INPUT REQUIRED -----
# Define the output folder for the summary files USER INPUT REQUIRED 
output_folder_path <- "~/Library/CloudStorage/OneDrive-UniversityofBergen/Thomas/Thomas 2"

# Create the output folder if it does not exist
if (!dir.exists(output_folder_path)) {
  dir.create(output_folder_path)
}

# List all CSV files in the folder
file_list <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

# Initialize an empty data frame for each sample type
summary_data_C2 <- data.frame(Sample = character(), Total_Cells = integer(), Cells_Above_Threshold = integer(), Nuclear_expression = numeric(), stringsAsFactors = FALSE)
summary_data_C3 <- data.frame(Sample = character(), Total_Cells = integer(), Cells_Above_Threshold = integer(), Nuclear_expression = numeric(), stringsAsFactors = FALSE)
summary_data_C4 <- data.frame(Sample = character(), Total_Cells = integer(), Cells_Above_Threshold = integer(), Nuclear_expression = numeric(), stringsAsFactors = FALSE)

# ----- USER INPUT REQUIRED -----
# DEFINE the thresholds for each sample type USER INPUT REQUIRED 
thresholds <- list(C2 = 10, C3 = 25, C4 = 255)

# Loop through each CSV file
for (file in file_list) {
  # Extract the sample name from the file name (without the .csv extension)
  sample_name <- sub(".csv$", "", basename(file))
  
  # Read the CSV file
  df <- read_csv(file, show_col_types = FALSE)
  
  # Rename the first column to 'Cell'
  colnames(df)[1] <- "Cell"
  
  # Ensure 'Mean' is numeric and handle any non-numeric values
  df <- df %>% mutate(Mean = as.numeric(Mean))
  
  # Count total rows (Total_Cells)
  total_cells <- nrow(df)
  
  # Determine the sample type (C2, C3, or C4) based on the sample name
  sample_type <- ifelse(grepl("C2", sample_name), "C2", 
                        ifelse(grepl("C3", sample_name), "C3", 
                               ifelse(grepl("C4", sample_name), "C4", "Unknown")))
  
  # Get the appropriate threshold for the sample type
  threshold_mean <- thresholds[[sample_type]]
  
  # Count rows where 'Mean' > threshold
  cells_above_threshold <- sum(df$Mean > threshold_mean, na.rm = TRUE)
  
  # Calculate the percentage of cells above the threshold
  Nuclear_expression <- (cells_above_threshold / total_cells) * 100
  
  # Create a summary row
  summary_row <- data.frame(Sample = sample_name,
                            Total_Cells = total_cells,
                            Cells_Above_Threshold = cells_above_threshold,
                            Nuclear_expression = Nuclear_expression)
  
  # Append the summary row to the corresponding summary data frame
  if (sample_type == "C2") {
    summary_data_C2 <- rbind(summary_data_C2, summary_row)
  } else if (sample_type == "C3") {
    summary_data_C3 <- rbind(summary_data_C3, summary_row)
  } else if (sample_type == "C4") {
    summary_data_C4 <- rbind(summary_data_C4, summary_row)
  }
}

# Write the summary data for each sample type to a new CSV file in the output folder
write_csv(summary_data_C2, paste0(output_folder_path, "/summary_counts_C2.csv"))
write_csv(summary_data_C3, paste0(output_folder_path, "/summary_counts_C3.csv"))
write_csv(summary_data_C4, paste0(output_folder_path, "/summary_counts_C4.csv"))

# Print a message indicating completion
cat("Summary counts CSV files for C2, C3, and C4 have been created in the output folder.\n")

