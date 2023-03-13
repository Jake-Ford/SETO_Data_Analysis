
*===============================================================================
* Perform descriptive analyses and create descriptive graphs
*===============================================================================

	*** EDIT REQUIRED: *********************************************************
	* The name of the file will need to be changed from "QUALTRICS" to the final
	* dataset name when the community group survey data is added

	use "$output/QUALTRICS_survey_data_all.dta", clear
	****************************************************************************
	
	*===========================================================================
	* SURVEY DURATION
	*===========================================================================
	
		* Calculate survey duration in minutes based on survey duration in seconds
		destring duration_sec, replace 
		gen duration_min = .
		order duration_min, after(duration_sec)
		replace duration_min = duration_sec/60
		
		* Check the summary stats for survey duration in minutes
		codebook duration_min if review_order==1
		sum duration_min if review_order==1, d 

		* Categorize into groups based on survey duration in minutes
		gen duration_cat = ""
		order duration_cat, after(duration_min)
		replace duration_cat = "01 Less than 5 minutes"  if duration_min<5
		replace duration_cat = "02 5 to 15 minutes"		 if duration_min>=5  & duration_min<15
		replace duration_cat = "03 15 to 30 minutes"	 if duration_min>=15 & duration_min<30
		replace duration_cat = "04 More than 30 minutes" if duration_min>=30
		tab duration_cat if review_order==1
		encode duration_cat, gen(duration_cat_e)
		order duration_cat_e, after(duration_cat)
				
		
		*-----------------------------------------------------------------------
		* GRAPH: Survey duration categories (All respondents)
		*-----------------------------------------------------------------------
		#delimit;
			hist duration_cat_e if review_order==1 
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Survey Duration}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Less than 5 min." 2 "5 to 15 min." 3 "15 to 30 min." 4 "More than 30 min.", notick labsize(2.3) format(%3.0fc)) 
			xtitle(" " "Survey Duration (Minutes)", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 001 - Survey Duration.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* HOUSEHOLD SIZE
	*===========================================================================
	
		* Check the breakdown of household size overall
		tab hhsize if review_order==1
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Household size (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist hhsize if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q248: Respondent Household Size}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8 or more", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Number of People in Household", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 002 - Household Size.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* RESPONDENT STATE OF RESIDENCE
	*===========================================================================
		
		* Check the state breakdown overall
		tab state if review_order==1
		encode state, gen(state_e)
		order state_e, after(state)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: State of Residence (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist state_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Respondent State of Residence}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "California" 2 "Colorado" 3 "Illinois" 4 "Massachusetts" 5 "Maryland" 6 "Minnesota" 7 "New York" 8 "Oregon", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "State", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 003 - State of Residence.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* HOUSING STATUS AND DURATION
	*===========================================================================
		
		* Check housing type and duration summary stats
		tab housing if review_order==1
		tab housing_duration if review_order==1
		tab housing_duration housing if review_order==1

			* Housing type breakdown overall
			tab housing if review_order==1
			* Housing type breakdown among non-speeders 
			tab housing if review_order==1 & duration_cat!="01 Less than 5 minutes"

		* Add numbers to the responses so they are ordered
		replace housing = "01 Homeowner" if housing=="Homeowner"
		replace housing = "02 Renter"	 if housing=="Renter"

		*** EDIT REQUIRED: *****************************************************
		* Create a "Title" variable to use in the graph, which includes the share
		* of respondents who reported being homeowners vs. renters
		* This will need to be updated once adding the community group respondents, 
		* and will need to be updated based on whether we are graphing all respondents
		* or only non-speeder respondents
		************************************************************************
		tab housing if duration_cat!="01 Less than 5 minutes"
		gen housing_title = housing
		order housing_title, after(housing)
		replace housing_title = "Homeowners (56% of Respondents)"	if housing=="01 Homeowner"
		replace housing_title = "Renters (44% of Respondents)"		if housing=="02 Renter"
		
		* Add numbers to housing duration variable so they are ordered 
		replace housing_duration = "01 Less than a year" 	if housing_duration=="Less than a year"
		replace housing_duration = "02 1-2 years"		 	if housing_duration=="1-2 years"
		replace housing_duration = "03 3-10 years"		 	if housing_duration=="3-10 years"
		replace housing_duration = "04 More than 10 years"	if housing_duration=="More than 10 years"		
		encode housing_duration, gen(housing_duration_e)
		order housing_duration_e, after(housing_duration)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Housing duration (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist housing_duration_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(housing_title, 
				legend(off) 
				title("{bf:Q03 and Q05: Duration in Current Residence by Housing Type}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("")
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "< 1 year" 2 "1-2 years" 3 "3-10 years" 4 "> 10 years", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Housing Duration", size(2.3))
			
			color(black) lwidth(none)
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 004 - Housing Duration by Type.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* HOUSEHOLD INCOME
	*===========================================================================
		
		* Check household income summary stats 
		tab household_inc if review_order==1
		encode household_inc, gen(household_inc_e)
		order household_inc_e, after(household_inc)
		
		* Create a household income variable consisting of three categories 
		gen household_inc3 = ""
		order household_inc3, after(household_inc)
		replace household_inc3 = "01 < 50% AMI"  if inlist(household_inc_e,1,2)
		replace household_inc3 = "02 50-80% AMI" if inlist(household_inc_e,3,4)
		replace household_inc3 = "03 > 120%"	   if inlist(household_inc_e,5)
		encode household_inc3, gen(household_inc3_e)
		order household_inc3_e, after(household_inc3)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Household income (5 categories) (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist household_inc_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q224: Reported Household Income (5 Groups)}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "< 30% AMI" 2 "30-50% AMI" 3 "50-80% AMI" 4 "80-120% AMI" 5 "> 120% AMI", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Income Group", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 005a - Household Income (5 Groups).png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		*-----------------------------------------------------------------------
		* GRAPH: Household income (3 categories) (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist household_inc3_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q224: Reported Household Income (3 Groups)}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "< 50% AMI" 2 "50-120% AMI" 3 "> 120% AMI", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Income Group", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 005b - Household Income (3 Groups).png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* RESPONDENT GENDER
	*===========================================================================

		* Check gender summary stats 
		tab gender if review_order==1, m 
		
		* Create a new gender variable that's just male, female, and other 
		gen gender2 = gender 
		order gender2, after(gender)
		replace gender2 = "Other" if gender2=="Unknown"
		tab gender2, m 		
		encode gender2, gen(gender_e)
		order gender_e, after(gender2)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Gender (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist gender_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q50: Respondents' Reported Gender}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Female" 2 "Male" 3 "Other", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Gender", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Note:} The {it:Other} category includes respondents who indicated being transgender, selected multiple genders, or opted not to share their gender.", size(1.8))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 006 - Gender.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* RACE / ETHNICITY
	*===========================================================================
		
		* Check race/ethnicity summary stats
		tab race_eth if review_order==1, m 
		
		* Recode race/ethnicity to order the categories and combine native/indigenous category
		replace race_eth = "01 Asian" 						if race_eth=="Asian"
		replace race_eth = "02 Black or African American"	if race_eth=="Black or African American"
		replace race_eth = "03 Hispanic or Latino"			if race_eth=="Hispanic or Latino"
		replace race_eth = "04 Native"						if inlist(race_eth,"Native American or Alaskan Native","Native Hawaiian or Pacific Islander")
		replace race_eth = "05 White"						if race_eth=="White"
		replace race_eth = "06 Multiracial"					if race_eth=="Multiracial"
		replace race_eth = "07 Other"						if race_eth=="Other"
		tab race_eth, m 
		encode race_eth, gen(race_eth_e)
		order race_eth_e, after(race_eth)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Race / ethnicity (Non-speeders)
		*-----------------------------------------------------------------------
		#delimit;
			hist race_eth_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q51: Respondents' Reported Race/Ethnicity}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Asian" 2 "Black" 3 "Latinx" 4 "Indigenous" 5 "White" 6 "Multiracial" 7 "Other", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Race/Ethnicity", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Notes:}" 
				"[1] The {it:Asian} category includes respondents who only selected the {it:Asian} option." 
				"[2] The {it:Black} category includes respondents who only selected the {it:Black or African American} option." 
				"[3] The {it:Latinx} category includes respondents who only selected the {it:Hispanic or Latino} option." 
				"[4] The {it:Indigenous} category includes respondents who only selected either the {it:Native American or Alaska Native} option or the {it:Native Hawaiian or Pacific Islander} option."
				"[5] The {it:White} category includes respondents who only selected the {it:White} option."
				"[6] The {it:Multiracial} category includes respondents who selected more than one option."
				"[7] The {it:Other} category includes respondents who only selected the {it:Other} option.", size(1.5))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 007 - Race Ethnicity.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* COMMUNITY TYPE (URBAN, SUBURBAN, RURAL)
	*===========================================================================

		* Check community type summary stats
		tab community_type if review_order==1, m 
		
		* Recode community type to order and make more concise 
		replace community_type = "01 Urban" 	if community_type=="City or Urban Community"
		replace community_type = "02 Suburban"	if community_type=="Rural Community"
		replace community_type = "03 Rural" 	if community_type=="Suburban Community"
		encode community_type, gen(community_type_e)
		order community_type_e, after(community_type)
		tab community_type_e, m 
		
		* Create a full state time to be used in graph titles
		gen state2 = state 
		order state2, after(state)
		replace state2 = "California" 		if state=="CA"
		replace state2 = "Colorado" 		if state=="CO"
		replace state2 = "Illinois" 		if state=="IL"
		replace state2 = "Massachusetts" 	if state=="MA"
		replace state2 = "Maryland" 		if state=="MD"
		replace state2 = "Minnesota" 		if state=="MN"
		replace state2 = "New York" 		if state=="NY"
		replace state2 = "Oregon" 			if state=="OR"
		
		*** TO DO: *************************************************************
		* MERGE ON CENSUS OR OTHER OFFICIAL ZIP CODE DATA TO USE THAT COMMUNITY 
		* TYPE INFORMATION INSTEAD OF SELF-REPORTED INFORMATION
		* THE NUMBER OF SUBURBAN RESPONDENTS IS LOWER THAN EXPECTED
		
		* https://www.hrsa.gov/rural-health/about-us/definition/index.html
		* https://www2.census.gov/geo/docs/maps-data/data/rel/ua_zcta_rel_10.txt
		* https://www2.census.gov/geo/pdfs/maps-data/data/rel/explanation_ua_zcta_rel_10.pdf
		************************************************************************
		
		merge m:1 zip using "$temp/urban_rural_zips.dta"
		drop if _m==2
		tab _m, m
		br 
		
		tab community_type area_cat if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		tab community_type if review_order==1 & duration_cat!="01 Less than 5 minutes", sum(pct_in_ua)
		tab community_type if review_order==1 & duration_cat!="01 Less than 5 minutes", sum(pct_in_uc)
		tab community_type if review_order==1 & duration_cat!="01 Less than 5 minutes", sum(pct_in_rural)
		
		* In zip codes that the census bureau classifies as 100% rural, what did people report?
		tab community_type if pct_in_rural==100
		/*		
			Q52-1: What type of |
				 community best |
			describes where you |
						  live? |      Freq.     Percent        Cum.
		------------------------+-----------------------------------
					   01 Urban |          8       11.43       11.43
					02 Suburban |         48       68.57       80.00
					   03 Rural |         14       20.00      100.00
		------------------------+-----------------------------------
						  Total |         70      100.00
		*/
		
		* In zip codes that the census bureau classifies as 100% urbanized area, what did people report?
		tab community_type if pct_in_ua==100
		/*
			Q52-1: What type of |
				 community best |
			describes where you |
						  live? |      Freq.     Percent        Cum.
		------------------------+-----------------------------------
					   01 Urban |        888       57.00       57.00
					02 Suburban |         24        1.54       58.54
					   03 Rural |        646       41.46      100.00
		------------------------+-----------------------------------
						  Total |      1,558      100.00
		*/
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Community type (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist community_type_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q52: Type of Community Where Respondent Lives}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Urban" 2 "Suburban" 3 "Rural", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Community Type", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note(" ", size(1.8))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 008a - Community Type.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
	
		*-----------------------------------------------------------------------
		* GRAPH: Community type by state (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist community_type_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(state2, 
				cols(4)
				legend(off) 
				title("{bf:Q52: Type of Community Where Respondent Lives}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("")
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Urban" 2 "Suburban" 3 "Rural", notick labsize(2.3) format(%3.0fc))
			xtitle(" " "Community Type", size(2.3))
			
			color(black) lwidth(none)
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 008b - Community Type by State.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* LANGUAGE SPOKEN AT HOME
	*===========================================================================

		* Check language summary stats 
		tab lang_home if review_order==1, m 
		tab lang_which if review_order==1, m 

		*** EDIT REQUIRED: *****************************************************
		* Create a language category variable to summarize approximate origins
		* of respondents and their languages spoken 
		* THIS WHOLE CATEGORIZATION SECTION WILL NEED TO BE UPDATED WHEN COMMUNITY
		* GROUP SURVEYS ARE ADDED
		************************************************************************
		
		gen lang_cat = ""
		order lang_cat, after(lang_which)
		
		* Spanish
		replace lang_cat = "01 Spanish"					if lang_which=="soanish"
		replace lang_cat = "01 Spanish"					if lang_which=="spain"
		replace lang_cat = "01 Spanish"					if lang_which=="spanish"
		
		* Chinese
		replace lang_cat = "02 Chinese" 				if lang_which=="cantonese"
		replace lang_cat = "02 Chinese" 				if lang_which=="chinese"
		replace lang_cat = "02 Chinese" 				if lang_which=="chinese cantonese"
		replace lang_cat = "02 Chinese" 				if lang_which=="chinesse"
		replace lang_cat = "02 Chinese"					if lang_which=="mandarin"
		
		* Southeast Asian 
		replace lang_cat = "03 Southeast Asian"			if lang_which=="khmer"
		replace lang_cat = "03 Southeast Asian"			if lang_which=="laos"
		replace lang_cat = "03 Southeast Asian"			if lang_which=="thai"
		replace lang_cat = "03 Southeast Asian"			if lang_which=="vietnamese"
		replace lang_cat = "03 Southeast Asian"			if lang_which=="vietnamese and cambodian"
		replace lang_cat = "03 Southeast Asian"			if lang_which=="vietnamsese"
		
		* Filipino (= Southeast Asian for now)
		replace lang_cat = "03 Southeast Asian" 		if lang_which=="filipino"
		replace lang_cat = "03 Southeast Asian" 		if lang_which=="tagalog"
		replace lang_cat = "03 Southeast Asian" 		if lang_which=="tagalog and ilocano"
		replace lang_cat = "03 Southeast Asian" 		if lang_which=="tagalog or ilonggo"
		
		* South Asian 
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="bengali"
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="gujarati"
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="hindi"
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="nepali"
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="punjabi"
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="tamil"
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="teligu"
		replace lang_cat = "04 Indian Subcontinent" 	if lang_which=="telugu"
		replace lang_cat = "04 Indian Subcontinent"		if lang_which=="urdu"
		
		* Unknown / Unclear
		replace lang_cat = "06 Unknown" 			if lang_which=="ben6"
		replace lang_cat = "06 Unknown" 			if lang_which=="english"
		replace lang_cat = "06 Unknown"				if lang_which=="fidjdtu"
		replace lang_cat = "06 Unknown"				if lang_which=="great"
		replace lang_cat = "06 Unknown"				if lang_which=="health care"
		replace lang_cat = "06 Unknown" 			if regexm(lang_which,"i don")
		replace lang_cat = "06 Unknown"				if lang_which=="na"
		replace lang_cat = "06 Unknown"				if lang_which=="yes"

		* Western European (= Other for now)
		replace lang_cat = "05 Other"		if lang_which=="french"
		replace lang_cat = "05 Other"		if lang_which=="german"
		replace lang_cat = "05 Other"		if lang_which=="italian"
		replace lang_cat = "05 Other"		if lang_which=="portuguese"
		
		* Eastern European (= Other for now)
		replace lang_cat = "05 Other" 		if lang_which=="bulgarian"
		replace lang_cat = "05 Other" 		if lang_which=="romanian, hungarian"
		replace lang_cat = "05 Other" 		if lang_which=="russian"
		replace lang_cat = "05 Other" 		if lang_which=="serbian"

		* Other East Asian (= Other for now)
		replace lang_cat = "05 Other"		if lang_which=="japanese"
		replace lang_cat = "05 Other"		if lang_which=="korean"
		replace lang_cat = "05 Other"		if lang_which=="sometimes japonese"
		
		* Other
		replace lang_cat = "05 Other" 		if lang_which=="creole"
		replace lang_cat = "05 Other"		if lang_which=="farsi"
		replace lang_cat = "05 Other"		if lang_which=="greek"
		replace lang_cat = "05 Other"		if lang_which=="jamaican"
		replace lang_cat = "05 Other"		if lang_which=="sign language"
		replace lang_cat = "05 Other"		if lang_which=="turkish"

		* Southern African and Western African (= Other for now)
		replace lang_cat = "05 Other"		if lang_which=="nyanja, bemba"
		replace lang_cat = "05 Other"		if lang_which=="twi"
		replace lang_cat = "05 Other"		if lang_which=="yoruba"
		
		* Multiple languages that fall in different geographic categories 
		replace lang_cat = "05 Other" 		if lang_which=="chinese and japanese"
		replace lang_cat = "05 Other" 		if lang_which=="chinese/spanish"
		replace lang_cat = "05 Other" 		if lang_which=="dutch/ spanish"
		replace lang_cat = "05 Other"		if lang_which=="japanese and spanish"
		replace lang_cat = "05 Other"		if regexm(lang_which,"spanish, french, italian, german, ibi")
		replace lang_cat = "05 Other"		if lang_which=="russian armenian franch"
		replace lang_cat = "05 Other"		if lang_which=="russian in spanish"
		replace lang_cat = "05 Other"		if lang_which=="serbian,  russian and  french"
		replace lang_cat = "05 Other"		if lang_which=="some italian and some spanish"
		
		* List of languages included in the "Other" category, formatted to include
		* in the graph's notes:
		/*Armenian, Bemba, Bulgarian, unspecified Creole, Dutch, Farsi, French, 
		German, Greek, Hungarian, Italian, Jamaican, Japanese, Korean, Nyanja, 
		Portugese, Romanian, Russian, Serbian, unspecified Sign Language, Turkish, 
		Twi, Yoruba*/
		
		* Double check language category classification
		count if review_order==1 & duration_cat!="01 Less than 5 minutes"
		tab lang_cat if lang_home=="Yes" & review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		di 222/1093
		encode lang_cat, gen(lang_cat_e)
		order lang_cat_e, after(lang_cat)
		
		*** EDIT REQUIRED: *****************************************************
		* The notes of this graph will need to be updated to reflec the final sample
		* *i.e., dropping speeders and/or adding community group respondents 
		************************************************************************
		
		*-----------------------------------------------------------------------
		* GRAPH: Language categories
		*-----------------------------------------------------------------------
		#delimit;
			hist lang_cat_e if review_order==1 & lang_home=="Yes" & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q53: Languages Other Than English Spoken at Home}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Spanish" 2 "Chinese" 3 "SE Asian" 4 "S Asian" 5 "Other" 6 "Unknown", notick labsize(2.1) format(%3.0fc))
			xtitle(" " "Language Category", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Notes:}" 
				"[1] Of the 1,093 non-speeding Qualtrics respondents, 222 (20.3%) indicated speaking a language other than English at home." 
				"[2] Languages were grouped by their geographic origin until the group accounted for at least 5% of the responses. Language groups that accounted for less than 5% of" 
				"     responses were grouped into the {it:Other} category."
				"[3] The {it:Spanish} category includes respondents who only listed Spanish in the open response." 
				"[4] The {it:Chinese} category includes respondents who listed either Mandarin or Cantonese in the open response." 
				"[5] The {it:SE Asian} category includes respondents who listed Laos, Khmer, Thai, Vietnamese, or a Filipino language in the open response (Filipino/Tagalog, Ilocano, Ilonggo)."
				"[6] The {it:S Asian} category includes respondents who listed a language from the Indian Subcontinent in the open response (Bengali, Gujarati, Hindi, Nepali, Punjabi, Tamil," 
				"     Telugu, Urdu)."
				"[7] The {it:Other} category includes respondents who listed multiple languages in the open response, or a language that didn't fall into one of the categories meeting the 5%"
				"     threshold (Armenian, Bemba, Bulgarian, unspecified Creole, Dutch, Farsi, French, German, Greek, Hungarian, Italian, Jamaican, Japanese, Korean, Nyanja, Portugese," 
				"     Romanian, Russian, Serbian, unspecified Sign Language, Turkish, Twi, Yoruba)."
				"[8] The {it:Unknown} category includes respondents who did not fill in the open response or provided a response that was not a clearly identifiable language.", size(1.5))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 009 - Languages Spoken.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* GOVERNMENT PROGRAM PARTICIPATION
	*===========================================================================
		
		* Check summary stats for government program participation 
		tab govt_prog if review_order==1, m 
		
		* Create a new variable that lumps together anyone who selected more 
		* than one program, and lumps together similar programs with very few 
		* participants 
		gen govt_prog2 = govt_prog
		order govt_prog2, after(govt_prog)
		replace govt_prog2 = "Multiple" if regexm(govt_prog2,",")
		replace govt_prog2 = "01 None"						if govt_prog2=="None of the above"
		replace govt_prog2 = "02 Multiple"					if govt_prog2=="Multiple"
		replace govt_prog2 = "03 Social Security"			if govt_prog2=="Social Security"
		replace govt_prog2 = "04 Medicaid"					if govt_prog2=="Medicaid"
		replace govt_prog2 = "05 Food-Related Program"		if inlist(govt_prog2,"SNAP (or Food Stamps)") | regexm(govt_prog2,"School Breakfast/Lunch")
		replace govt_prog2 = "06 Energy-Related Program" 	if inlist(govt_prog2,"A State Reduced Energy Cost Program","Fuel Fund/Assistance (LIHEAP)","State Energy Efficiency Program")
		replace govt_prog2 = "07 Other"						if inlist(govt_prog2,"Other","HeadStart","Public Housing")
		replace govt_prog2 = "08 Unsure"					if inlist(govt_prog2,"Not Sure")
		tab govt_prog2, m 
		
		* Create a new variable that breaks down government program participation 
		* into three categories: "None", "At Least One", or "Unsure"
		gen govt_prog3 = govt_prog2
		order govt_prog3, after(govt_prog2)
		replace govt_prog3 = "02 At Least One" if inlist(govt_prog3,"02 Multiple","03 Social Security","04 Medicaid","05 Food-Related Program","06 Energy-Related Program","07 Other")
		replace govt_prog3 = "03 Unsure"	   if inlist(govt_prog3,"08 Unsure")
		tab govt_prog3, m 
		
		* Encode new variables so they can be graphed in a histogram 
		encode govt_prog2, gen(govt_prog2_e)
		order govt_prog2_e, after(govt_prog2)
		encode govt_prog3, gen(govt_prog3_e)
		order govt_prog3_e, after(govt_prog3)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Government program participation (Less aggregated categories) (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist govt_prog2_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q54: Government Program Participation (Disaggregated Categories)}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "None" 2 "Multiple" 3 "Social Security" 4 "Medicaid" 5 "Food Program" 6 "Energy Program" 7 "Other" 8 "Unsure", notick labsize(2.0) format(%3.0fc))
			xtitle(" " "Type of Government Program", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Notes:}" 
				"[1] The {it:None} category includes respondents who indicated the {it:None of the above} option." 
				"[2] The {it:Multiple} category includes respondents who checked more than one of the listed programs."
				"[3] The {it:Social Security} category includes respondents who only checked the {it:Social Security} option."
				"[4] The {it:Medicaid} category includes respondents who only checked the {it:Medicaid} option." 
				"[5] The {it:Food Program} category includes respondents who checked only the {it:SNAP (or Foods Stamps)} option or only the {it:School Breakfast/Lunch} option."
				"[6] The {it:Energy Program} category includes respondents who checked only one of the following options: {it:A State Reduced Energy Cost Program}, {it:Fuel Fund/Assistance (LIHEAP)}," 
				"     or {it:State Energy Efficiency Program}."
				"[7] The {it:Other} category includes respondents who checked only one of the following options: {it:HeadStart}, {it:Public Housing}, or {it:Other}."
				"[8] The {it:Unsure} category includes respondents who only checked the {it:Not Sure} option.", size(1.5))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 010a - Government Programs (Disagg).png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------

		*-----------------------------------------------------------------------
		* GRAPH: Government program participation (More aggregated categories) (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist govt_prog3_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q54: Government Program Participation (Aggregated Categories)}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "None of the Listed Programs" 2 "At Least One of the Listed Programs" 3 "Unsure", notick labsize(2.0) format(%3.0fc))
			xtitle(" " "Level of Participation", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note(" ", size(1.5))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 010b - Government Programs (Agg).png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		*/
		
		tab govt_prog if household_inc=="5: More than 120% AMI" & review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		di 343-208
		di 208/343
		di 62/343
		di 73/343
		di 343-208-62
		di 62/135
		di 135+208
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Government program participation (More aggregated categories) by household income (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist govt_prog3_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(household_inc, 
				cols(5)
				legend(off) 
				title("{bf:Q54 and Q224: Government Program Participation by Level of Household Income}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note(" " 
					 "{bf:Note:} Of the 343 non-speeding Qualtrics respondents who reported being in the {it:More than 120% AMI} household income category, 208 (60.6%) reported that they were not in any of" 
					 "the listed government programs, 62 (18.1%) reported that they were only enrolled in Social Security, and the remaining 73 (21.3%) reported being in some other combination of at least" 
					 "one of the listed government programs.", size(1.5))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "None" 2 "1+" 3 "Unsure", notick labsize(2.0) format(%3.0fc))
			xtitle(" " "Level of Participation", size(2.3))
			
			color(black) lwidth(none)
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 010c - Government Programs by Income.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* ELECTRICITY BILLS
	*===========================================================================
		
		*** TO DO: *************************************************************
		* CHECK THESE VARIABLES MORE CLOSELY AND DECIDE ON A FINAL METHOD FOR 
		* RECODING THEM OR NOT. 
		************************************************************************
		
		* If you are a renter, are electricity costs included in your rent payments?
		tab elec_incl_rent if review_order==1, m 
		tab elec_incl_rent housing if review_order==1, m
		
		* Recode respondents to "Unsure" if they answered inconsistently about whether
		* or not they are a renter
		replace elec_incl_rent = "Unsure" if elec_incl_rent=="I am not a renter" & housing=="02 Renter"
		tab elec_incl_rent housing, m
		tab housing if review_order==1
		
		* Order the potential values of this variable 
		replace elec_incl_rent = "01 No" 	 if elec_incl_rent=="No"
		replace elec_incl_rent = "02 Yes" 	 if elec_incl_rent=="Yes"
		replace elec_incl_rent = "03 Unsure" if elec_incl_rent=="Unsure"
		replace elec_incl_rent = "04 n/a"	 if elec_incl_rent=="I am not a renter"
		tab elec_incl_rent housing if review_order==1, m
		encode elec_incl_rent, gen(elec_incl_rent_e)
		order elec_incl_rent_e, after(elec_incl_rent)
		
		*** EDIT REQUIRED: *****************************************************
		* The notes of this graph will need to be updated to reflect the final sample
		* (i.e., dropping speeders and/or adding community group respondents, and/or 
		* re-coding any inconsitent reponses)
		************************************************************************
		
		tab housing if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		tab elec_incl_rent if review_order==1 & duration_cat!="01 Less than 5 minutes" & housing=="01 Homeowner"
		tab elec_incl_rent if review_order==1 & duration_cat!="01 Less than 5 minutes" & housing=="02 Renter"
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Is electricity bill included in rent (Renters only) (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist elec_incl_rent_e if review_order==1 & housing=="02 Renter" & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q04: Are Electricity Costs Included in Your Rent? (Renters Only)}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "No" 2 "Yes" 3 "Unsure", notick labsize(2.0) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Notes:}" 
			"[1] This graph only includes the 44.4% of non-speeding Qualtrics respondents (485 out of 1,093) who indicated being a renter." 
			"[2] Among the 55.6% of Qualtrics respondents (608 out of 1,093) who indicated being a homeowner, 15.8% (96 out of 608) selected" 
			"     {it:Yes} for this question. The remainder of those self-identifying as homeowners selected either {it:I am not a renter}, {it:No}, or {it:Unsure}." 
			"     It is not clear how to interpret the 96 of non-speeding Qualtrics respondents who both (1) identified as a homeowner, and (2) indicated"  
			"     that their {it:rent} included electricity costs.", size(1.8))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 011a - Electricity Included in Rent.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab elec_bills_who_pays, m  
		tab elec_bills_who_pays elec_incl_rent, m 
		replace elec_bills_who_pays = "01 Respondent" 							if elec_bills_who_pays=="I do"
		replace elec_bills_who_pays = "02 Respondent with Others in Household"	if regexm(elec_bills_who_pays,"It's split")
		replace elec_bills_who_pays = "03 Someone Else in Household"			if regexm(elec_bills_who_pays,"Someone else")
		replace elec_bills_who_pays = "04 Landlord"								if regexm(elec_bills_who_pays,"My landlord")
		replace elec_bills_who_pays = "05 Other"								if elec_bills_who_pays=="Other"
		replace elec_bills_who_pays = "05 Other"								if regexm(elec_bills_who_pays,"Landlord") & (elec_incl_rent=="01 No" | elec_incl_rent=="04 n/a")
		encode elec_bills_who_pays, gen(elec_bills_who_pays_e)
		order elec_bills_who_pays_e, after(elec_bills_who_pays)
		tab elec_bills_who_pays_e
		
		*** TO DO: *************************************************************
		* CHECK THESE VARIABLES MORE CLOSELY AND DECIDE ON A FINAL METHOD FOR 
		* RECODING THEM OR NOT. 
		* NOTE: There are more inconsistencies here. I haven't fixed them for now.
		************************************************************************

		tab elec_bills_who_pays_oth, m
		tab elec_incl_rent_e if review_order==1 & housing=="02 Renter" & duration_cat!="01 Less than 5 minutes"
		
		*** EDIT REQUIRED: *****************************************************
		* The notes of this graph will need to be updated to reflect the final sample
		* (i.e., dropping speeders and/or adding community group respondents, and/or 
		* re-coding any inconsitent reponses)
		************************************************************************
		
		tab elec_bills_who_pays_e if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRPAH: Who pays for your electricity (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist elec_bills_who_pays_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q14: Who Pays Your Household's Electricity Bills?}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Respondent" 2 "Respondent and Others" 3 "Others in Household" 4 "Landlord" 5 "Other", notick labsize(2.0) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Note:} In this question, 2.9% (32) of the 1,093 non-speeding Qualtrics respondents indicated that their landlord pays their electricity bills." 
			"These numbers seem inconsistent with the previous question, in which 30.1% of renters (146 out of 485) and 15.8% of homeowners" 
			"(96 out of 608) indicated that their electricity costs were included in their rent payments. Given these inconsistencies, the reliability of these" 
			"variables is questionable.", size(1.8))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 011b - Who Pays Electricity Bills.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		* Summary stats for whether respondents had missed an electricity payment 
		* in the last year 
		tab elec_bill_miss if review_order==1, m 
		replace elec_bill_miss = "01 No" 	if elec_bill_miss=="No"
		replace elec_bill_miss = "02 Yes" 	if elec_bill_miss=="Yes"
		encode elec_bill_miss, gen(elec_bill_miss_e)
		order elec_bill_miss_e, after(elec_bill_miss)
		tab elec_bill_miss_e if review_order==1, m 
		tab household_inc elec_bill_miss_e if review_order==1, m 
		
		*** EDIT REQUIRED: *****************************************************
		* The notes of this graph will need to be updated to reflect the final sample
		* (i.e., dropping speeders and/or adding community group respondents, and/or 
		* re-coding any inconsitent reponses)
		************************************************************************
		
		tab elec_bill_miss_e if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Missed electricity payments in past year by household income (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist elec_bill_miss_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(household_inc, 
				cols(5)
				legend(off) 
				title("{bf:Q96 and Q224: Missed Electricity Payments by Level of Household Income}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("{bf:Note:} Among the 1,093 non-speeding Qualtrics respondents, a total of 179 (16.4%) indicated that they had missed an electricity bill payment at some point" 
				"in the last year.", size(1.7))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "No" 2 "Yes", notick labsize(2.0) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
						
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 012 - Missed Electricity Bills by Income.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		* Summary stats for the importance of paying electricity bill 
		tab elec_bills_imp_pay, m  
		tab elec_bills_imp_pay elec_bill_miss if review_order==1, m 
		
		* Create a title for use in the graph
		*** EDIT REQUIRED: *****************************************************
		* THE PERCENTAGES HERE WILL NEED TO BE UPDATED BASED ON FINAL SAMPLE USED
		************************************************************************
		tab elec_bill_miss if review_order==1, m 
		tab elec_bill_miss if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		gen elec_bill_miss_title = elec_bill_miss
		order elec_bill_miss_title, after(elec_bill_miss_e)

		replace elec_bill_miss_title = "Did Not Miss an Electricity Payment in Last Year (84% of Resp.)" 	if elec_bill_miss=="01 No"
		replace elec_bill_miss_title = "Missed an Electricity Payment in Last Year (16% of Resp.)" 			if elec_bill_miss=="02 Yes"

		
		*-----------------------------------------------------------------------
		* GRAPH: Importance of paying electricity bill by missed payment status (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist elec_bills_imp_pay if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(elec_bill_miss_title, 
				cols(5)
				legend(off) 
				title("{bf:Q16 and Q96: Importance of Paying Electricity Bill by Missed Payment Status}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note(" ", size(1.8))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.2)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Not" 2 "Slightly" 3 "Somewhat" 4 "Very" 5 "Most", notick labsize(2.0) format(%3.0fc))
			xtitle("Importance", size(2.3))
			
			color(black) lwidth(none)
						
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 013 - Importance of Electricity Bill by Missed Payment Status.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		* Recategorize electricity bill importance variable from 5 categories to 3
		gen elec_bills_imp_pay2 = ""
		order elec_bills_imp_pay2, after(elec_bills_imp_pay)
		replace elec_bills_imp_pay2 = "01 Not Important" if inlist(elec_bills_imp_pay,1)
		replace elec_bills_imp_pay2 = "02 Less Important" if inlist(elec_bills_imp_pay,2,3)
		replace elec_bills_imp_pay2 = "03 More Important" if inlist(elec_bills_imp_pay,4,5)
		encode elec_bills_imp_pay2, gen(elec_bills_imp_pay2_e)
		order elec_bills_imp_pay2_e, after(elec_bills_imp_pay2)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Importance of paying electricity bill by household income (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist elec_bills_imp_pay2_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(household_inc, 
				cols(5)
				legend(off) 
				title("{bf:Q16 and Q224: Importance of Paying Electricity Bill by Level of Household Income}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("{bf:Notes}"
				"[1] The category {it:More Important} includes respondents who indicated either {it:Very Important} or {it:Most Important}."
				"[2] The category {it:Less Important} includes respondents who indicated either {it:Slightly Important} or {it:Somewhat Important}."
				"[3] The category {it:Not Important} includes respondents who indicated {it:Not Important}.", size(1.8))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Not Important" 2 "Less Important" 3 "More Important", notick labsize(2.0) format(%3.0fc) angle(45))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
						
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 014a - Importance of Electricity Bill by Income.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		* Summary stats for importance of paying for a services that saves you 
		* money on your electricity bill 
		tab elec_bills_imp_save, m 
		
		* Recategorize importance of service variable from 5 categories to 3 
		gen elec_bills_imp_save2 = ""
		order elec_bills_imp_save2, after(elec_bills_imp_save)
		replace elec_bills_imp_save2 = "01 Not Important" if inlist(elec_bills_imp_save,1)
		replace elec_bills_imp_save2 = "02 Less Important" if inlist(elec_bills_imp_save,2,3)
		replace elec_bills_imp_save2 = "03 More Important" if inlist(elec_bills_imp_save,4,5)
		encode elec_bills_imp_save2, gen(elec_bills_imp_save2_e)
		order elec_bills_imp_save2_e, after(elec_bills_imp_save2)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Importance of paying for service to reduce electricity bill by household income (Non-speeders only)
		*-----------------------------------------------------------------------
		#delimit;
			hist elec_bills_imp_save2_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(household_inc, 
				cols(5)
				legend(off) 
				title("{bf:Q17 and Q224: Importance of Paying Monthly Service to Save on Electricity Bill by Level of Household Income}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("{bf:Notes}"
				"[1] The category {it:More Important} includes respondents who indicated either {it:Very Important} or {it:Most Important}."
				"[2] The category {it:Less Important} includes respondents who indicated either {it:Slightly Important} or {it:Somewhat Important}."
				"[3] The category {it:Not Important} includes respondents who indicated {it:Not Important}.", size(1.8))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Not Important" 2 "Less Important" 3 "More Important", notick labsize(2.0) format(%3.0fc) angle(45))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
						
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 014b - Importance of Monthly Service to Save on Electricity Bill by Income.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
	*===========================================================================
	* PRIOR FAMILIARITY WITH COMMUNITY SOLAR / HOW THEY HEARD ABOUT COMMUNITY SOLAR
	*===========================================================================
	
		* Summary stats for familiarity with community solar 
		tab familiarity if review_order==1, m 
		
		* Recategorize the familiarity variable from 5 categories to 3
		gen familiarity2 = ""
		order familiarity2, after(familiarity)
		replace familiarity2 = "01 Not Famililar" 	if inlist(familiarity,1)
		replace familiarity2 = "02 Less Famililar" 	if inlist(familiarity,2,3)
		replace familiarity2 = "03 More Famililar"	if inlist(familiarity,4)
		tab familiarity2 if review_order==1, m 
		encode familiarity2, gen(familiarity2_e)
		order familiarity2_e, after(familiarity2)
		
		* List the open responses for how people heard about community solar 
		tab cs_how_hear if review_order==1, m
		
		* Create a new variable that categorizes open responses based on how they heard
		gen hear_cat = ""
		order hear_cat, after(cs_how_hear)
		
		* Unclear 
		
		* Total nonsense responses 
		replace hear_cat = "CHANGE" if cs_how_hear=="1"
		replace hear_cat = "CHANGE" if cs_how_hear=="2"
		replace hear_cat = "CHANGE" if cs_how_hear=="4"
		replace hear_cat = "CHANGE" if cs_how_hear=="99"
		replace hear_cat = "CHANGE" if cs_how_hear=="a little"
		replace hear_cat = "CHANGE" if cs_how_hear=="actually i am watching from other house"
		replace hear_cat = "CHANGE" if cs_how_hear=="be"
		replace hear_cat = "CHANGE" if cs_how_hear=="better"
		replace hear_cat = "CHANGE" if cs_how_hear=="bootywhole"
		replace hear_cat = "CHANGE" if cs_how_hear=="chegkct"
		replace hear_cat = "CHANGE" if cs_how_hear=="everything is fine here and there is no"
		replace hear_cat = "CHANGE" if cs_how_hear=="durable and usable"
		replace hear_cat = "CHANGE" if cs_how_hear=="hf ha she jhonatan j j u up. uhh u j. uh u jh j j j u ehjej jl path jodhpurs eeuu"
		replace hear_cat = "CHANGE" if cs_how_hear=="hi"
		replace hear_cat = "CHANGE" if cs_how_hear=="i"
		replace hear_cat = "CHANGE" if cs_how_hear=="i don't know"
		replace hear_cat = "CHANGE" if cs_how_hear=="klover"
		replace hear_cat = "CHANGE" if cs_how_hear=="na"
		replace hear_cat = "CHANGE" if cs_how_hear=="no"
		replace hear_cat = "CHANGE" if cs_how_hear=="no comment or opinion"
		replace hear_cat = "CHANGE" if cs_how_hear=="no comments"
		replace hear_cat = "CHANGE" if cs_how_hear=="none"
		replace hear_cat = "CHANGE" if cs_how_hear=="not that much"
		replace hear_cat = "CHANGE" if cs_how_hear=="nothing"
		replace hear_cat = "CHANGE" if cs_how_hear=="so cool"
		replace hear_cat = "CHANGE" if cs_how_hear=="something very nice"
		
		* Other responses that should maybe be recategorized to "Not familiar"
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"communnity solar is most important in our house")
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"know if you want to know that you are the only thing you can do for me and my")
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"t know$")
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"i think the problem of this invention")
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"gonna was the day you were gonna last week and i")
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"s good$")
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"a great means of electricity")
		replace hear_cat = "CHANGE" if cs_how_hear=="doing a survey"
		replace hear_cat = "CHANGE" if cs_how_hear=="in a surbey"
		replace hear_cat = "CHANGE" if cs_how_hear=="survey"

		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="solstice"
		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="solstice.com"

		replace hear_cat = "CHANGE" if cs_how_hear=="havent heard of it"
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"know what that is")
		replace hear_cat = "CHANGE" if cs_how_hear=="i have never hear of it before ."
		replace hear_cat = "CHANGE" if cs_how_hear=="in this survey"
		replace hear_cat = "CHANGE" if cs_how_hear=="this survey"
		
		* Somewhat on-topic responses 
		replace hear_cat = "CHANGE" if cs_how_hear=="a lot"
		replace hear_cat = "CHANGE" if cs_how_hear=="an excellent solar"
		replace hear_cat = "CHANGE" if cs_how_hear=="good"
		replace hear_cat = "CHANGE" if cs_how_hear=="good i like"
		replace hear_cat = "CHANGE" if cs_how_hear=="great"
		replace hear_cat = "CHANGE" if cs_how_hear=="great and lovely"
		replace hear_cat = "CHANGE" if cs_how_hear=="great value for money"
		replace hear_cat = "CHANGE" if cs_how_hear=="idk"
		replace hear_cat = "CHANGE" if cs_how_hear=="imvu"
		replace hear_cat = "CHANGE" if cs_how_hear=="is efficiency"
		replace hear_cat = "CHANGE" if cs_how_hear=="it is a good idea to have one"
		replace hear_cat = "CHANGE" if cs_how_hear=="it is good."
		replace hear_cat = "CHANGE" if cs_how_hear=="it is nice and perfect it is very nice"
		replace hear_cat = "CHANGE" if cs_how_hear=="it is the best perfect and reliable it is good and nice"
		replace hear_cat = "CHANGE" if cs_how_hear=="its great i like it so much"

		replace hear_cat = "CHANGE" if cs_how_hear=="supply community light"
		replace hear_cat = "CHANGE" if cs_how_hear=="sure anna garish thx guns can"
		replace hear_cat = "CHANGE" if cs_how_hear=="t"
		replace hear_cat = "CHANGE" if cs_how_hear=="that it helps"
		replace hear_cat = "CHANGE" if cs_how_hear=="the ability to provide electricity to ebey individual in the society"
		replace hear_cat = "CHANGE" if cs_how_hear=="the spread of energy in community"
		replace hear_cat = "CHANGE" if cs_how_hear=="there are many different ways that this could be done"
		replace hear_cat = "CHANGE" if cs_how_hear=="vid bing vice sell"
		replace hear_cat = "CHANGE" if regexm(cs_how_hear,"for the purpose of this guide")
		replace hear_cat = "CHANGE" if cs_how_hear=="yes"
		replace hear_cat = "CHANGE" if cs_how_hear=="yes and i see its very interesting"
		replace hear_cat = "CHANGE" if cs_how_hear=="yes good"
		replace hear_cat = "CHANGE" if cs_how_hear=="yes i will be"
		replace hear_cat = "CHANGE" if cs_how_hear=="your mom"
		replace hear_cat = "CHANGE" if cs_how_hear=="for the love of"
		
		replace hear_cat = "CHANGE" if missing(cs_how_hear) & familiarity==4
		
		replace hear_cat = "Unclear" if regexm(cs_how_hear,"community solar refers to local solar facilities")

		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="a community leader"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="a friend"
		replace hear_cat = "Friends, Family, or Acquaintances" if regexm(cs_how_hear,"among friends")
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="family"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="family and friends"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="family of friend"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="family recommendation."
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="form friend"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="friend"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="friends"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="friends and family"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="friends told me"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="from a friend"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="from a friend who is a teacher"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="from my friends"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="i hear from it from my community leaders."
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="i heard it through my roommates"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="my family talk about it"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="my friend"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="my friends"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="my friends talked about it."
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="neighbor"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="referal"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="through a friend"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="through family"
		replace hear_cat = "Friends, Family, or Acquaintances" if cs_how_hear=="word of mouth"

		replace hear_cat = "Advertisements" if cs_how_hear=="ad"
		replace hear_cat = "Advertisements" if cs_how_hear=="ads"
		replace hear_cat = "Advertisements" if cs_how_hear=="advertisement"
		replace hear_cat = "Advertisements" if cs_how_hear=="an ad"
		replace hear_cat = "Advertisements" if cs_how_hear=="commercial"
		replace hear_cat = "Advertisements" if cs_how_hear=="from ads"
		replace hear_cat = "Advertisements" if cs_how_hear=="from google adds"
		replace hear_cat = "Advertisements" if cs_how_hear=="i heard about it in television advertisement"
		replace hear_cat = "Advertisements" if cs_how_hear=="internet ads"
		replace hear_cat = "Advertisements" if cs_how_hear=="on a commercial"
		replace hear_cat = "Advertisements" if cs_how_hear=="through advertisements on television."
		replace hear_cat = "Advertisements" if cs_how_hear=="through an ad"
		replace hear_cat = "Advertisements" if cs_how_hear=="through tv ad"
		replace hear_cat = "Advertisements" if cs_how_hear=="tv"
		replace hear_cat = "Advertisements" if cs_how_hear=="tv ad."
		replace hear_cat = "Advertisements" if cs_how_hear=="tv ads"

		replace hear_cat = "Social Media" if cs_how_hear=="by social media"
		replace hear_cat = "Social Media" if cs_how_hear=="facebook"
		replace hear_cat = "Social Media" if cs_how_hear=="from social media"
		replace hear_cat = "Social Media" if cs_how_hear=="from social media ad"
		replace hear_cat = "Social Media" if cs_how_hear=="i heard on social media"
		replace hear_cat = "Social Media" if regexm(cs_how_hear,"all over my page")
		replace hear_cat = "Social Media" if cs_how_hear=="on facebook"
		replace hear_cat = "Social Media" if cs_how_hear=="on social media"
		replace hear_cat = "Social Media" if regexm(cs_how_hear,"on social media, watching")
		replace hear_cat = "Social Media" if cs_how_hear=="social media"
		replace hear_cat = "Social Media" if cs_how_hear=="social medoa"
		replace hear_cat = "Social Media" if cs_how_hear=="the social media"
		replace hear_cat = "Social Media" if cs_how_hear=="through social media"

		replace hear_cat = "Other Internet" if cs_how_hear=="app"
		replace hear_cat = "Other Internet" if cs_how_hear=="at internet"
		replace hear_cat = "Other Internet" if cs_how_hear=="email"
		replace hear_cat = "Other Internet" if cs_how_hear=="from an online forum"
		replace hear_cat = "Other Internet" if cs_how_hear=="from the internet"
		replace hear_cat = "Other Internet" if cs_how_hear=="google"
		replace hear_cat = "Other Internet" if cs_how_hear=="internet"
		replace hear_cat = "Other Internet" if cs_how_hear=="net"
		replace hear_cat = "Other Internet" if cs_how_hear=="off the internet"
		replace hear_cat = "Other Internet" if cs_how_hear=="on internet"
		replace hear_cat = "Other Internet" if cs_how_hear=="on the internet youtube"
		replace hear_cat = "Other Internet" if cs_how_hear=="online"
		replace hear_cat = "Other Internet" if cs_how_hear=="online search"
		replace hear_cat = "Other Internet" if cs_how_hear=="online website"
		replace hear_cat = "Other Internet" if cs_how_hear=="the internet"
		replace hear_cat = "Other Internet" if cs_how_hear=="web"
		replace hear_cat = "Other Internet" if cs_how_hear=="website"
		replace hear_cat = "Other Internet" if cs_how_hear=="you tube"
		replace hear_cat = "Other Internet" if cs_how_hear=="youtube"

		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="i had some pushy sales rep show up at my door pitching this idea and trying to strongarm me into signing a contract."
		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="i heard about it ,because its solar copany that served through solar"
		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="i work in utilities"
		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="sales rep in the area"
		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="sunrun representative"
		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="through sun run i wrk with solar"
		replace hear_cat = "Solar or Energy Industry" if cs_how_hear=="we currently have solar panels, so are abreast of solar information"

		replace hear_cat = "Multiple Sources" if cs_how_hear=="ads on youtube and social media and friends"
		replace hear_cat = "Multiple Sources" if cs_how_hear=="from social media and friends"
		replace hear_cat = "Multiple Sources" if cs_how_hear=="i heard about it on social media and also heard about it from my neighbor because he uses it"
		replace hear_cat = "Multiple Sources" if cs_how_hear=="through social media and blogs."
		replace hear_cat = "Multiple Sources" if cs_how_hear=="through the internet and the democrats wanting to intriduce the bill"
		replace hear_cat = "Multiple Sources" if cs_how_hear=="very well known among the people"

		replace hear_cat = "Other" if cs_how_hear=="i have done research on the subject."
		replace hear_cat = "Other" if cs_how_hear=="mail brochure"
		replace hear_cat = "Other" if cs_how_hear=="mailings"
		replace hear_cat = "Other" if cs_how_hear=="media"
		replace hear_cat = "Other" if cs_how_hear=="my coleuge talk about community solar"
		replace hear_cat = "Other" if cs_how_hear=="news"
		replace hear_cat = "Other" if cs_how_hear=="on tv shows"
		replace hear_cat = "Other" if cs_how_hear=="phone"
		replace hear_cat = "Other" if cs_how_hear=="read about in newspapers and online"
		replace hear_cat = "Other" if cs_how_hear=="read about it"
		replace hear_cat = "Other" if cs_how_hear=="research"
		replace hear_cat = "Other" if cs_how_hear=="school"
		replace hear_cat = "Other" if cs_how_hear=="they are in my neighbohood"


		tab hear_cat if review_order==1 & duration_cat!="01 Less than 5 minutes" & familiarity==4, m 
		replace familiarity    = 1 if hear_cat=="CHANGE"
		replace familiarity2_e = 1 if hear_cat=="CHANGE"
		
		tab hear_cat familiarity, m 
		tab hear_cat familiarity2_e, m 
		
		replace hear_cat = "" if hear_cat=="CHANGE"
		tab hear_cat if review_order==1 & duration_cat!="01 Less than 5 minutes" & familiarity==4, m
		replace hear_cat = "Other" if hear_cat=="Unclear"
		
		replace hear_cat = "01 Friends, Family, or Acquaintances" 	if hear_cat=="Friends, Family, or Acquaintances"
		replace hear_cat = "02 Social Media"					  	if hear_cat=="Social Media"
		replace hear_cat = "03 Other Internet"						if hear_cat=="Other Internet"
		replace hear_cat = "04 Advertisements"						if hear_cat=="Advertisements"
		replace hear_cat = "05 Solar or Energy Industry"			if hear_cat=="Solar or Energy Industry"
		replace hear_cat = "06 Other Sources"						if hear_cat=="Other"
		replace hear_cat = "07 Multiple Sources"					if hear_cat=="Multiple Sources"
		tab hear_cat if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		tab hear_cat familiarity    if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		tab hear_cat familiarity2_e if review_order==1 & duration_cat!="01 Less than 5 minutes", m 

		encode hear_cat, gen(hear_cat_e)
		order hear_cat_e, after(hear_cat)		
		
		tab hear_cat if review_order==1 & duration_cat!="01 Less than 5 minutes"
		tab cs_how_hear if review_order==1 & duration_cat!="01 Less than 5 minutes" & regexm(hear_cat,"01")
		tab cs_how_hear if review_order==1 & duration_cat!="01 Less than 5 minutes" & regexm(hear_cat,"02")
		tab cs_how_hear if review_order==1 & duration_cat!="01 Less than 5 minutes" & regexm(hear_cat,"03")
		tab cs_how_hear if review_order==1 & duration_cat!="01 Less than 5 minutes" & regexm(hear_cat,"04")
		tab cs_how_hear if review_order==1 & duration_cat!="01 Less than 5 minutes" & regexm(hear_cat,"05")
		tab cs_how_hear if review_order==1 & duration_cat!="01 Less than 5 minutes" & regexm(hear_cat,"06")
		tab cs_how_hear if review_order==1 & duration_cat!="01 Less than 5 minutes" & regexm(hear_cat,"07")
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Prior familiarity with community solar ("Very famililar" only)
		*-----------------------------------------------------------------------
		#delimit;
			hist familiarity2_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(household_inc, 
				cols(5)
				legend(off) 
				title("{bf:Q15 and Q224: Prior Familiarity With Community Solar by Level of Household Income}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("{bf:Notes}"
				"[1] The category {it:More Famililar} includes respondents who indicated {it:Very famililar}."
				"[2] The category {it:Less Famililar} includes respondents who indicated either {it:Slightly famililar} or {it:Somewhat famililar}."
				"[3] The category {it:Not Famililar} includes respondents who indicated {it:Not at all familiar}.", size(1.8))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Not Familiar" 2 "Less Familiar" 3 "More Familiar", notick labsize(2.0) format(%3.0fc) angle(45))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
						
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 015a - Familiarity with Community Solar by Income.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab hear_cat_e if review_order==1 & duration_cat!="01 Less than 5 minutes"

		*** EDIT REQUIRED: *****************************************************
		* The notes of this graph will need to be updated to reflect the final sample
		* (i.e., dropping speeders and/or adding community group respondents, and/or 
		* re-coding any inconsitent reponses)
		************************************************************************
		
		
		*-----------------------------------------------------------------------
		* GRAPH: How did you hear about community solar
		*-----------------------------------------------------------------------
		#delimit;
			hist hear_cat_e if review_order==1 & familiarity==4 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q15: How Did You Hear About Community Solar?}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Family/Friends" 2 "Social Media" 3 "Other Internet" 4 "Ads" 5 "Energy Industry" 6 "Other Sources" 7 "Multiple Sources", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Notes:}"
			"[1] This graph only includes the 134 non-speeding Qualtrics respondents who indicated being {it:Very familiar} with community solar and provided" 
			"     a sensical open-response answer to the question {it:How did you hear about community solar?}." 
			"[2] The categories on this graph were created by reviewing respondents' open-ended responses. This categorization process was very" 
			"     subjective, and there may be overlap across categories. For example, there may be overlap between {it:Family/Friends}" 
			"     and {it:Social Media} or between {it:Social Media} and {it:Other Internet}."
			"[3] The category {it:Family/Friends} includes respones such as 'family,' 'friends,' 'neighbors,' 'referrals,' 'community leaders,' or 'word of mouth.'"
			"[4] The category {it:Social Media} includes responses such as 'social media' or 'facebook.'"
			"[5] The category {it:Other Internet} includes responses such as 'internet,' 'online,' 'website,' 'email,' or 'youtube.'"
			"[6] The category {it:Ads} includes responses such as 'ads,' 'advertisements,' 'commercials,' 'tv ads,' 'google ads.'"
			"[7] The category {it:Energy Industry} includes responses such as 'Solstice,' 'SunRun,' 'sales rep,' 'I have solar panels,' or 'I work in utilities.'"
			"[8] The category {it:Other Sources} includes open-responses that did not easily fit in the above categories (e.g., 'research,' 'mail,' 'school')."
			"[9] The category {it:Multiple Sources} includes respondents who indicated more than one type of source in the open-response field."
			"[10] Respondents who indicated that they had heard from community solar from this survey or 'a survey,' gave an incorrect explanation of" 
			"       community solar, or gave a nonsensical open-response answer were recategorized from {it:Very familiar} to {it:Not familiar}.", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 015b - How Hear About Community Solar.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* IMPORTANCE OF CLIMATE CHANGE TO YOU PERSONALLY
	*===========================================================================
	
		tab climate_change 			if review_order==1, m
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Importance of climate change to you personally 
		*-----------------------------------------------------------------------
		#delimit;
			hist climate_change if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q18: Importance of Climate Change to You Personally?}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Not Important" 2 "Slightly Important" 3 "Somewhat Important" 4 "Very Important" 5 "Most Important", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 016a - Importance of Climate Change.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab climate_change if review_order==1 & duration_cat!="01 Less than 5 minutes"
		gen climate_change2 = ""
		order climate_change2, after(climate_change)
		replace climate_change2 = "03 More Important" if inlist(climate_change,4,5)
		replace climate_change2 = "02 Less Important" if inlist(climate_change,2,3)
		replace climate_change2 = "01 Not Important"  if inlist(climate_change,1)
		encode climate_change2, gen(climate_change2_e)
		order climate_change2_e, after(climate_change2)
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Importance of Climate Change by Household Income
		*-----------------------------------------------------------------------
		#delimit;
			hist climate_change2_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(household_inc, 
				cols(5)
				legend(off) 
				title("{bf:Q18 and Q224: Importance of Climate Change to You Personally by Level of Household Income}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("{bf:Notes}"
				"[1] The category {it:More Important} includes respondents who indicated {it:Very important} or {it:Most important}."
				"[2] The category {it:Less Important} includes respondents who indicated either {it:Slightly important} or {it:Somewhat important}."
				"[3] The category {it:Not Important} includes respondents who indicated {it:Not important}.", size(1.8))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Not Important" 2 "Less Important" 3 "More Important", notick labsize(1.9) format(%3.0fc) angle(45))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
						
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 016b - Importance of Climate Change by Income.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------

		*-----------------------------------------------------------------------
		* GRAPH: Importance of Climate Change by State
		*-----------------------------------------------------------------------
		#delimit;
			hist climate_change2_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			by(state2, 
				cols(4)
				legend(off) 
				title("{bf:Q18: Importance of Climate Change to You Personally by State}", color(black) size(2.5)) 
				subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.2))
				graphregion(fcolor(white) color(white))
				plotregion(fcolor(white) ilcolor(white))
				note("{bf:Notes}"
				"[1] The category {it:More Important} includes respondents who indicated {it:Very important} or {it:Most important}."
				"[2] The category {it:Less Important} includes respondents who indicated either {it:Slightly important} or {it:Somewhat important}."
				"[3] The category {it:Not Important} includes respondents who indicated {it:Not important}.", size(1.8))
			  )
			
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			subtitle(, color(black) size(2.4)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Not Important" 2 "Less Important" 3 "More Important", notick labsize(1.9) format(%3.0fc) angle(45))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
						
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 016c - Importance of Climate Change by State.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* AGREE/DISAGREE QUESTIONS RELATED TO COMMUNITY SOLAR PREFERENCES
	*===========================================================================

		tab cs_solution_climate					if review_order==1 & duration_cat!="01 Less than 5 minutes", m
		tab cs_solution_climate	climate_change2	if review_order==1 & duration_cat!="01 Less than 5 minutes", m
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Community Solar Possible Solution to Climate Change 
		*-----------------------------------------------------------------------
		#delimit;
			hist cs_solution_climate if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q31-1: Community Solar is a Possible Solution to Climate Change}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 017 - Community Solar Solution to Climate Change.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------

		tab participate_savings 	if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: Would Participate Primarily bc of Electricity Bill Savings 
		*-----------------------------------------------------------------------
		#delimit;
			hist participate_savings if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q31-3: Would Participate Primarily Because of Electricity Bill Savings}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 018 - Participate bc of Electricity Bill Savings.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------

		tab participate_environ 	if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: Would Participate Primarily bc of Environment 
		*-----------------------------------------------------------------------
		#delimit;
			hist participate_environ if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q31-4: Would Participate Primarily Because of the Environment}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 019 - Participate bc of Environment.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab program_jobs 			if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: More Like to Sign Up for Program that Creates Jobs 
		*-----------------------------------------------------------------------
		#delimit;
			hist program_jobs if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q57-1: More Likely to Sign Up if Program Creates Jobs in My Community}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 020 - Sign Up More Likely bc of Jobs.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab program_garden_comm 	if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: More Like to Sign Up for Program with Solar Garden in My Community 
		*-----------------------------------------------------------------------
		#delimit;
			hist program_garden_comm if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q57-2: More Likely to Sign Up if Solar Garden Located in My Community}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 021 - Sign Up More Likely bc of Solar Garden in Community.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab program_battery 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: More Like to Sign Up for Program with Solar Garden in My Community 
		*-----------------------------------------------------------------------
		#delimit;
			hist program_battery if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q57-3: More Likely to Sign Up for Program with Battery Storage}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 022 - Sign Up More Likely bc of Battery Storage.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab utility_small_fee 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: Support Utility Applying a Small Fee to Fund Community Solar  
		*-----------------------------------------------------------------------
		#delimit;
			hist utility_small_fee if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q226-1: Would Support My Utility Applying a Small Fee to Fund Community Solar}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 023 - Support Utility Applying Small Fee to Fund Community Solar.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab single_bill 			if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: More Like to Sign Up for Program with Solar Garden in My Community 
		*-----------------------------------------------------------------------
		#delimit;
			hist single_bill if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q226-2: Important to Me to Pay a Single Bill per Month for My Electricity}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 024 - Important to Pay Single Monthly Electricity Bill.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab prefer_solar 			if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: Prefer Solar/Clean Energy over Current Source  
		*-----------------------------------------------------------------------
		#delimit;
			hist prefer_solar if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q226-3: Prefer Solar or Clean Energy Over Current Source Provided by My Utility}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 025 - Prefer Solar or Clean Energy.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab program_run_util 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: More Confident in Program if Led by My Electric Utility   
		*-----------------------------------------------------------------------
		#delimit;
			hist program_run_util if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q58-2: Feel More Confident in Program if Led by My Electric Utility}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 026 - More Confident if Utility Leads Program.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab program_run_govt 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: More Confident in Program if Led by My Electric Utility   
		*-----------------------------------------------------------------------
		#delimit;
			hist program_run_govt if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q58-3: Feel More Confident in Program if Led by My Local Government}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 027 - More Confident if Local Govt Leads Program.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab program_run_nonprof 	if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: More Confident in Program if Led by My Electric Utility   
		*-----------------------------------------------------------------------
		#delimit;
			hist program_run_nonprof if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q58-4: Feel More Confident in Program if Led by a Non-Profit in My Community}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 028 - More Confident if Community Non-Profit Leads Program.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab credit_score 			if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: Less Interested if Credit Score Required  
		*-----------------------------------------------------------------------
		#delimit;
			hist credit_score if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q225-1: Less Interested if Required to Provide Credit Score}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 029 - Less Interested if Credit Score Required.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		tab covid19 				if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*-----------------------------------------------------------------------
		* GRAPH: COVID-19 Impacted Ability to Make Electricity Payments 
		*-----------------------------------------------------------------------
		#delimit;
			hist covid19 if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q225-3: COVID-19 Pandemic Impacted My Ability to Make Electricity Payments}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" 5 "Strongly Agree", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 030 - COVID-19 Impacted Electricity Payments.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
	*===========================================================================
	* PREFERRED PAYMENT TYPE
	*===========================================================================
		
		replace preferred_payment = "01 Autopay" 			if regexm(preferred_payment,"Auto-pay")
		replace preferred_payment = "02 Manual Credit Card" if preferred_payment=="Manual Credit Card Payment"
		replace preferred_payment = "03 Mail-In Check"		if preferred_payment=="Mail-In Check"
		replace preferred_payment = "04 Other"				if preferred_payment=="Other"
		encode preferred_payment, gen(preferred_payment_e)
		order preferred_payment_e, after(preferred_payment)
		
		tab preferred_payment 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		tab preferred_payment_oth	if review_order==1, m 
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Preferred Payment Method 
		*-----------------------------------------------------------------------
		#delimit;
			hist preferred_payment_e if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Q59-2: Preferred Form of Payment}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Autopay" 2 "Manual Credit Card Payment" 3 "Mail-In Check" 4 "Other", notick labsize(1.9) format(%3.0fc))
			xtitle(" ", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("  ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 031 - Preferred Payment Method.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
	*===========================================================================
	* ADDITIONAL INFO AND COMMENTS
	*===========================================================================

		tab additional_info 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		tab comments				if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		/*
		preserve
			keep additional_info review_order
			keep if !missing(additional_info) & review_order==1
			export excel using "$output/Themes for Focus Groups.xlsx", ///
				sheet("additional_info_raw") sheetreplace firstrow(variables)
		restore 
		
		preserve
			keep comments review_order
			keep if !missing(comments) & review_order==1
			export excel using "$output/Themes for Focus Groups.xlsx", ///
				sheet("comments_raw") sheetreplace firstrow(variables)
		restore 
		*/
	
	*===========================================================================
	* RANDOMIZATION OF CONTRACT TERMS AND CONTRACTS REVIEWED
	*===========================================================================
	
		tab contract_number			if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		
		*-----------------------------------------------------------------------
		* GRAPH: How many people reviewed each contract
		*-----------------------------------------------------------------------
		#delimit;
			hist contract_number if review_order==1 & duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			freq
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.0fc))
						
			width(.5)
			
			title("{bf:Number of Respondents Who Reviewed Each Contract (Randomization Check)}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(20)100, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Number of Respondents" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24, notick labsize(1.9) format(%3.0fc))
			xtitle(" " "Contract Number", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note(" ", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure XX - Number of Reviews per Contract.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab savings_rate 
		gen savings_rate2 = .
		order savings_rate2, after(savings_rate)
		replace savings_rate2 = 1 if savings_rate==5
		replace savings_rate2 = 2 if savings_rate==10
		replace savings_rate2 = 3 if savings_rate==20
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Randomization of savings rates across contract reviews
		*-----------------------------------------------------------------------
		#delimit;
			hist savings_rate2 if duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Randomization of Savings Rates Across Contract Reviews}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Contract Reviews" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "5% Savings Rate" 2 "10% Savings Rate" 3 "20% Savings Rate", notick labsize(1.9) format(%3.0fc))
			xtitle(" " "Savings Rate", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Note:} A {it:contract review} refers to a particular respondent reviewing a particular contract. There are two contract reviews per respondent.", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure XX - Randomization of Savings Rate.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab length_years
		gen length_years2 = .
		order length_years2, after(length_years)
		replace length_years2 = 1 if length_years==1
		replace length_years2 = 2 if length_years==25
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Randomization of contract durations across contract reviews
		*-----------------------------------------------------------------------
		#delimit;
			hist length_years2 if duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
				
			width(.5)
			
			title("{bf:Randomization of Contract Durations Across Contract Reviews}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Contract Reviews" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "1 Year" 2 "25 Years" 3 " ", notick labsize(1.9) format(%3.0fc))
			xtitle(" " "Contract Duration", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Note:} A {it:contract review} refers to a particular respondent reviewing a particular contract. There are two contract reviews per respondent.", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure XX - Randomization of Contract Duration (Years).png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab length_page 
		gen length_page2 = .
		order length_page2, after(length_page)
		replace length_page2 = 1 if length_page==10
		replace length_page2 = 2 if length_page==20
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Randomization of contract page lengths across contract reviews
		*-----------------------------------------------------------------------
		#delimit;
			hist length_page2 if duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
				
			width(.5)
			
			title("{bf:Randomization of Contract Page Lengths Across Contract Reviews}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Contract Reviews" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "10 Pages" 2 "20 Pages" 3 " ", notick labsize(1.9) format(%3.0fc))
			xtitle(" " "Contract Length", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Note:} A {it:contract review} refers to a particular respondent reviewing a particular contract. There are two contract reviews per respondent.", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure XX - Randomization of Contract Page Length.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab cancel_fee
		gen cancel_fee2 = .
		order cancel_fee2, after(cancel_fee)
		replace cancel_fee2 = 1 if cancel_fee==0
		replace cancel_fee2 = 2 if cancel_fee==250
		
		
		*-----------------------------------------------------------------------
		* GRAPH: Randomization of cancellation fees across contract reviews
		*-----------------------------------------------------------------------
		#delimit;
			hist cancel_fee2 if duration_cat!="01 Less than 5 minutes"
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
				
			width(.5)
			
			title("{bf:Randomization of Cancellation Fees Across Contract Reviews}", color(black) size(2.5)) 
			subtitle("Qualtrics Data Only (Speeders Removed)", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Contract Reviews" " ", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "None" 2 "$250" 3 " ", notick labsize(1.9) format(%3.0fc))
			xtitle(" " "Cancellation Fee", size(2.3))
			
			color(black) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			note("{bf:Note:} A {it:contract review} refers to a particular respondent reviewing a particular contract. There are two contract reviews per respondent.", size(1.9))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure XX - Randomization of Cancellation Fees.png", as(png) height(5000) replace
		*-----------------------------------------------------------------------
		*-----------------------------------------------------------------------
		
		
		tab enough_info 			if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		
		*** TO DO: WHAT IS THE DIFFERENCE BETWEEN THESE? IS THERE AN ERROR HERE?
		tab program_savings 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		tab confident_program 		if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
	
	*===========================================================================
	* HOW MUCH OF THE CONTRACT WAS REVIEWED
	*===========================================================================
		
		tab review, m 
		replace review = "01 One page or less" 					if review=="One page or less"
		replace review = "02 More than page but less than half" if regexm(review,"Less than half")
		replace review = "03 More than half but less than all"	if regexm(review,"More than half")
		replace review = "04 Entire contract"					if review=="Whole contract"
		tab review, m
		
		tab review if review_order==1 & duration_cat!="01 Less than 5 minutes", m 
		tab review if review_order==2 & duration_cat!="01 Less than 5 minutes", m 
		tab review if duration_cat!="01 Less than 5 minutes", m 
		
	*===========================================================================
	* HOW MUCH OF THE CONTRACT WAS UNDERSTOOD
	*===========================================================================

		tab understand if duration_cat!="01 Less than 5 minutes", m
		
		tab understand if review_order==1 & duration_cat!="01 Less than 5 minutes", m
		tab understand if review_order==2 & duration_cat!="01 Less than 5 minutes", m
	
	*===========================================================================
	* WILLINGESS TO SIGN UP FOR CONTRACT REVIEWED 
	*===========================================================================

		tab savings_rate, m 
		tab signup, m
		tab signup if duration_cat!="01 Less than 5 minutes"
		
		tab signup if savings_rate==5  & duration_cat!="01 Less than 5 minutes", m
		tab signup if savings_rate==10 & duration_cat!="01 Less than 5 minutes", m
		tab signup if savings_rate==20 & duration_cat!="01 Less than 5 minutes", m
		
		tab cancel_fee, m 
		tab signup, m 
		tab signup if cancel_fee==0   & duration_cat!="01 Less than 5 minutes", m 
		tab signup if cancel_fee==250 & duration_cat!="01 Less than 5 minutes", m 
		
		tab length_years, m 
		tab signup, m 
		tab signup if length_years==1  & duration_cat!="01 Less than 5 minutes", m 
		tab signup if length_years==25 & duration_cat!="01 Less than 5 minutes", m 
		
		tab length_page, m 
		tab signup, m 
		tab signup if length_page==10 & duration_cat!="01 Less than 5 minutes", m 
		tab signup if length_page==20 & duration_cat!="01 Less than 5 minutes", m 
		
		tab race_eth      signup if duration_cat!="01 Less than 5 minutes"
		tab household_inc signup if duration_cat!="01 Less than 5 minutes"
		tab housing       signup if duration_cat!="01 Less than 5 minutes"
		
		
	save "$temp/temp.dta", replace

	
	/*
	
	tab savings_none    if duration_cat!="01 Less than 5 minutes", m 
	tab savings_1_5     if duration_cat!="01 Less than 5 minutes", m 
	tab savings_6_10    if duration_cat!="01 Less than 5 minutes", m  
	tab savings_11_15   if duration_cat!="01 Less than 5 minutes", m 
	tab savings_16_20   if duration_cat!="01 Less than 5 minutes", m 
	tab savings_21_50   if duration_cat!="01 Less than 5 minutes", m 
	tab savings_50_plus if duration_cat!="01 Less than 5 minutes", m 
	
	tab years_0_1       if duration_cat!="01 Less than 5 minutes", m 
	tab years_1_3       if duration_cat!="01 Less than 5 minutes", m 
	tab years_4_6       if duration_cat!="01 Less than 5 minutes", m 
	tab years_7_10      if duration_cat!="01 Less than 5 minutes", m 
	tab years_11_15     if duration_cat!="01 Less than 5 minutes", m 
	tab years_16_20     if duration_cat!="01 Less than 5 minutes", m 
	tab years_21_plus   if duration_cat!="01 Less than 5 minutes", m 
	
	tab fees_none       if duration_cat!="01 Less than 5 minutes", m 
	tab fees_1_100      if duration_cat!="01 Less than 5 minutes", m 
	tab fees_101_250    if duration_cat!="01 Less than 5 minutes", m 
	tab fees_251_500    if duration_cat!="01 Less than 5 minutes", m 
	tab fees_501_1000   if duration_cat!="01 Less than 5 minutes", m 
	tab fees_1000_plus  if duration_cat!="01 Less than 5 minutes", m 
	
	*/
	
	/*
	
	tab savings_none    if duration_cat!="01 Less than 5 minutes", m 
	tab savings_1_5     if duration_cat!="01 Less than 5 minutes", m 
	tab savings_6_10    if duration_cat!="01 Less than 5 minutes", m  
	tab savings_11_15   if duration_cat!="01 Less than 5 minutes", m 
	tab savings_16_20   if duration_cat!="01 Less than 5 minutes", m 
	tab savings_21_50   if duration_cat!="01 Less than 5 minutes", m 
	tab savings_50_plus if duration_cat!="01 Less than 5 minutes", m 
	
	tab years_0_1       if duration_cat!="01 Less than 5 minutes", m 
	tab years_1_3       if duration_cat!="01 Less than 5 minutes", m 
	tab years_4_6       if duration_cat!="01 Less than 5 minutes", m 
	tab years_7_10      if duration_cat!="01 Less than 5 minutes", m 
	tab years_11_15     if duration_cat!="01 Less than 5 minutes", m 
	tab years_16_20     if duration_cat!="01 Less than 5 minutes", m 
	tab years_21_plus   if duration_cat!="01 Less than 5 minutes", m 
	
	tab fees_none       if duration_cat!="01 Less than 5 minutes", m 
	tab fees_1_100      if duration_cat!="01 Less than 5 minutes", m 
	tab fees_101_250    if duration_cat!="01 Less than 5 minutes", m 
	tab fees_251_500    if duration_cat!="01 Less than 5 minutes", m 
	tab fees_501_1000   if duration_cat!="01 Less than 5 minutes", m 
	tab fees_1000_plus  if duration_cat!="01 Less than 5 minutes", m 
	
	*/
