

use "/Users/jacobford/Library/CloudStorage/GoogleDrive-jake@solstice.us/Shared drives/*Solstice | Low Income Inclusion/Projects/2019-2022 DOE SETO Contract Innovations/DOE SETO Project Implementation/Project Management/SETO Data Analysis/1. Community Solar Priorities/Qualtrics Survey/seto_survey/output/QUALTRICS_survey_data_all.dta", clear
	

quietly gen weight_race_int = int(weight_race)

quietly gen y_fees_1_100 = fees_1_100
		label define y_savings_1_5 1 "Negative" 2 "Unlikely" 3 "Neutral" 4 "Likely" 5 "Affirmative"
  	label values y_fees_1_100 y_savings_1_5
		
quietly gen y_fees_101_250 = fees_101_250
		label values y_fees_101_250 y_savings_6_10
	
quietly gen y_fees_251_500 = fees_251_500
		label values y_fees_251_500 y_savings_11_15

quietly gen y_fees_501_1000 = fees_501_1000
		label values y_fees_501_1000 y_savings_16_20
		
quietly gen y_fees_1000_plus = fees_1000_plus
		label values y_fees_1000_plus y_savings_21_50
		

		
drop if x_hs > 2

eststo: quietly	mlogit y_fees_1_100 i.x_race	ib3.x_inc	i.x_hs i.x_fam [fweight=weight_race_int], baseoutcome(3)cluster(id)

eststo: quietly	mlogit y_fees_101_250 i.x_race	ib3.x_inc	i.x_hs i.x_fam [fweight=weight_race_int], baseoutcome(3)cluster(id)

eststo: quietly	mlogit y_fees_251_500 i.x_race	ib3.x_inc	i.x_hs i.x_fam [fweight=weight_race_int], baseoutcome(3)cluster(id)
	
//eststo: quietly	mlogit y_fees_501_1000 i.x_race	ib3.x_inc	i.x_hs i.x_fam [fweight=weight_race_int], baseoutcome(3)cluster(id)
	
//eststo: quietly	mlogit y_fees_1000_plus i.x_race	ib3.x_inc	i.x_hs i.x_fam [fweight=weight_race_int], baseoutcome(3)cluster(id)
	


esttab, noobs unstack noomitted eform varwidth(25) replace cells(b(star fmt(3))) ///
		drop(1.x_race 3.x_inc 1.x_hs 1.x_fam) label varlabels(_cons Constant)  ///
		refcat(2.x_race "01 White" 2.x_inc "01 Low Income" 2.x_hs "01 Homeowner" 2.x_fam "01 Less Familiar") ///
	  mtitles("Fee 1-100" "Fee 101-250" "Fee 251-500") legend ///
		title("Relative risks ratios of the cancellation fees multinomial logistic regression model (reference group: neutral")


eststo clear


