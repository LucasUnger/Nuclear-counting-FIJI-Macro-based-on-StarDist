README for FIJI Macro Analysis
Overview
This FIJI macro, in conjunction with an R script, enables the analysis of immunofluorescence (IF) expression on a per-cell basis. By setting a user-defined threshold for background levels, the macro ensures only significant signal above background is counted, allowing accurate quantification of nuclear IF expression across up to four different channels.
The macro processes images in FIJI and exports measurements per channel to CSV files. These CSV files are then analyzed by an R script, which summarizes the results for each channel and outputs summary statistics.
Prerequisites
	1	FIJI/ImageJ: Download FIJI, and ensure the StarDist plugin is installed and functioning. StarDist is required for accurate nuclear segmentation.
	2	Channel Requirements: Channel 1 must contain DAPI or a nuclear stain. For other setups, adjust channel assignments in the macro manually.
	3	R Programming Language: The R script requires the dplyr and readr libraries.
User Input
	•	Threshold Setting: The threshold for background in each channel is essential for accurate results and must be defined manually.
	•	Folders: Specify input and output directories in both the macro and R script.
	•	Channel Customization: The macro supports four channels (DAPI, C2, C3, and C4) by default. If fewer channels are needed, remove unnecessary measurement commands from the macro.
How to Use
	1	Run the FIJI macro by selecting input and output folders when prompted.
	2	Adjust the threshold for background signal for each channel in FIJI.
	3	Once the macro completes, run the R script, defining the thresholds, and folder paths for CSV files.
	4	The R script generates summary CSV files in the output folder.
Output
	•	The FIJI macro generates individual CSV files per channel per image.
	•	The R script creates summary statistics for each channel, saved as CSV files in the specified output directory.
