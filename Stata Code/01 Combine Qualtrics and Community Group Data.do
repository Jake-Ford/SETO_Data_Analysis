
*===============================================================================
* Append the data from the Qualtrics panel with the data from the community groups
* If there's more than one community group dataset, lines 20-21 can be repeated 
* as many times as necessary for each community group dataset, where the source
* is equal to e.g., "community group 1", "community group 2", etc.
*===============================================================================
	
	*---------------------------------------------------------------------------
	* Load the Qualtrics data with clean variable names 
	* created in the 00.A .do file
	* 
	* Then create a variable called "source" equal to string "01 qualtrics panel" 
	* to indicate that these observations come from the Qualtrics panel.
	* Identifying the data source will be crucial for (1) controlling for 
	* community groups in the regression, and (2) properly weighting the survey 
	*---------------------------------------------------------------------------
	use "$temp/survey_data_clean_names_qualtrics.dta", clear
		gen source = "01 qualtrics panel"

	
	*---------------------------------------------------------------------------
	* Append the community group dataset with clean variable names 
	* created in the 00.B .do file
	* 
	* Because the variable "source" was in the Qualtrics file but not the community
	* group file, it will be missing for the observations that come from the 
	* community group file(s). To identify the observations that come from the 
	* community groups, replace "source" with "02 community groups" where "source"
	* is missing.
	*---------------------------------------------------------------------------
	append using "$temp/survey_data_clean_names_community.dta"
		replace source = "02 community groups" if missing(source)
	



	save "$temp/survey_data_clean_names_combined.dta", replace

*===============================================================================
* End of file
*===============================================================================
