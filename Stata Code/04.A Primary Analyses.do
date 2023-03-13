
*===============================================================================
* 
*===============================================================================

	*** EDIT REQUIRED: *********************************************************
	* The name of the file will need to be changed from "MOCK"
 	 use "$output/QUALTRICS_survey_data_all.dta", clear
	
	
//	use "/Volumes/GoogleDrive/Shared drives/*Solstice | Low Income Inclusion/Projects/2019-2022 DOE SETO Contract Innovations/DOE SETO Project Implementation/Project Management/Churn & Default Analysis/Qualtrics Survey/seto_survey/output/QUALTRICS_survey_data_all.dta", clear
	****************************************************************************
	
	gen weight_income_int = int(weight_income)
	gen weight_race_int = int(weight_race)
	
	
	* Keep only the variables relevant for the logistic regression
	#delimit;
	keep 
		source
		respid
		weight_race
		weight_income_int
		weight_race_int
		id
		y_*
		x_*
	;
	#delimit cr
	
	
	#delimit;
	logit 
		y_signup 
		i.x_sr
		ib2.x_cly 
		ib2.x_clp 
		ib2.x_cf 
		ib3.x_inc 
		i.x_race 
		i.x_hs 
		i.x_fam 
		i.x_rev 
		i.x_ord 
		/*i.x_comm*/
		[pweight=weight_race_int],
		cluster(id)
	;
	#delimit cr 
	
	*---------------------------------------------------------------------------
	* Controlling for savings rate (x_sr)
	*---------------------------------------------------------------------------
	
	#delimit;
	logit 
		y_signup 
		i.x_sr 
		[pweight=weight_race_int]
		,
		cluster(id)
	;
	#delimit cr 
	
	estimates store m1, title(Model 1)
	
	margins x_sr 
	


	
	
	
	
	*---------------------------------------------------------------------------
	* Controlling for savings rate (x_sr) and income (x_inc)
	*---------------------------------------------------------------------------

	#delimit;
	logit 
		y_signup 
		i.x_sr 
		i.x_inc 
		,
		cluster(id)
	;
	#delimit cr 
	
	estimates store m2, title(Model 2)
	
	
	margins x_sr x_inc  
	


	*---------------------------------------------------------------------------
	* Controlling for savings rate (x_sr) and race (x_race) and income (x_inc)
	*---------------------------------------------------------------------------

	#delimit;
	logit 
		y_signup 
		i.x_sr 
		i.x_inc 
		i.x_race 
		,
		cluster(id)
	;
	
	#delimit cr 
	
	estimates store m3, title(Model 3)
	
	margins x_sr x_race  
	

	
	*---------------------------------------------------------------------------
	* Controlling for savings rate (x_sr) and income (x_inc) nd race(x_race) 
	*---------------------------------------------------------------------------

	#delimit;
	logit 
		y_signup 
		i.x_sr 
		i.x_inc 
		i.x_race
		i.x_hs
		[pweight=weight_race]
		,
		cluster(id)
		// or
	;
	#delimit cr 
	estimates store m4, title(Model 4)
	
	margins x_sr x_inc x_race
	
	*---------------------------------------------------------------------------
	* Controlling for savings rate, income, race, and contract attributes - pages, years, cancel fee
	*---------------------------------------------------------------------------

	#delimit;
	logit 
		y_signup 
		i.x_sr 
		i.x_inc 
		i.x_race
		i.x_hs
		i.x_clp
		i.x_cly
		i.x_cf
		[pweight=weight_race]
		,
		cluster(id)
	;
	#delimit cr 
	estimates store m5, title(Model 5)
	
	margins x_sr x_inc x_race x_clp x_cly x_cf
	
	
	*---------------------------------------------------------------------------
	* Controlling for savings rate, income, race, and contract attributes - pages, years, cancel fee
	* and familiarity
	*---------------------------------------------------------------------------

	#delimit;
	logit 
		y_signup 
		i.x_sr 
		i.x_inc 
		i.x_race
		i.x_hs
		i.x_clp
		i.x_cly
		i.x_cf
		i.x_fam
		[pweight=weight_race]
		,
		cluster(id)
	;
	#delimit cr 
	estimates store m6, title(Model 6)
	
	margins x_sr x_inc x_race x_clp x_cly
	
	*---------------------------------------------------------------------------
	* Controlling for savings rate, income, race, and contract attributes - pages, years, cancel fee
	* and familiarity and review
	*---------------------------------------------------------------------------

	#delimit;
	logit 
		y_signup 
		i.x_sr 
		i.x_inc 
		i.x_race
		i.x_hs
		i.x_clp
		i.x_cly
		i.x_cf
		i.x_fam
		i.x_rev
		[pweight=weight_race]
		,
		cluster(id)
	;
	#delimit cr 
	estimates store m7, title(Model 7)
	
	margins x_sr x_inc x_race x_clp x_cly x_cf x_rev
	
	
	
	
	
	esttab m1 m2 m3 m4 using "$output/regressions/Primary_Table1.html" , replace cells(b(star fmt(3))) refcat("Reference") ///
		legend label varlabels(_cons Constant) ///
		mtitles("Model 1" "Model 2" "Model 3" "Model 4") ///
		title("Table 1 Logistic Regression Results") 

		
		
	esttab m5 m6 m7 using "$output/regressions/Primary_Table2.html", replace cells(b(star fmt(3))) ///
		legend label varlabels(_cons Constant) ///
		mtitles("Model 5" "Model 6" "Model 7") ///
		title("Table 1 Logistic Regression Results, Continued")
		

		
	esttab m1 m2 m3 m4 m5 m6 m7 using "$output/regressions/Primary_Table_combined.html", replace cells(b(star fmt(3))) ///
		legend label varlabels(_cons Constant) ///
		 mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6" "Model 7") ///
		title("Table 1 Logistic Regression Results")
		
	esttab m1 m2 m3 m4 m5 m6 m7 using "$output/regressions/Primary_Table2_combined_OR.html", replace cells(b(star fmt(3))) eform ///
		legend label varlabels(_cons Constant) ///
		 mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6" "Model 7") ///
		title("Table 2 Odds Ratios")
