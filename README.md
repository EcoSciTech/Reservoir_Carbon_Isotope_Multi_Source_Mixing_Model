# Reservoir Carbon Isotope Multi-Source Mixing Model

# Overview

This R script performs C14 Isotope Analysis using the simmr package. It processes isotopic data from different water layers (photic, hypolimnion, and outflow), runs a Bayesian mixing model (simmr_mcmc), and saves the summary results to a CSV file.

# Dependencies

Ensure you have the following R package installed before running the script:

  - **install.packages("simmr")**

Load the required library:

  - **library(simmr)**

# Data Structure

The script analyzes C14 DIC (Dissolved Inorganic Carbon) isotope values from three different water layers:

- **Photic Zone (C14DIC_photic)**

- **Hypolimnion (C14DIC_hypolimnion)**

- **Outflow (C14DIC_outflow)**

Each layer contains isotopic values used as input data for the Bayesian mixing model.

# Carbon Sources and Isotopic Values

The model uses predefined δ13C values for different carbon sources:

- **source_data_photic: Carbon sources for the photic layer**
  
- **source_data_hypolimnion_outflow: Carbon sources for the hypolimnion and outflow layers**

The sources also have associated standard deviations (source_sds_photic, source_sds_hypolimnion_outflow).

# Execution Steps

1. Initialize data: The script defines isotopic values for different water layers.

2. Loop through each layer and isotope value:

    - **Load data into simmr_load().**

    - **Run Bayesian MCMC model using simmr_mcmc().**

    - **Extract results and save them to a CSV file.**

3. Save results: The processed data is written to simmr_results_summary_test.csv.

# Output

- The script generates a CSV file containing the summary results from the Bayesian analysis.
- Each row represents a different isotopic analysis with calculated Bayesian statistics.
