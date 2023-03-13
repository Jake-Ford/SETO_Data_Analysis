

global file = "$temp/Themes for Focus Groups.xlsx"

import excel using "$file", ///
	clear sheet("categorize_additional_info") firstrow case(lower)
	
	rename c cat 
	tab cat 
	
	gen catbroad = ""
	order catbroad, after(cat)
	
	replace catbroad = "01 Nonsense" 				if cat=="Nonsense"
	replace catbroad = "02 No Info Needed" 			if cat=="Negative | No More Info"
	replace catbroad = "02 No Info Needed" 			if cat=="No More Info Needed (Unclear)"
	replace catbroad = "02 No Info Needed"			if cat=="Neutral | No More Info"
	replace catbroad = "02 No Info Needed"			if cat=="Positive | No More Info"
	replace catbroad = "03 Unspecified Info Needed"	if cat=="Unsure re: Info"
	replace catbroad = "03 Unspecified Info Needed"	if regexm(cat,"More info")
	replace catbroad = "02 No Info Needed"			if cat=="Has/Wants Own Panels"
	replace catbroad = "04 Specified Info Needed"	if missing(catbroad)
	
	
	tab cat if missing(catbroad)
	tab catbroad, m 
	
	encode catbroad, gen(cat_e)
	
	
		#delimit;
			hist cat_e
			, 
			discrete 
			start(1)
			
			fraction
			addlabels
			addlabopts(mlabsize(2.3) mlabformat(%4.2fc))
						
			width(.5)
			
			title("{bf:Is Additional Information Needed to Make a Decision?}", color(black) size(2.5)) 
			subtitle("Types of Open Responses", color(black) size(2.5)) 
			
			ylabel(0(.2)1, angle(0) labsize(2.3) glcolor(gs12) glwidth(vvthin))
			ytitle("Share of Respondents", size(2.3))
			yline(1, lcolor(gs12) lwidth(vvthin))
			
			xlabel(1 "Nonsense Answer" 2 "No Info Needed" 3 "Unspecified Info Needed" 4 "Specified Info Needed" , notick labsize(2.3) format(%3.0fc) angle(0))
			xtitle(" " "Types of Open Responses", size(2.3))
			
			color(navy) lwidth(none)
			graphregion(fcolor(white) color(white))
			
			;
		#delimit cr
		graph export "$output/graphs/no speeders/Figure 002 - Household Size.png", as(png) height(5000) replace
		
		