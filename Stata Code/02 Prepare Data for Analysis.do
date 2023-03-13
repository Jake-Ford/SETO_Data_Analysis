
*===============================================================================
* Load the Census Urbanized Area, Urban Cluster to zip code file
*===============================================================================

	*** TO DO: *************************************************************
	* MERGE ON CENSUS OR OTHER OFFICIAL ZIP CODE DATA TO USE THAT COMMUNITY 
	* TYPE INFORMATION INSTEAD OF SELF-REPORTED INFORMATION
	* THE NUMBER OF SUBURBAN RESPONDENTS IS LOWER THAN EXPECTED
	
	* https://www.hrsa.gov/rural-health/about-us/definition/index.html
	* https://www2.census.gov/geo/docs/maps-data/data/rel/ua_zcta_rel_10.txt
	* https://www2.census.gov/geo/pdfs/maps-data/data/rel/explanation_ua_zcta_rel_10.pdf
	
	* "The 2010 population living in the portion of ZCTA 49010 outside of any 
	* urban area is 11,052 (POPPT) and represents 63.61% of the total population 
	* living in ZCTA 49010 (ZPOPPCT). These numbers also represent the rural 
	* population in the ZCTA."
	************************************************************************
	import delimited using "$input/ua_zcta_rel_10.txt", clear delimiter(",")

		keep uaname zcta5 zpoppct
		rename zcta5 zip
		rename uaname ua 
		rename zpoppct pct_in
		bysort zip (pct_in): gen dupN = cond(_N==1,0,_N)
		bysort zip (pct_in): gen dupn = cond(_N==1,0,_n)
		gen ua_recode = ""
		order ua_recode, after(ua)
		replace ua_recode = "_rural" if ua=="Not in a 2010 urban area" & missing(ua_recode)
		replace ua_recode = "_ua"	if regexm(ua,"Urbanized Area")    & missing(ua_recode)
		replace ua_recode = "_uc"	if regexm(ua,"Urban Cluster")     & missing(ua_recode)
		* br if zip==02115
		drop if zip==99999
		tab dupN, m 
		collapse (sum) pct_in, by(ua_recode zip)
		reshape wide pct_in, i(zip) j(ua_recode) string
		recode pct_in_* (. = 0)
		gen total = pct_in_rural + pct_in_ua + pct_in_uc 
		tab total, m 
		gen area_cat = ""
		replace area_cat = "Urban" 		if pct_in_ua==100 & pct_in_uc==0   & pct_in_rural==0
		replace area_cat = "Rural" 		if pct_in_ua==0   & pct_in_uc==0   & pct_in_rural==100
		replace area_cat = "Suburban"	if pct_in_ua==0   & pct_in_uc==100 & pct_in_rural==0
		replace area_cat = "Mixed"		if missing(area_cat)
		tab area_cat, m 
		
		tostring zip, replace
		replace zip = "000" + zip if length(zip)==2
		replace zip = "00"  + zip if length(zip)==3
		replace zip = "0"   + zip if length(zip)==4
		
	save "$temp/urban_rural_zips.dta", replace

*===============================================================================
* Load the combined data file (Qualtrics and community groups) with cleaned variable names
* Clean the data so it's ready for analysis
*===============================================================================
	
		use "$temp/survey_data_clean_names_combined.dta", clear
		order source, first
		

		
	*---------------------------------------------------------------------------
	* Drop observations that should not be included in the analysis
	*---------------------------------------------------------------------------
		
	********************************CAUTION************************************:
	* The following section contains several "assert" statements. These are used
	* to test that a certain condition is true. If the condition is not true,
	* the code will break with the error message "assertion is false." This means
	* it's necessary to investigate why the condition isn't true.
	
	* For example, we expect all observations in the dataset to have consented 
	* to the survey. If the consent variable is not equal to "I agree," it is 
	* necessary to delete individuals who did not consent.
	****************************************************************************
	


		
		* Drop if date is before the start of the official survey 
		replace end_date = trim(end_date)
		replace end_date = substr(end_date,1,strpos(end_date," "))
		replace end_date = trim(end_date)
		gen date = date(end_date,"MDY")
		order date, after(source)
		format date %td
		codebook date if source=="01 qualtrics panel"
		cap codebook date if source=="02 community groups"
		
		*** EDIT REQUIRED: *****************************************************
		* Replace date<td(xx) with the relevant date for each survey 
		* drop if source=="01 qualtrics panel"  & date<td(01jun2021)
		* drop if source=="02 community groups" & date<td(01jun2021)
		************************************************************************


		
		******************************CAUTION**********************************:
		* Some of the respondents spent less than 300 seconds (5 minutes) 
		* completing the survey. These observations remain in the survey for now
		* but it is worth discussing whether to drop very fast respondents.
		************************************************************************
		
	*---------------------------------------------------------------------------
	* Save all of the time-related variables in a separate dataset to avoid
	* clutter in the main dataset 
	*---------------------------------------------------------------------------
		
		preserve
			#delimit ;
				keep
				source
				respid
				duration_sec
				time_*_intro 
				time_*_consent
				time_*_csback
				time_*_c1*
				time_*_c2*
				time_*_c3*
				time_*_c4*
				time_*_c5*
				time_*_c6*
				time_*_c7*
				time_*_c8*
				time_*_c9*
				time_*_c10*
				time_*_c11*
				time_*_c12*
				time_*_c13*
				time_*_c14*
				time_*_c15*
				time_*_c16*
				time_*_c17*
				time_*_c18*
				time_*_c19*
				time_*_c20*
				time_*_c21*
				time_*_c22*
				time_*_c23*
				time_*_c24*
				time_*_cspref*
				time_*_demo*
				;
			#delimit cr
			
			destring time_*, replace
			
			save "$temp/time_data.dta", replace
		restore 
		
	*---------------------------------------------------------------------------
	* Order variables and drop the ones that aren't necessary for the analysis
	*---------------------------------------------------------------------------
	
	********************************CAUTION************************************:
	* Only drop these variables if the restrictions above have been run
	****************************************************************************
	
		compress
		order respid, after(source)
		
		drop time_*
		drop start_date
		drop end_date
		drop response_type
		drop progress
		drop finished
		drop recorded_date
		drop dist_channel 
		drop user_lang
		drop consent 
		drop embed_hhsize
		drop embed_zip
		
		drop browser 
		drop browser_version 
		drop operating_system 
		drop browser_resolution
		drop recaptcha_score
		
		label var source "Source: Qualtrics or community group?"
		label var date	 "Response date"

	********************************CAUTION************************************:
	* The section between "#delimit ;" and "#delimit cr" needs to be run together
	****************************************************************************
	
		#delimit ;
		order 
			
			/*Survey logistics*/
			source 
			respid 
			date 
			duration_sec 
			
			/*Household and respondent demographics*/
			hhsize 
			zip 
			state 
			housing 
			housing_duration 
			household_inc
			embed_inc1 
			embed_inc2 
			embed_inc3 
			embed_inc4 
			embed_inc5 
			gender 
			gender_oth 
			race_eth 
			race_eth_other 
			community_type 
			community_type_oth 
			lang_home 
			lang_which 
			govt_prog 
			govt_prog_oth 
			elec_incl_rent 
			elec_bills_who_pays 
			elec_bills_who_pays_oth 
			elec_bill_miss 
			
			/*Respondent familiarity with and preferences for community solar*/
			familiarity 
			cs_how_hear 
			elec_bills_imp_pay 
			elec_bills_imp_save 
			climate_change 
			cs_solution_climate 
			enough_info 
			participate_savings 
			participate_environ 
			program_jobs 
			program_garden_comm 
			program_battery 
			utility_small_fee 
			single_bill 
			prefer_solar 
			program_savings 
			program_run_util 
			program_run_govt 
			program_run_nonprof 
			credit_score 
			confident_program 
			covid19 
			preferred_payment 
			preferred_payment_oth 
			
			/*How does savings rate impact willingness to sign up?*/
			savings_none 
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
			fees_1000_plus 
			
			/*Other*/
			additional_info 
			comments
			FL_11_DO
			
		;
		#delimit cr 
	
	*---------------------------------------------------------------------------
	* Reshape the data so that each row is a respondent-contract
	* The default structure is that each row is a respondent
	*---------------------------------------------------------------------------

	********************************CAUTION************************************:
	* The result of this reshape should be that the number of observations is 
	* multiplied by 24.
	
	* In the case of the Qualtrics survey results, there were 1,260 respondents,
	* meaning there should be 30,240 observations after reshaping the data. This
	* will be more once the community group respondents are added to the data.
	****************************************************************************

		gen id = _n
		order id, after(source)
		count
		reshape long @_signup @_review @_understand, i(respid id) j(contract_number) string		 
		count
		rename _signup 		signup
		rename _review 		review
		rename _understand 	understand
		
		order source respid id date duration_sec
		
		label var respid "Respondent ID"
		label var id	 "Alternative respondent ID (1-1260)"
		
		label var contract_number "Contract reviewed"
		order FL_11_DO, after(contract_number)
		
	*---------------------------------------------------------------------------
	* Create the contract term variables
	*---------------------------------------------------------------------------
		
		destring contract_number, replace ignore("c")
		sort respid contract_number
		
		gen savings_rate = .
		replace savings_rate = 5  if inlist(contract_number,  1,  2,  3,  4,  5,  6,  7,  8)
		replace savings_rate = 10 if inlist(contract_number,  9, 10, 11, 12, 13, 14, 15, 16)
		replace savings_rate = 20 if inlist(contract_number, 17, 18, 19, 20, 21, 22, 23, 24)
		
		gen length_years = .
		replace length_years = 1  if inlist(contract_number,  1,  2,  3,  4) 
		replace length_years = 1  if inlist(contract_number,  9, 10, 11, 12)
		replace length_years = 1  if inlist(contract_number, 17, 18, 19, 20)
		replace length_years = 25 if inlist(contract_number,  5,  6,  7,  8)
		replace length_years = 25 if inlist(contract_number, 13, 14, 15, 16)
		replace length_years = 25 if inlist(contract_number, 21, 22, 23, 24)
		
		gen length_page = .
		replace length_page = 10  if inlist(contract_number,  1,  2)  
		replace length_page = 10  if inlist(contract_number,  5,  6)
		replace length_page = 10  if inlist(contract_number,  9, 10)
		replace length_page = 10  if inlist(contract_number, 13, 14) 
		replace length_page = 10  if inlist(contract_number, 17, 18)
		replace length_page = 10  if inlist(contract_number, 21, 22)
		replace length_page = 20  if inlist(contract_number,  3,  4)
		replace length_page = 20  if inlist(contract_number,  7,  8)
		replace length_page = 20  if inlist(contract_number, 11, 12)
		replace length_page = 20  if inlist(contract_number, 15, 16)
		replace length_page = 20  if inlist(contract_number, 19, 20)
		replace length_page = 20  if inlist(contract_number, 23, 24)
		
		gen cancel_fee = .
		replace cancel_fee = 0   if inlist(contract_number,  1,  3,  5,  7,  9, 11)
		replace cancel_fee = 0   if inlist(contract_number, 13, 15, 17, 19, 21, 23)
		replace cancel_fee = 250 if inlist(contract_number,  2,  4,  6,  8, 10, 12)
		replace cancel_fee = 250 if inlist(contract_number, 14, 16, 18, 20, 22, 24)
		
		order contract_number FL_11_DO, after(comments)
		
		

		
	*---------------------------------------------------------------------------
	* Keep only the contracts that each respondent reviewed
	*---------------------------------------------------------------------------
	
	********************************CAUTION************************************:
	* The result of this step should be that the each respondent now has two 
	* observations in the dataset. 
	
	* In the case of the Qualtrics survey results, there were 1,260 respondents,
	* meaning there should be 2,520 observations after keeping only the observations
	* where signup was equal to "Yes" or "No" (i.e., only the respondent-contract
	* combinations that exist).
	****************************************************************************
	
		keep if inlist(signup,"Yes","No")
		count 
		
	*---------------------------------------------------------------------------
	* Clean and format variables as they were asked in the survey
	* This method uses a labeling method instead of encoding in case there are 
	* some options that are not chosen in the real survey
	*---------------------------------------------------------------------------
	
	*---------------------------------------------------------------------------
	* Agree/Disagree
	*---------------------------------------------------------------------------
	********************************CAUTION************************************:
	* THIS WHOLE SECTION MUST BE RUN TOGETHER IN A BLOCK
	****************************************************************************
	
		* Create the Agree/Disagree label 
			#delimit;
			label define 
				agree_disagree 
				1 "01 Strongly disagree"
				2 "02 Disagree"
				3 "03 Neutral"
				4 "04 Agree"
				5 "05 Strongly agree"
			;
			#delimit cr 
			
		* Apply the Agree/Disagree label to the relevant questions
		#delimit;
			ds 
				cs_solution_climate
				enough_info
				participate_savings
				participate_environ
				program_jobs
				program_garden_comm
				program_battery
				utility_small_fee
				single_bill
				prefer_solar
				program_savings
				program_run_util
				program_run_govt
				program_run_nonprof
				/*program_know_someone*/
				credit_score
				confident_program 
				covid19
		;
		#delimit cr
		return list
		
		foreach var in `r(varlist)' {
			replace `var' = substr(`var',1,1)
			destring `var', replace
			label values `var' agree_disagree
		}
	
	*---------------------------------------------------------------------------
	* Would sign up/Would not sign up
	*---------------------------------------------------------------------------
	********************************CAUTION************************************:
	* THIS WHOLE SECTION MUST BE RUN TOGETHER IN A BLOCK
	****************************************************************************
	
		* Create the Would sign up/Would not sign up label 
		#delimit;
		label define 
			signup_not 
			1 "01 Would not sign up"
			2 "02 Unlikely to sign up"
			3 "03 Neutral"
			4 "04 Likely to sign up"
			5 "05 Would sign up"
		;
		#delimit cr 
		
		#delimit;
			ds 
				savings_none
				savings_1_5
				savings_6_10
				savings_11_15
				savings_16_20
				savings_21_50
				savings_50_plus
				years_0_1
				years_1_3
				years_4_6
				years_7_10
				years_11_15
				years_16_20
				years_21_plus
				fees_none
				fees_1_100
				fees_101_250
				fees_251_500
				fees_501_1000
				fees_1000_plus
		;
		#delimit cr 
		return list 

		foreach var in `r(varlist)' {
			replace `var' = substr(`var',1,1)
			destring `var', replace
			label values `var' signup_not
		}
	
	*---------------------------------------------------------------------------
	* Important/Not important
	*---------------------------------------------------------------------------
	********************************CAUTION************************************:
	* THIS WHOLE SECTION MUST BE RUN TOGETHER IN A BLOCK
	****************************************************************************
	
	* Create the Important/Not important label 
		#delimit;
		label define 
			important_not 
			1 "01 Not important"
			2 "02 Slightly important"
			3 "03 Somewhat important"
			4 "04 Very important"
			5 "05 Most important"
		;
		#delimit cr 
		
	* Clean variables that don't start with a number
	* Important/not important
		foreach var in elec_bills_imp_pay elec_bills_imp_save climate_change {
			replace `var' = "1: Not important" 	      if `var'=="Not important"
			replace `var' = "2: Slightly important"   if `var'=="Slightly important"
			replace `var' = "3: Somewhat important"   if `var'=="Somewhat important"
			replace `var' = "4: Very important" 	  if `var'=="Very important"
			replace `var' = "5: Most important" 	  if `var'=="Most important"
		}
	
		foreach var in elec_bills_imp_pay elec_bills_imp_save climate_change {
			replace `var' = substr(`var',1,1)
			destring `var', replace
			label values `var' important_not 
		}

	*---------------------------------------------------------------------------
	* Familiar/Not familiar
	*---------------------------------------------------------------------------
	
	* Create the Familar/Not familiar label 
		#delimit;
		label define 
			familiar_not 
			1 "01 Not at all familiar"
			2 "02 Slightly familiar"
			3 "03 Somewhat familiar"
			4 "04 Very familiar"
		;
		#delimit cr 
		
	* Clean variables that don't start with a number
	* Familiar/not familiar	
		replace familiarity = "1" if familiarity=="Not at all familiar"
		replace familiarity = "2" if familiarity=="Slightly familiar"
		replace familiarity = "3" if familiarity=="Somewhat familiar"
		replace familiarity = "4" if familiarity=="Very familiar"
		destring familiarity, replace
		label values familiarity familiar_not

	*---------------------------------------------------------------------------
	* Household income
	*---------------------------------------------------------------------------
	
	* Clean income bucket
		replace household_inc = subinstr(household_inc,"$","",.)
		replace household_inc = "1: Less than 30% AMI"   if household_inc=="1: {e://Field/bucket1}"
		replace household_inc = "2: Between 30-50% AMI"  if household_inc=="2: {e://Field/bucket2}"
		replace household_inc = "3: Between 50-80% AMI"  if household_inc=="3: {e://Field/bucket3}"
		replace household_inc = "4: Between 80-120% AMI" if household_inc=="4: {e://Field/bucket4}"
		replace household_inc = "5: More than 120% AMI"  if household_inc=="5: {e://Field/bucket5}"
	
		gen inc_range = ""
		order inc_range, after(household_inc)
		replace inc_range = embed_inc1 if regexm(household_inc,"1:")
		replace inc_range = embed_inc2 if regexm(household_inc,"2:") 
		replace inc_range = embed_inc3 if regexm(household_inc,"3:")
		replace inc_range = embed_inc4 if regexm(household_inc,"4:") 
		replace inc_range = embed_inc5 if regexm(household_inc,"5:")
		drop embed_inc*
		label var inc_range	"Q224: Reported income range (Embedded choice)"
		
	*---------------------------------------------------------------------------
	* Clean the race/ethnicity variables
	*---------------------------------------------------------------------------
		tab race_eth, m
		replace race_eth = "Multiracial" if regexm(race_eth,",")
		tab race_eth, m
		compress race_eth
		
		replace race_eth_other = trim(lower(race_eth_other))
		tab race_eth_other, m
		compress race_eth_other
		 
	*---------------------------------------------------------------------------
	* Clean the gender variable
	*---------------------------------------------------------------------------
		tab gender, m 
		replace gender = "Other" if regexm(gender,",")
		replace gender = "Unknown" if gender=="Rather not say"
		tab gender, m
		replace gender = "Other" if inlist(gender,"Different gender identity","Transgender","Other")
		tab gender, m
	
	*---------------------------------------------------------------------------
	* Clean the community type variables
	*---------------------------------------------------------------------------
		replace community_type_oth = trim(lower(community_type_oth))
		tab community_type_oth, m
		replace community_type = "City or Urban Community" if community_type_oth=="los angels" 
		replace community_type = "Rural Community" if community_type_oth=="outside a small town"
		
	*---------------------------------------------------------------------------
	* Clean the language variables
	*---------------------------------------------------------------------------
		tab lang_home, m 
		replace lang_home = "Yes" if regexm(lang_home,"Yes")
		compress lang_home
		tab lang_home, m 
		
		tab lang_which, m
		replace lang_which = trim(lower(lang_which))

	*---------------------------------------------------------------------------
	* Clean the community solar familiarity variables
	*---------------------------------------------------------------------------
		tab cs_how_hear, m 
		replace cs_how_hear = trim(lower(cs_how_hear))
		tab cs_how_hear familiarity, m 
		count if familiarity=="04 Very familiar":familiar_not
		count if !missing(cs_how_hear)
		
		*** ADD A NOTE OF CAUTION/EXPLANATION HERE 
		replace familiarity = "01 Not at all familiar":familiar_not if cs_how_hear=="havent heard of it"
		replace familiarity = "01 Not at all familiar":familiar_not if cs_how_hear=="i have never hear of it before ."
		replace familiarity = "01 Not at all familiar":familiar_not if cs_how_hear=="in this survey"
		replace familiarity = "01 Not at all familiar":familiar_not if cs_how_hear=="this survey"

		*** CLEAN UP THE OTHER "HOW HEAR" RESPONSES FOR SUMMARY STAT PURPOSES
		
	*---------------------------------------------------------------------------
	* Clean the household size variable
	*---------------------------------------------------------------------------
		
		destring hhsize, replace ignore(" or more")
		
		#delimit;
		label define 
			hhsize
			1 "1 person"
			2 "2 people"
			3 "3 people"
			4 "4 people"
			5 "5 people"
			6 "6 people"
			7 "7 people"
			8 "8+ people"
		;
		#delimit cr 
		label values hhsize hhsize
		
	*---------------------------------------------------------------------------
	* Clean the contract review questions
	*---------------------------------------------------------------------------
		
		label define signup 0 "No" 1 "Yes"
		replace signup = "0" if signup=="No"
		replace signup = "1" if signup=="Yes"
		destring signup, replace
		label values signup signup 
		
		
		replace review = "Whole contract" if review=="I reviewed the whole contract prior to making a decision on whether I would or would not sign up for the program"
		compress
		
		
		label define understand 0 "No" 1 "Somewhat" 2 "Yes"
		replace understand = "0" if understand=="No"
		replace understand = "1" if understand=="Somewhat"
		replace understand = "2" if understand=="Yes"
		destring understand, replace
		label values understand understand
		
	*---------------------------------------------------------------------------
	* Identify which contracts reviewed first vs. second 
	*---------------------------------------------------------------------------
		split FL_11_DO, p("|")
		replace FL_11_DO1 = subinstr(FL_11_DO1,"time_first_click_c","",.)
		replace FL_11_DO2 = subinstr(FL_11_DO2,"time_first_click_c","",.)
		replace FL_11_DO1 = subinstr(FL_11_DO1,"time_first_click_c","",.)
		replace FL_11_DO2 = subinstr(FL_11_DO2,"time_first_click_c","",.)
		
		destring FL_11_DO1 FL_11_DO2, replace
		rename FL_11_DO1 contract1
		rename FL_11_DO2 contract2
		
		gen review_order = .
		replace review_order = 1 if contract_number==contract1
		replace review_order = 2 if contract_number==contract2
		order review_order, after(contract_number)
		drop FL_11_DO 
		drop contract1
		drop contract2 
		
	*---------------------------------------------------------------------------
	* Create outcome variable and right-hand side variables for regression
	*---------------------------------------------------------------------------
		
		* Outcome variable: 
		gen y_signup = .
		replace y_signup = 0 if signup=="No":signup
		replace y_signup = 1 if signup=="Yes":signup
		label define y_signup 0 "No" 1 "Yes"
		label values y_signup y_signup
		
		* Savings rate:
		gen x_sr = savings_rate
		label define x_sr 5 "5% savings rate" 10 "10% savings rate" 20 "20% savings rate"
		label values x_sr x_sr 
		
		* Contract length years: 
		gen x_cly = length_years
		label define x_cly 1 "1-year contract" 25 "25-year contract"
		label values x_cly x_cly
		
		* Contract length pages:
		gen x_clp = length_page
		label define x_clp 10 "10-page contract" 20 "20-page contract"
		label values x_clp x_clp
		
		* Cancellation fee:
		gen x_cf = cancel_fee
		label define x_cf 0 "Zero Cancellation Fee" 250 "$250 Cancellation Fee"
		label values x_cf x_cf

		* Income
		gen x_inc = ""
		replace x_inc = "01 High" 			 if inlist(household_inc,"5: More than 120% AMI")
		replace x_inc = "02 Moderate income" if inlist(household_inc,"3: Between 50-80% AMI","4: Between 80-120% AMI")
		replace x_inc = "03 Low income" 	 if inlist(household_inc,"1: Less than 30% AMI","2: Between 30-50% AMI")
		encode x_inc, gen(x_inc_e)
		drop x_inc 
		rename x_inc_e x_inc 
		
		* Race/ethnicity
		gen x_race = ""
		replace x_race = "02 Black" 	if inlist(race_eth,"Black or African American")
		replace x_race = "03 Hispanic"  if inlist(race_eth,"Hispanic or Latino")
		replace x_race = "01 White"		if inlist(race_eth,"White")
		replace x_race = "04 Asian"		if inlist(race_eth, "Asian")	
		replace x_race = "05 Other POC" if missing(x_race)
		encode x_race, gen(x_race_e)
		drop x_race
		rename x_race_e x_race 

		* Housing status
		gen x_hs = ""
		replace x_hs = "01 Homeowner" if inlist(housing,"Homeowner")
		replace x_hs = "02 Renter"    if inlist(housing,"Renter")
		replace x_hs = "03 Other"	  if inlist(housing,"Homeless")
		replace x_hs = "03 Other"     if regexm(housing,"Living with others")
		encode x_hs, gen(x_hs_e)
		drop x_hs 
		rename x_hs_e x_hs 
		
		* Familiarity with community solar
		gen x_fam = ""
		replace x_fam = "01 Less familiar" if inlist(familiarity,1,2)
		replace x_fam = "02 More familiar" if inlist(familiarity,3,4)
		encode x_fam, gen(x_fam_e)
		drop x_fam 
		rename x_fam_e x_fam 
		
		* How much reviewed contract
		gen x_rev = ""
		replace x_rev = "01 Less review" if regexm(review,"One page or less")
		replace x_rev = "01 Less review" if regexm(review,"Less than half")
		replace x_rev = "02 More review" if regexm(review,"More than half")
		replace x_rev = "02 More review" if regexm(review,"Whole contract")
		encode x_rev, gen(x_rev_e)
		drop x_rev 
		rename x_rev_e x_rev
		
		* Participation in government program 
		gen x_govt = ""
		replace x_govt = "01 None, Unknown, or Other"    if inlist(govt_prog,"None of the above","Not Sure","Other")
		replace x_govt = "02 At least one gov't program" if missing(x_govt)
		encode x_govt, gen(x_govt_e)
		drop x_govt 
		rename x_govt_e x_gov 
		
		* Contract review order
		gen x_ord = review_order
		label define x_ord 1 "01 First review" 2 "02 Second review"
		label values x_ord x_ord 
		

		* Survey Source - JF
		gen x_source = ""
		replace x_source = "01 Qualtrics Panel" 	if inlist(source,"01 qualtrics panel")
		replace x_source = "02 Community" if inlist(source,"02 community groups")
		encode x_source, gen(x_source_e)
		drop x_source 
		rename x_source_e x_source 
		
		


	gen id_join = _n
		
	
	
	*---------------------------------------------------------------------------
	* Save different versions of the dataset
	*---------------------------------------------------------------------------
	
	* Full dataset 
		*** EDIT REQUIRED: *****************************************************
		* The name of the file will need to be changed from "MOCK"
		save "$output/QUALTRICS_survey_data_all.dta", replace

		************************************************************************

		
		
	* Dataset for primary analyses
		
	* Dataset for secondary analyses
	
	********************************NOTE************************************:
	* June 2022: Jake Ford 
	* Weights are added separately, documentation in "SETO Survey Weighting.html"
	* and accompnanying Rmd
	****************************************************************************
	
	
	* add race weights
	
	import excel using "$input/weights_race.xlsx", sheet("Sheet1") firstrow clear
	gen id_join = _n
	
	save "$temp/survey_weights_race.dta", replace
	
	use "$output/QUALTRICS_survey_data_all.dta"
	merge 1:1 id_join using "$temp/survey_weights_race.dta"
	
	drop _merge

	save "$output/QUALTRICS_survey_data_all.dta", replace
	
	export excel using "$output/QUALTRICS_survey_data_all.xlsx", ///
			sheet("data") firstrow(variables) sheetreplace
	
	
	* add income weights
	
	import excel using "$input/weights_income.xlsx", sheet("Sheet1") firstrow clear
	gen id_join = _n
	
	save "$temp/survey_weights_income.dta", replace
	
	use "$output/QUALTRICS_survey_data_all.dta"
	merge 1:1 id_join using "$temp/survey_weights_income.dta"
	
	drop _merge

	save "$output/QUALTRICS_survey_data_all.dta", replace
	
	export excel using "$output/QUALTRICS_survey_data_all.xlsx", ///
			sheet("data") firstrow(variables) sheetreplace
	
*===============================================================================
* End of file
*===============================================================================
