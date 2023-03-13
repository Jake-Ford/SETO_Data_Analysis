
*===============================================================================
* Multinomial ordered logit 
*===============================================================================

	*** ***********************************************************************
	use "$output/QUALTRICS_survey_data_all.dta", clear
	****************************************************************************
	
	label var 	x_gov			"Government Program Usage"


	label define new_race 1 "White" 2 "Black" 3 "Hispanic" 4 "Asian" 5 "Other"
	label values x_race new_race
	
	gen y_savings_1_5 = savings_1_5
		label define y_savings_1_5 1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative"
		label values y_savings_1_5 y_savings_1_5
	
	gen y_savings_6_10 = savings_6_10
		label define y_savings_6_10 1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative"
		label values y_savings_6_10 y_savings_6_10
	
	gen y_savings_11_15 = savings_11_15
		label define y_savings_11_15 1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative"
		label values y_savings_11_15 y_savings_11_15

	gen y_savings_16_20 = savings_16_20
		label define y_savings_16_20 1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative"
		label values y_savings_16_20 y_savings_16_20
		
	gen y_savings_21_50 = savings_21_50
		label define y_savings_21_50 1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative"
		label values y_savings_21_50 y_savings_21_50
		
	gen y_savings_50_plus = savings_50_plus
		label define y_savings_50_plus 1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative"
		label values y_savings_50_plus y_savings_50_plus
		
		
	gen y_fees_1_100 = fees_1_100
		label values y_fees_1_100 y_savings_1_5
	
	gen y_fees_101_250 = fees_101_250 
		label values y_fees_101_250 y_savings_1_5
	
	gen y_fees_251_500 = fees_251_500
		label values y_fees_251_500 y_savings_1_5

	gen y_fees_501_1000 = fees_501_1000
		label values y_fees_501_1000 y_savings_1_5
		
	gen y_fees_1000_plus = fees_1000_plus
		label values y_fees_1000_plus y_savings_1_5
	
	
	
	gen y_years_1_3 = years_1_3
		label values y_years_1_3 y_savings_1_5
	
	gen y_years_4_6 = years_4_6 
		label values y_years_4_6 y_savings_1_5
	
	gen y_years_7_10 = years_7_10
		label values y_years_7_10 y_savings_1_5

	gen y_years_11_15 = years_11_15
		label values y_years_11_15 y_savings_1_5
		
	gen y_years_16_20 = years_16_20
		label values y_years_16_20 y_savings_1_5
	
	gen y_years_21_plus = years_21_plus
		label values y_years_21_plus y_savings_1_5
		

			/*How does savings rate impact willingness to sign up?*/
	/*		savings_none 
			savings_1_5 
			savings_6_10 
			savings_11_15 
			savings_16_20 
			savings_21_50 
			savings_50_plus 
			
			/*How does contract duration impact willingess to sign up?*/
			years_0_1 
			years_1_3 
			years_4_6 
			years_7_10 
			years_11_15 
			years_16_20 
			years_21_plus 
			
			/*How do cancellation fees impact willingness to sign up?*/
			fees_none 
			fees_1_100 
			fees_101_250 
			fees_251_500 
			fees_501_1000 
			fees_1000_plus */
			

	gen weight_income_int = int(weight_income)
	gen weight_race_int = int(weight_race)
	
	drop if x_hs > 2 // drop the 'other category'
			
	*---------------------------------------------------------------------------
	* Savings Rates None- use demographic variables to analyze differences
	*---------------------------------------------------------------------------
			
		
	#delimit;
	mlogit 
		savings_none 
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	estimates store m1, title(SR: None)
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Savings Rate None") name(file1, replace) legend(off)
		
	
	/* Relative Risk Ratio */
	
	mlogit,rrr	

	estimates store m1_rrr, title(SR: None)
	
	*---------------------------------------------------------------------------
	* Savings Rates 1-5 - use demographic variables to analyze differences
	*---------------------------------------------------------------------------	
		
	#delimit;
	mlogit 
		y_savings_1_5 
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	

	estimates store m2, title(Savings 1-5%)

	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Savings Rate 1-5%") name(file2, replace) legend(off)
		
	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m2_rrr, title(Savings 1-5%)

	

	*---------------------------------------------------------------------------
	* Savings Rates 6-10 - use demographic variables to analyze differences
	*---------------------------------------------------------------------------	
		
		
		
	#delimit;
	mlogit 
		y_savings_6_10
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	

	estimates store m3, title(SR: 6-10%)

	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Savings Rate 6-10%") name(file3, replace) legend(off)
		
	
	/* Relative Risk Ratio */
	
	mlogit,rrr

	estimates store m3_rrr, title(SR: 6-10%)
	
		
	*---------------------------------------------------------------------------
	* Savings Rates 11-15 - use demographic variables to analyze differences
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_savings_11_15
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	

	estimates store m4, title(SR: 11-15%)
	
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Savings Rate 11-15%") name(file4, replace) legend(off)
		
	/* Relative Risk Ratio */
	
	mlogit,rrr

	estimates store m4_rrr, title(SR: 11-15%)
	

		
	*---------------------------------------------------------------------------
	* Savings Rates 16-20 - use demographic variables to analyze differences
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_savings_16_20
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	estimates store m5, title(SR: 16-20%)
	
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Savings Rate 16-20%") name(file5, replace) legend(off)
		
	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m5_rrr, title(SR: 16-20%)
		
	*---------------------------------------------------------------------------
	* Savings Rates 21-50 - use demographic variables to analyze differences
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_savings_21_50
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	
	estimates store m6, title(SR: 21-50%)
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Savings Rate 21-50%") name(file6, replace) legend(off)
		

	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m6_rrr, title(SR: 21-50%)
		
	*---------------------------------------------------------------------------
	* Savings Rates 50_plus - use demographic variables to analyze differences
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_savings_50_plus
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 
	
	estimates store m7, title(SR: >50%)
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Savings Rate >50%") name(file7, replace) legend(off)
	
	
	/* Relative Risk Ratio */
	
	mlogit,rrr

	estimates store m7_rrr, title(SR: >50%)
	
	
	
	*---------------------------------------------------------------------------
	* Save models and export into rtf/word files
	*---------------------------------------------------------------------------		



	esttab m4 m5 m6 using "$output/regressions/Table2_savings_rate_m5_7.html", replace cells(b(star fmt(3))) ///
		legend label varlabels(_cons Constant) ///
		mtitles("SR: 16-20" "SR: 20-50" "SR: >50") ///
		title({\b Table 2.} {\i Multinomial Logistic Regression: Savings Rate})
		



	esttab m1_rrr m2_rrr m3_rrr m4_rrr using "$output/regressions/Table3_savings_rate_m1_4_rrr.rtf", replace cells(b(star fmt(3))) ///
		legend label varlabels(_cons Constant) ///
		mtitles("SR: None" "SR: 1-5" "SR: 6-10" "SR: 11-15") ///
		title({\b Table 3.} {\i Relative Risk Ratios: Savings Rate})
		

	esttab m4_rrr m5_rrr m6_rrr using "$output/regressions/Table4_savings_rate_m5_7_rrr.rtf", replace cells(b(star fmt(3))) ///
		legend label varlabels(_cons Constant) ///
		mtitles("SR: 16-20" "SR: 20-50" "SR: >50") ///
		title({\b Table 4.} {\i Relative Risk Ratios: Savings Rate})

	eststo clear
	
	
*===============================================================================
* Multinomial ordered logit - Savings Rate
*===============================================================================

	esttab m2_rrr m3_rrr m4_rrr using "$output/regressions/mlogit_table1.html", noobs unstack noomitted eform varwidth(25) replace cells(b(star fmt(3))) ///
		drop(1.x_race 3.x_inc 1.x_hs 1.x_fam) label varlabels(_cons Constant)  ///
		refcat(2.x_race "01 White" 2.x_inc "01 Low Income" 2.x_hs "01 Homeowner" 2.x_fam "01 Less Familiar") ///
	    mtitles("Savings Rate None" "Savings Rate 1-5%" "Savings Rate 6-10%") legend ///
		title("Relative risks ratios of the multinomial logistic regression model (reference group: neutral)") 
		
	esttab m5_rrr m6_rrr m7_rrr using "$output/regressions/mlogit_table2.html", noobs unstack noomitted eform varwidth(25) replace cells(b(star fmt(3))) ///
		drop(1.x_race 3.x_inc 1.x_hs 1.x_fam) label varlabels(_cons Constant)  ///
		refcat(2.x_race "01 White" 2.x_inc "01 Low Income" 2.x_hs "01 Homeowner" 2.x_fam "01 Less Familiar") ///
	    mtitles("Savings Rate 16-20%" "Savings Rate 21-50%" "Savings Rate >50%%") legend ///
		title("(Continued) Relative risks ratios of the multinomial logistic regression model (reference group: neutral)") 

		
		
		
*===============================================================================
* MarginsPlot
*===============================================================================
	
		
grc1leg file2 file3 file4 file5 file6 file7, rows(2) cols(3) 
graph export "$output/regressions/Marginsplot Savings Rate.png", as(png) replace


		
*===============================================================================
* CANCELLATION FEES
*===============================================================================
		
	#delimit;
	mlogit 
		fees_none 
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	estimates store m1, title(Fees: None)
	
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Fees None") name(file1, replace) legend(off)
	
	/* Relative Risk Ratio */
	
	mlogit,rrr	

	estimates store m1_rrr, title(Fees: None)
	
	*---------------------------------------------------------------------------
	* Fees 1-100 
	*---------------------------------------------------------------------------	
		
	#delimit;
	mlogit 
		y_fees_1_100 
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	

	estimates store m2, title(Fees 1-100)

	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Fees 1-100") name(file2, replace) legend(off)
	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m2_rrr, title(Fees 1-100)

	

	*---------------------------------------------------------------------------
	* Fees 101-250 
	*---------------------------------------------------------------------------	
		
		
		
	#delimit;
	mlogit 
		y_fees_101_250
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	

	estimates store m3, title(Fees 101-250)

	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Fees 101-250") name(file3, replace) legend(off)
	
	/* Relative Risk Ratio */
	
	mlogit,rrr

	estimates store m3_rrr, title(Fees 101-250)
	
		
	*---------------------------------------------------------------------------
	* Fees 251-500
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_fees_251_500
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	

	estimates store m4, title(Fees 251-500)
	

	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Fees 251-500") name(file4, replace) legend(off)
	
	/* Relative Risk Ratio */
	
	mlogit,rrr

	estimates store m4_rrr, title(Fees 251-500)
	

		
	*---------------------------------------------------------------------------
	* Fees 501-1000 
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_fees_501_1000
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	estimates store m5, title(Fees 501-1000)
		
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Fees 501-1000") name(file5, replace) legend(off)
	
	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m5_rrr, title(Fees 501-1000)
		
	*---------------------------------------------------------------------------
	* Fees 1000 Plus 
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_fees_1000_plus
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	
	estimates store m6, title(Fees 1000 Plus)
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Fees 1000+") name(file6, replace) legend(off)
	

	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m6_rrr, title(Fees 1000 Plus)
		

	
	
	
	
	
*===============================================================================
* Multinomial ordered logit - Fees
*===============================================================================

	esttab m2_rrr m3_rrr m4_rrr using "$output/regressions/mlogit_fees_table1.html", noobs unstack noomitted eform varwidth(25) replace cells(b(star fmt(3))) ///
		drop(1.x_race 3.x_inc 1.x_hs 1.x_fam) label varlabels(_cons Constant)  ///
		refcat(2.x_race "01 White" 2.x_inc "01 Low Income" 2.x_hs "01 Homeowner" 2.x_fam "01 Less Familiar") ///
	    mtitles("Fee 1-100" "Fee 101-250" "Fee 251-500") legend ///
		title("Relative risks ratios of the multinomial logistic regression model (reference group: neutral)") 
		
	esttab m5_rrr m6_rrr using "$output/regressions/mlogit__fees_table2.html", noobs unstack noomitted eform varwidth(25) replace cells(b(star fmt(3))) ///
		drop(1.x_race 3.x_inc 1.x_hs 1.x_fam) label varlabels(_cons Constant)  ///
		refcat(2.x_race "01 White" 2.x_inc "01 Low Income" 2.x_hs "01 Homeowner" 2.x_fam "01 Less Familiar") ///
	    mtitles("Fee 500-1000" "Fee 1000 Plus"	 ) legend ///
		title("(Continued) Relative risks ratios of the multinomial logistic regression model (reference group: neutral)") 
		
		
		
		
		
*===============================================================================
* MarginsPlot
*===============================================================================
	
		
grc1leg file1 file2 file3 file4 file5 file6 , rows(2) cols(3) 
graph export "$output/regressions/Marginsplot Fees.png", as(png) replace











*===============================================================================
* CONTRACT YEARS
*===============================================================================
			
	
		
	*---------------------------------------------------------------------------
	* Years  1-3
	*---------------------------------------------------------------------------
			
		
	#delimit;
	mlogit 
		y_years_1_3 
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	estimates store m1
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Years 1-3") name(file1, replace) legend(off)
	
	/* Relative Risk Ratio */
	
	mlogit,rrr	

	estimates store m1_rrr
	
	*---------------------------------------------------------------------------
	* Years  4-6 
	*---------------------------------------------------------------------------	
		
	#delimit;
	mlogit 
		y_years_4_6 
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	

	estimates store m2, title(Fees 1-100)
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Years 4-6") name(file2, replace) legend(off)

	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m2_rrr, title(Fees 1-100)

	

	*---------------------------------------------------------------------------
	* Years  7-10 
	*---------------------------------------------------------------------------	
		
		
		
	#delimit;
	mlogit 
		y_years_7_10
		i.x_race 
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	

	estimates store m3

	margins i.x_race, atmeans saving(file3, replace)
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Years 7-10") name(file3, replace) legend(off)

	/* Relative Risk Ratio */
	
	mlogit,rrr

	estimates store m3_rrr
	
		
	*---------------------------------------------------------------------------
	* Years 11-15
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_years_11_15
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	

	estimates store m4
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Years 11-15") name(file4, replace) legend(off)

	/* Relative Risk Ratio */
	
	mlogit,rrr

	estimates store m4_rrr
	

		
	*---------------------------------------------------------------------------
	* Years 16-20
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_years_16_20
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	estimates store m5
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Years 16-20") name(file5, replace) legend(off)

	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m5_rrr
		
	*--------------------------------------------------------------------------- 
	* Years 21 Plus 
	*---------------------------------------------------------------------------	
		
		
	#delimit;
	mlogit 
		y_years_21_plus
		i.x_race
		ib3.x_inc 
		i.x_hs 
		i.x_fam 
		[fweight=weight_race_int],
		baseoutcome(3)
		cluster(id)
	;
	#delimit cr 	
	
	
	estimates store m6
	
	margins i.x_race, atmeans
	
	marginsplot, legend(on order(1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative")) title("Years 21+") name(file6, replace) legend(off) 


	
	/* Relative Risk Ratio */
	
	mlogit,rrr
	
	estimates store m6_rrr
		

	

	
	
*===============================================================================
* Multinomial ordered logit - Fees
*===============================================================================

	esttab m2_rrr m3_rrr m4_rrr using "$output/regressions/mlogit_years_table1.html", noobs unstack noomitted eform varwidth(25) replace cells(b(star fmt(3))) ///
		drop(1.x_race 3.x_inc 1.x_hs 1.x_fam) label varlabels(_cons Constant)  ///
		refcat(2.x_race "01 White" 2.x_inc "01 Low Income" 2.x_hs "01 Homeowner" 2.x_fam "01 Less Familiar") ///
	    mtitles("1-3 Years" "4-6 Years" "7-10 Years") legend ///
		title("Relative risks ratios of the multinomial logistic regression model (reference group: neutral)") 
		
	esttab m5_rrr m6_rrr m7_rrr using "$output/regressions/mlogit__years_table2.html", noobs unstack noomitted eform varwidth(25) replace cells(b(star fmt(3))) ///
		drop(1.x_race 3.x_inc 1.x_hs 1.x_fam) label varlabels(_cons Constant)  ///
		refcat(2.x_race "01 White" 2.x_inc "01 Low Income" 2.x_hs "01 Homeowner" 2.x_fam "01 Less Familiar") ///
	    mtitles("11-15 Years" "16-20 Years" "21+ Years") legend ///
		title("(Continued) Relative risks ratios of the multinomial logistic regression model (reference group: neutral)") 

		
*===============================================================================
* MarginsPlot
*===============================================================================
	
		
grc1leg file1 file2 file3 file4 file5 file6 , rows(2) cols(3) 
graph export "$output/regressions/Marginsplot Years.png", as(png) replace

