# Load necessary libraries
library(simmr)

# Data preparation
C14DIC_photic <- c(-162.48, -144.02, -142.40, -97.18, -95.94, -98.18, -88.14)
C14DIC_hypolimnion <- c(-184.57, -151.93, -144.33, -130.33, -98.83, -92.90, -88.14)
C14DIC_outflow <- c(-186.69, -144.51, -148.05, -136.44, -94.57, -88.14, -88.14)

C14DIC_photic_name <- c("C14modern", "C14carbonate-al", "C14om-al", "C14om-au")
C14DIC_hypolimnion_name <- c("C14modern", "C14carbonate-al", "C14om-al", "C14au-C")
C14DIC_outflow_name <- c("C14modern", "C14carbonate-al", "C14om-al", "C14au-C")

# δ13C values of carbon sources
source_data_photic <- matrix(c(7, -1000, -515, -197), nrow = 4, ncol = 1)
source_data_hypolimnion_outflow <- matrix(c(7, -1000, -515, -195.5), nrow = 4, ncol = 1)

# Assume standard deviations
source_sds_photic <- matrix(c(1.9, 0, 0.3, 0.3), nrow = 4, ncol = 1)
source_sds_hypolimnion_outflow <- matrix(c(1.9, 0, 0.3, 0.3), nrow = 4, ncol = 1)

# Define model list
model_data <- list(
  photic = C14DIC_photic,
  hypolimnion = C14DIC_hypolimnion,
  outflow = C14DIC_outflow
)

# Create CSV file path
file_path <- 'C:/Users/Admin/Desktop/Ecosci/C14 Isotope/Isotope R/simmr_results_summary test.csv'

# Clear the file and create a new one (do not use append mode)
cat("", file = file_path)

# Assuming the summary results contain "Mean", "SD" columns, adjust according to actual column names
write.table(data.frame(Parameter = "", Mean = "Mean", SD = "SD"), file = file_path, sep = ",", row.names = FALSE, col.names = FALSE)

# Loop through each model
for (model_name in names(model_data)) {
  # Get the DIC values of the current model
  dic_values <- model_data[[model_name]]
  
  # Process each DIC value separately
  for (dic_value in dic_values) {
    # Create a 1-column matrix where each DIC value is an observation
    mixtures_matrix <- matrix(dic_value, nrow = 1, ncol = 1)
    
    # Set source_means and source_sds
    source_means <- if (model_name == "photic") {
      source_data_photic
    } else {
      source_data_hypolimnion_outflow
    }
    
    source_sds <- if (model_name == "photic") {
      source_sds_photic
    } else {
      source_sds_hypolimnion_outflow
    }
    
    source_names <- if (model_name == "photic") {
      C14DIC_photic_name
    } else if (model_name == "hypolimnion") {
      C14DIC_hypolimnion_name
    } else {
      C14DIC_outflow_name
    }
    
    # Load the model
    simmr_in <- simmr_load(
      mixtures = mixtures_matrix,
      source_means = source_means,
      source_sds = source_sds,
      source_names = source_names
    )
    
    # Run MCMC and increase the number of chains and iterations
    simmr_out <- simmr_mcmc(simmr_in)
    
    # Get summary results
    summary_out <- summary(simmr_out)

    # Convert summary_out to a dataframe
    summary_df <- as.data.frame(summary_out$statistics)

    # Write to CSV file in append mode
    write.table(summary_df, file = file_path, append = TRUE, sep = ",", col.names = FALSE, row.names = TRUE)
  }
}

cat("Summary for all samples has been saved to", file_path)


