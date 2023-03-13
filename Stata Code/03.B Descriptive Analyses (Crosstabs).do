
*===============================================================================
* Load the clean descriptive dataset 
*===============================================================================

	use "$temp/temp.dta", clear
	
		* Drop speeders
		keep if duration_cat!="01 Less than 5 minutes"
		gen nosignup = !signup
		
		* Create a new homeownership variable 
		* (Homeowners | Renters who pay elecricity bill | Other renters)
		gen homeownership = ""
		replace homeownership = "01 Homeowners" 				 if housing=="01 Homeowner"
		replace homeownership = "02 Renters (Pay Own Elec Bill)" if housing=="02 Renter" & elec_incl_rent=="01 No"
		replace homeownership = "03 Renters (Others)"			 if housing=="02 Renter" & elec_incl_rent!="01 No"
		tab homeownership, m 

*===============================================================================
* COMPARE INDIVIDUAL RESPONSES TO MAIN REVIEW QUESTIONS AND LIKERT SCALE QUESTIONS
*===============================================================================

	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		preserve
			
			gen signup_narrow   = (inlist(`v',5))
			gen nosignup_narrow = (inlist(`v',1))
			gen signup_broad    = (inlist(`v',4,5))
			gen nosignup_broad  = (inlist(`v',1,2))
			gen dont_know       = (inlist(`v',3))
			
			*keep if review_order==1
			collapse (sum) signup_narrow signup_broad nosignup_narrow nosignup_broad dont_know, by(signup nosignup)
			gen n = signup_broad + dont_know + nosignup_broad
			egen N = total(n)
			order N, after(n)
			
			gen signup_narrow_pct   = signup_narrow/n
			gen nosignup_narrow_pct = nosignup_narrow/n 
			gen signup_broad_pct    = signup_broad/n 
			gen nosignup_broad_pct  = nosignup_broad/n 
			gen dont_know_pct       = dont_know/n
			
			gen crosstab = "compare_`v'"
			order crosstab, first
			gen demo_group = "All"
			order demo_group, after(crosstab)
			
			save "$temp/compare_`v'", replace
		restore
	}
	
*===============================================================================
* LIKERT SCALE QUESTIONS 
*===============================================================================

	*---------------------------------------------------------------------------
	* Crosstabs for the Likert scale questions
	* Contract Terms: Savings, Duration, Fees 
	*---------------------------------------------------------------------------
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		preserve
			
			gen signup_narrow   = (inlist(`v',5))
			gen nosignup_narrow = (inlist(`v',1))
			gen signup_broad    = (inlist(`v',4,5))
			gen nosignup_broad  = (inlist(`v',1,2))
			gen dont_know       = (inlist(`v',3))
			
			keep if review_order==1
			collapse (sum) signup_narrow signup_broad nosignup_narrow nosignup_broad dont_know
			gen n = signup_broad + dont_know + nosignup_broad
			egen N = total(n)
			order N, after(n)
			
			gen signup_narrow_pct   = signup_narrow/n
			gen nosignup_narrow_pct = nosignup_narrow/n 
			gen signup_broad_pct    = signup_broad/n 
			gen nosignup_broad_pct  = nosignup_broad/n 
			gen dont_know_pct       = dont_know/n
			
			gen crosstab = "`v'"
			order crosstab, first
			gen demo_group = "All"
			order demo_group, after(crosstab)
			
			save "$temp/`v'", replace
		restore
	}

	*---------------------------------------------------------------------------
	* Crosstabs for the Likert scale questions
	* Contract Terms: Savings, Duration, Fees
	* by Household Income
	*---------------------------------------------------------------------------
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		preserve
			
			gen signup_narrow   = (inlist(`v',5))
			gen nosignup_narrow = (inlist(`v',1))
			gen signup_broad    = (inlist(`v',4,5))
			gen nosignup_broad  = (inlist(`v',1,2))
			gen dont_know       = (inlist(`v',3))
			
			keep if review_order==1
			collapse (sum) signup_narrow signup_broad nosignup_narrow nosignup_broad dont_know, by(household_inc3)
			gen n = signup_broad + dont_know + nosignup_broad
			egen N = total(n)
			order N, after(n)
			
			gen signup_narrow_pct   = signup_narrow/n
			gen nosignup_narrow_pct = nosignup_narrow/n 
			gen signup_broad_pct    = signup_broad/n 
			gen nosignup_broad_pct  = nosignup_broad/n 
			gen dont_know_pct       = dont_know/n
			
			gen crosstab = "income_`v'"
			order crosstab, first

			rename household_inc3 demo_group
			order demo_group, after(crosstab)
			replace demo_group = subinstr(demo_group,"01","01 HH Income",.)
			replace demo_group = subinstr(demo_group,"02","02 HH Income",.)
			replace demo_group = subinstr(demo_group,"03","03 HH Income",.)
			
			save "$temp/income_`v'", replace
		restore
	}
		
	*---------------------------------------------------------------------------
	* Crosstabs for the Likert scale questions
	* Contract Terms: Savings, Duration, Fees
	* by Race
	*---------------------------------------------------------------------------
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		preserve
			
			gen signup_narrow   = (inlist(`v',5))
			gen nosignup_narrow = (inlist(`v',1))
			gen signup_broad    = (inlist(`v',4,5))
			gen nosignup_broad  = (inlist(`v',1,2))
			gen dont_know       = (inlist(`v',3))
			
			keep if review_order==1
			collapse (sum) signup_narrow signup_broad nosignup_narrow nosignup_broad dont_know, by(x_race)
			gen n = signup_broad + dont_know + nosignup_broad
			egen N = total(n)
			order N, after(n)

			gen signup_narrow_pct   = signup_narrow/n
			gen nosignup_narrow_pct = nosignup_narrow/n 
			gen signup_broad_pct    = signup_broad/n 
			gen nosignup_broad_pct  = nosignup_broad/n 
			gen dont_know_pct       = dont_know/n
			
			gen crosstab = "race_`v'"
			order crosstab, first
			
			gen demo_group = string(x_race)
			order demo_group, after(x_race)
			replace demo_group = "01 White"     if demo_group=="1"
			replace demo_group = "02 Black"     if demo_group=="2"
			replace demo_group = "03 Hispanic"  if demo_group=="3"
			replace demo_group = "04 Asian" 	if demo_group=="4"
			replace demo_group = "05 Other POC"	if demo_group=="5"
			drop x_race
			
			save "$temp/race_`v'", replace
		restore
	}
		
	*---------------------------------------------------------------------------
	* Crosstabs for the Likert scale questions
	* Contract Terms: Savings, Duration, Fees
	* by Homeownership
	*---------------------------------------------------------------------------
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		preserve
			
			gen signup_narrow   = (inlist(`v',5))
			gen nosignup_narrow = (inlist(`v',1))
			gen signup_broad    = (inlist(`v',4,5))
			gen nosignup_broad  = (inlist(`v',1,2))
			gen dont_know       = (inlist(`v',3))
			
			keep if review_order==1
			collapse (sum) signup_narrow signup_broad nosignup_narrow nosignup_broad dont_know, by(homeownership)
			gen n = signup_broad + dont_know + nosignup_broad
			egen N = total(n)
			order N, after(n)

			gen signup_narrow_pct   = signup_narrow/n
			gen nosignup_narrow_pct = nosignup_narrow/n 
			gen signup_broad_pct    = signup_broad/n 
			gen nosignup_broad_pct  = nosignup_broad/n 
			gen dont_know_pct       = dont_know/n
			
			gen crosstab = "homeownership_`v'"
			order crosstab, first
			
			rename homeownership demo_group
			order demo_group, after(crosstab)
			
			save "$temp/homeownership_`v'", replace
		restore
	}
		
	*---------------------------------------------------------------------------
	* Crosstabs for the Likert scale questions
	* Contract Terms: Savings, Duration, Fees 
	* by Sign-Up Willingess 
	*---------------------------------------------------------------------------
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		preserve
			
			gen signup_narrow   = (inlist(`v',5))
			gen nosignup_narrow = (inlist(`v',1))
			gen signup_broad    = (inlist(`v',4,5))
			gen nosignup_broad  = (inlist(`v',1,2))
			gen dont_know       = (inlist(`v',3))
			
			keep if review_order==1
			collapse (sum) signup_narrow signup_broad nosignup_narrow nosignup_broad dont_know
			gen n = signup_broad + dont_know + nosignup_broad
			egen N = total(n)
			order N, after(n)
			
			gen signup_narrow_pct   = signup_narrow/n
			gen nosignup_narrow_pct = nosignup_narrow/n 
			gen signup_broad_pct    = signup_broad/n 
			gen nosignup_broad_pct  = nosignup_broad/n 
			gen dont_know_pct       = dont_know/n
			
			gen crosstab = "`v'"
			order crosstab, first
			gen demo_group = "All"
			order demo_group, after(crosstab)
			
			save "$temp/`v'", replace
		restore
	}

*===============================================================================
* SIGN-UP AFTER CONTRACT REVIEW
*===============================================================================

	*-----------------------------------------------------------------------
	* Sign-Up Rates: Contract Terms Only
	*-----------------------------------------------------------------------
	foreach v in savings_rate cancel_fee length_years length_page {
		preserve
			collapse (sum) signup nosignup, by(`v')
			gen n = signup+nosignup		
			gen signup_pct = signup/n
			gen nosignup_pct = nosignup/n
			gen crosstab = "`v'"
			order crosstab, first
			gen group = "All"
			order group, after(crosstab)
			egen N = total(n)
			order N, after(n)
			save "$temp/`v'", replace
		restore		    
	}
	
	*-----------------------------------------------------------------------
	* Sign-Up Rates: Income x Contract Terms
	*-----------------------------------------------------------------------
	foreach v in savings_rate cancel_fee length_years length_page {
		preserve
			collapse (sum) signup nosignup, by(household_inc3 `v')
			gen n = signup+nosignup		
			gen signup_pct = signup/n
			gen nosignup_pct = nosignup/n
			gen crosstab = "income_`v'"
			order crosstab, first
			rename household_inc3 group 
			egen N = total(n)
			order N, after(n)
			replace group = subinstr(group,"01","01 HH Income",.)
			replace group = subinstr(group,"02","02 HH Income",.)
			replace group = subinstr(group,"03","03 HH Income",.)
			save "$temp/income_`v'", replace
		restore		    
	}
	
	*-----------------------------------------------------------------------
	* Sign-Up Rates: Income only
	*-----------------------------------------------------------------------
	preserve
		collapse (sum) signup nosignup, by(household_inc3)
		gen n = signup+nosignup		
		gen signup_pct = signup/n
		gen nosignup_pct = nosignup/n
		gen crosstab = "income"
		order crosstab, first
		rename household_inc3 group 
		egen N = total(n)
		order N, after(n)
		replace group = subinstr(group,"01","01 HH Income",.)
		replace group = subinstr(group,"02","02 HH Income",.)
		replace group = subinstr(group,"03","03 HH Income",.)
		save "$temp/income", replace
	restore	
	
	*-----------------------------------------------------------------------
	* Sign-Up Rates: Race x Contract Terms
	*-----------------------------------------------------------------------
	foreach v in savings_rate cancel_fee length_years length_page {
		preserve
			collapse (sum) signup nosignup, by(x_race `v')
			gen n = signup+nosignup		
			gen signup_pct = signup/n
			gen nosignup_pct = nosignup/n
			gen crosstab = "race_`v'"
			order crosstab, first
			rename x_race group 
			egen N = total(n)
			order N, after(n)
			gen group2 = string(group)
			order group2, after(group)
			replace group2 = "01 White" if group2=="1"
			replace group2 = "02 Black" if group2=="2"
			replace group2 = "03 Hispanic" if group2=="3"
			replace group2 = "04 Asian" if group2=="4"
			replace group2 = "05 Other POC" if group2=="5"
			drop group
			rename group2 group
			save "$temp/race_`v'", replace
		restore
	}
	
	*-----------------------------------------------------------------------
	* Sign-Up Rates: Race only
	*-----------------------------------------------------------------------
	preserve
		collapse (sum) signup nosignup, by(x_race)
		gen n = signup+nosignup		
		gen signup_pct = signup/n
		gen nosignup_pct = nosignup/n
		gen crosstab = "race"
		order crosstab, first
		rename x_race group 
		egen N = total(n)
		order N, after(n)
		gen group2 = string(group)
		order group2, after(group)
		replace group2 = "01 White" if group2=="1"
		replace group2 = "02 Black" if group2=="2"
		replace group2 = "03 Hispanic" if group2=="3"
		replace group2 = "04 Asian" if group2=="4"
		replace group2 = "05 Other POC" if group2=="5"
		drop group
		rename group2 group
		save "$temp/race", replace
	restore
	
	*-----------------------------------------------------------------------
	* Sign-Up Rates: Homeownership x Contract Terms
	*-----------------------------------------------------------------------
	foreach v in savings_rate cancel_fee length_years length_page {
		preserve
			collapse (sum) signup nosignup, by(homeownership `v')
			gen n = signup+nosignup		
			gen signup_pct = signup/n
			gen nosignup_pct = nosignup/n
			gen crosstab = "homeownership_`v'"
			order crosstab, first
			rename homeownership group 
			egen N = total(n)
			order N, after(n)
			save "$temp/homeownership_`v'", replace
		restore		    
	}
	
	*-----------------------------------------------------------------------
	* Sign-Up Rates: Homeownership only
	*-----------------------------------------------------------------------
	preserve
		collapse (sum) signup nosignup, by(homeownership)
		gen n = signup+nosignup		
		gen signup_pct = signup/n
		gen nosignup_pct = nosignup/n
		gen crosstab = "homeownership"
		order crosstab, first
		rename homeownership group 
		egen N = total(n)
		order N, after(n)
		save "$temp/homeownership", replace
	restore	

*===============================================================================
* COMBINE ALL COMPARISON CROSSTABS (MAIN REVIEW VS LIKERT)
*===============================================================================	

	clear
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		append using "$temp/compare_`v'"
	}
	gen rowid = _n 
	order rowid, first
	// assert N==2186
	drop nosignup
	
	sum signup_narrow_pct if signup==1, d 
	sum signup_narrow_pct if signup==0, d
	
	hist signup_narrow_pct, by(signup) fraction
	
	tab signup, sum(signup_narrow_pct)
	tab signup, sum(signup_broad_pct)
	tab signup, sum(nosignup_narrow_pct)
	tab signup, sum(nosignup_broad_pct)
	tab signup, sum(dont_know_pct)
	
	export excel using "$output/Crosstabs by Contract and Demographics.xlsx", ///
		sheet("comparison") sheetreplace firstrow(variables)
	
*===============================================================================
* COMBINE ALL LIKERT CROSSTABS
*===============================================================================
			
	clear
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		append using "$temp/`v'"
	}
	foreach v in savings_none  savings_1_5  savings_6_10  savings_11_15  savings_16_20  savings_21_50  savings_50_plus ///
				 years_0_1     years_1_3    years_4_6     years_7_10     years_11_15    years_16_20    years_21_plus ///
				 fees_none     fees_1_100   fees_101_250  fees_251_500   fees_501_1000  fees_1000_plus {
		append using "$temp/income_`v'"
		append using "$temp/race_`v'"
		append using "$temp/homeownership_`v'"
	}
	gen rowid = _n 
	order rowid, first
	// assert N==1093
	
	export excel using "$output/Crosstabs by Contract and Demographics.xlsx", ///
		sheet("likert_questions") sheetreplace firstrow(variables)
		
	/*
	sum signup_narrow_pct, d 
	sum signup_broad_pct, d 
	
	sum nosignup_narrow_pct, d 
	sum nosignup_broad_pct, d 
	
	sum dont_know_pct, d 
	
	gsort -signup_narrow_pct
	
	gsort -signup_broad_pct 
	*/

*===============================================================================
* COMBINE ALL CROSSTABS FROM MAIN REVIEW
*===============================================================================
		
	clear
	foreach v in savings_rate cancel_fee length_years length_page {
		append using "$temp/`v'" 
	}
	append using "$temp/income"
	append using "$temp/race"
	append using "$temp/homeownership"
	foreach v in savings_rate cancel_fee length_years length_page {
		append using "$temp/`v'"
		append using "$temp/income_`v'"
		append using "$temp/race_`v'"
		append using "$temp/homeownership_`v'"   
	}
	gen rowid = _n
	order rowid, first
	// assert N==2186
		
	gen contract_term = ""
	order contract_term, after(group)
	replace contract_term = string(savings_rate)+"% Savings Rate"   if !missing(savings_rate)
	replace contract_term = "|"+string(cancel_fee)+" Cancellation Fee" if !missing(cancel_fee)
	replace contract_term = subinstr(contract_term,"|","$",.)
	replace contract_term = string(length_years) + "-Year Contract" if !missing(length_years)
	replace contract_term = string(length_page) + "-Page Contract" if !missing(length_page)	
	drop savings_rate
	drop cancel_fee
	drop length_years 
	drop length_page 
		
	replace contract_term = "All" if missing(contract_term)
	rename group demo_group
	
	export excel using "$output/Crosstabs by Contract and Demographics.xlsx", ///
		sheet("main_review") sheetreplace firstrow(variables)
		
