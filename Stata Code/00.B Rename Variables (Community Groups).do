
*===============================================================================
* Import the Excel Qualtrics file
* Label and clean variable names
*===============================================================================

import excel using "$input/Community_Data.xlsx", ///
	clear sheet("Community Solar Priorities Surv") firstrow allstring

	*---------------------------------------------------------------------------
	* Drop the first two rows of the dataset, which are column headers rather 
	* than data
	*
	*** CAUTION ***: Do not run this line if there is actually data in the first 
	*   two rows (e.g., don't run more than once without reloading the data)
	*---------------------------------------------------------------------------
	
		drop in 1/2
	
	*---------------------------------------------------------------------------
	* Apply the variable labels that are listed in the Excel file 
	* "Survey Data Variable Names.xlsx"
	*
	*** CAUTION ***: Make sure none of the variables/questions have changed
	*---------------------------------------------------------------------------
		
		label var 	StartDate			"Start date"
		label var 	EndDate				"End date"
		label var 	Status				"Response type"
		label var 	Progress			"Progress"
		label var 	Durationinseconds	"Duration (in seconds)"
		label var 	Finished			"Finished survey"
		label var 	RecordedDate		"Recorded date"
		label var 	ResponseId			"Response ID"
		label var 	DistributionChannel	"Distribution channel"
		label var 	UserLanguage		"User language"
		label var 	Q83_FirstClick		"Q83: Timing: First click (Intro)"
		label var 	Q83_LastClick		"Q83: Timing: Last click (Intro)"
		label var 	Q83_PageSubmit		"Q83: Timing: Page submit (Intro)"
		label var 	Q83_ClickCount		"Q83: Timing: Click count (Intro)"
	//	label var 	Q84_FirstClick		"Q84: Timing: First click (Consent)"
	//	label var 	Q84_LastClick		"Q84: Timing: Last click (Consent)"
	//	label var 	Q84_PageSubmit		"Q84: Timing: Page submit (Consent)"
	//	label var 	Q84_ClickCount		"Q84: Timing: Click count (Consent)"
		label var 	Q67					"Q67: Informed consent"
		label var 	Q91					"Q91: What is your zip code?"
		label var 	Q248				"Q248: How many people currently live in your home, including yourself?"
	//	label var 	Q80_FirstClick		"Q80: Timing: First click (Community solar background)"
	//	label var 	Q80_LastClick		"Q80: Timing: Last click (Community solar background)"
	//	label var 	Q80_PageSubmit		"Q80: Timing: Page submit (Community solar background)"
	//	label var 	Q80_ClickCount		"Q80: Timing: Click count (Community solar background)"
		label var 	Q14					"Q14-1: Who pays your houshold's electricity bills?"
		label var 	Q14_5_TEXT			"Q14-2: Who pays your houshold's electricity bills? (Other)"
		label var 	Q96					"Q96: Did you miss an electricity bill payment at any time last year?"
		label var 	Q15					"Q15: Familiarity with community solar prior to taking survey"
		label var 	Q97					"Q15: How did you hear about community solar?"
		label var 	Q16					"Q16: Importance of paying electricity bill"
		label var 	Q17					"Q17: Importance of paying monthly service that saves money on electricity bill"
		label var 	Q18					"Q18: Importance of climate change to you personally"
	//	label var 	Q70_FirstClick		"Q70: Timing: First click (Contract 1, Part 1)"
	//	label var 	Q70_LastClick		"Q70: Timing: Last click (Contract 1, Part 1)"
	//	label var 	Q70_PageSubmit		"Q70: Timing: Page submit (Contract 1, Part 1)"
	//	label var 	Q70_ClickCount		"Q70: Timing: Click count (Contract 1, Part 1)"
		label var 	Q20					"Q20: Contract 1: Would you choose to sign up for this program?"
		label var 	Q86_FirstClick		"Q86: Timing: First click (Contract 1, Part 2)"
		label var 	Q86_LastClick		"Q86: Timing: Last click (Contract 1, Part 2)"
		label var 	Q86_PageSubmit		"Q86: Timing: Page submit (Contract 1, Part 2)"
		label var 	Q86_ClickCount		"Q86: Timing: Click count (Contract 1, Part 2)"
		label var 	Q23					"Q23: Contract 1: How much of contract did you review?"
		label var 	Q24					"Q24: Contract 1: How understandable/straightforward was the contract?"
	//	label var 	Q115_FirstClick		"Q115: Timing: First click (Contract 2, Part 1)"
	//	label var 	Q115_LastClick		"Q115: Timing: Last click (Contract 2, Part 1)"
	//	label var 	Q115_PageSubmit		"Q115: Timing: Page submit (Contract 2, Part 1)"
	//	label var 	Q115_ClickCount		"Q115: Timing: Click count (Contract 2, Part 1)"
		label var 	Q117				"Q117: Contract 2: Would you choose to sign up for this program?"
		label var 	Q118_FirstClick		"Q118: Timing: First click (Contract 2, Part 2)"
		label var 	Q118_LastClick		"Q118: Timing: Last click (Contract 2, Part 2)"
		label var 	Q118_PageSubmit		"Q118: Timing: Page submit (Contract 2, Part 2)"
		label var 	Q118_ClickCount		"Q118: Timing: Click count (Contract 2, Part 2)"
		label var 	Q119				"Q119: Contract 2: How much of contract did you review?"
		label var 	Q120				"Q120: Contract 2: How understandable/straightforward was the contract?"
	//	label var 	Q121_FirstClick		"Q121: Timing: First click (Contract 3, Part 1)"
	//	label var 	Q121_LastClick		"Q121: Timing: Last click (Contract 3, Part 1)"
	//	label var 	Q121_PageSubmit		"Q121: Timing: Page submit (Contract 3, Part 1)"
	//	label var 	Q121_ClickCount		"Q121: Timing: Click count (Contract 3, Part 1)"
		label var 	Q123				"Q123: Contract 3: Would you choose to sign up for this program?"
		label var 	Q124_FirstClick		"Q124: Timing: First click (Contract 3, Part 2)"
		label var 	Q124_LastClick		"Q124: Timing: Last click (Contract 3, Part 2)"
		label var 	Q124_PageSubmit		"Q124: Timing: Page submit (Contract 3, Part 2)"
		label var 	Q124_ClickCount		"Q124: Timing: Click count (Contract 3, Part 2)"
		label var 	Q125				"Q125: Contract 3: How much of contract did you review?"
		label var 	Q126				"Q126: Contract 3: How understandable/straightforward was the contract?"
	//	label var 	Q127_FirstClick		"Q127: Timing: First click (Contract 4, Part 1)"
	//	label var 	Q127_LastClick		"Q127: Timing: Last click (Contract 4, Part 1)"
	//	label var 	Q127_PageSubmit		"Q127: Timing: Page submit (Contract 4, Part 1)"
	//	label var 	Q127_ClickCount		"Q127: Timing: Click count (Contract 4, Part 1)"
		label var 	Q129				"Q129: Contract 4: Would you choose to sign up for this program?"
		label var 	Q130_FirstClick		"Q130: Timing: First click (Contract 4, Part 2)"
		label var 	Q130_LastClick		"Q130: Timing: Last click (Contract 4, Part 2)"
		label var 	Q130_PageSubmit		"Q130: Timing: Page submit (Contract 4, Part 2)"
		label var 	Q130_ClickCount		"Q130: Timing: Click count (Contract 4, Part 2)"
		label var 	Q131				"Q131: Contract 4: How much of contract did you review?"
		label var 	Q132				"Q132: Contract 4: How understandable/straightforward was the contract?"
	//	label var 	Q133_FirstClick		"Q133: Timing: First click (Contract 5, Part 1)"
	//	label var 	Q133_LastClick		"Q133: Timing: Last click (Contract 5, Part 1)"
	//	label var 	Q133_PageSubmit		"Q133: Timing: Page submit (Contract 5, Part 1)"
	//	label var 	Q133_ClickCount		"Q133: Timing: Click count (Contract 5, Part 1)"
		label var 	Q135				"Q135: Contract 5: Would you choose to sign up for this program?"
		label var 	Q136_FirstClick		"Q136: Timing: First click (Contract 5, Part 2)"
		label var 	Q136_LastClick		"Q136: Timing: Last click (Contract 5, Part 2)"
		label var 	Q136_PageSubmit		"Q136: Timing: Page submit (Contract 5, Part 2)"
		label var 	Q136_ClickCount		"Q136: Timing: Click count (Contract 5, Part 2)"
		label var 	Q137				"Q137: Contract 5: How much of contract did you review?"
		label var 	Q138				"Q138: Contract 5: How understandable/straightforward was the contract?"
	//	label var 	Q139_FirstClick		"Q139: Timing: First click (Contract 6, Part 1)"
	//	label var 	Q139_LastClick		"Q139: Timing: Last click (Contract 6, Part 1)"
	//	label var 	Q139_PageSubmit		"Q139: Timing: Page submit (Contract 6, Part 1)"
	//	label var 	Q139_ClickCount		"Q139: Timing: Click count (Contract 6, Part 1)"
		label var 	Q141				"Q141: Contract 6: Would you choose to sign up for this program?"
		label var 	Q142_FirstClick		"Q142: Timing: First click (Contract 6, Part 2)"
		label var 	Q142_LastClick		"Q142: Timing: Last click (Contract 6, Part 2)"
		label var 	Q142_PageSubmit		"Q142: Timing: Page submit (Contract 6, Part 2)"
		label var 	Q142_ClickCount		"Q142: Timing: Click count (Contract 6, Part 2)"
		label var 	Q143				"Q143: Contract 6: How much of contract did you review?"
		label var 	Q144				"Q144: Contract 6: How understandable/straightforward was the contract?"
	//	label var 	Q145_FirstClick		"Q145: Timing: First click (Contract 7, Part 1)"
	//	label var 	Q145_LastClick		"Q145: Timing: Last click (Contract 7, Part 1)"
	//	label var 	Q145_PageSubmit		"Q145: Timing: Page submit (Contract 7, Part 1)"
	//	label var 	Q145_ClickCount		"Q145: Timing: Click count (Contract 7, Part 1)"
		label var 	Q147				"Q147: Contract 7: Would you choose to sign up for this program?"
		label var 	Q148_FirstClick		"Q148: Timing: First click (Contract 7, Part 2)"
		label var 	Q148_LastClick		"Q148: Timing: Last click (Contract 7, Part 2)"
		label var 	Q148_PageSubmit		"Q148: Timing: Page submit (Contract 7, Part 2)"
		label var 	Q148_ClickCount		"Q148: Timing: Click count (Contract 7, Part 2)"
		label var 	Q149				"Q149: Contract 7: How much of contract did you review?"
		label var 	Q150				"Q150: Contract 7: How understandable/straightforward was the contract?"
	//	label var 	Q151_FirstClick		"Q151: Timing: First click (Contract 8, Part 1)"
	//	label var 	Q151_LastClick		"Q151: Timing: Last click (Contract 8, Part 1)"
	//	label var 	Q151_PageSubmit		"Q151: Timing: Page submit (Contract 8, Part 1)"
	//	label var 	Q151_ClickCount		"Q151: Timing: Click count (Contract 8, Part 1)"
		label var 	Q153				"Q153: Contract 8: Would you choose to sign up for this program?"
		label var 	Q154_FirstClick		"Q154: Timing: First click (Contract 8, Part 2)"
		label var 	Q154_LastClick		"Q154: Timing: Last click (Contract 8, Part 2)"
		label var 	Q154_PageSubmit		"Q154: Timing: Page submit (Contract 8, Part 2)"
		label var 	Q154_ClickCount		"Q154: Timing: Click count (Contract 8, Part 2)"
		label var 	Q155				"Q155: Contract 8: How much of contract did you review?"
		label var 	Q156				"Q156: Contract 8: How understandable/straightforward was the contract?"
	//	label var 	Q157_FirstClick		"Q157: Timing: First click (Contract 9, Part 1)"
	//	label var 	Q157_LastClick		"Q157: Timing: Last click (Contract 9, Part 1)"
	//	label var 	Q157_PageSubmit		"Q157: Timing: Page submit (Contract 9, Part 1)"
	//	label var 	Q157_ClickCount		"Q157: Timing: Click count (Contract 9, Part 1)"
		label var 	Q159				"Q159: Contract 9: Would you choose to sign up for this program?"
		label var 	Q160_FirstClick		"Q160: Timing: First click (Contract 9, Part 2)"
		label var 	Q160_LastClick		"Q160: Timing: Last click (Contract 9, Part 2)"
		label var 	Q160_PageSubmit		"Q160: Timing: Page submit (Contract 9, Part 2)"
		label var 	Q160_ClickCount		"Q160: Timing: Click count (Contract 9, Part 2)"
		label var 	Q161				"Q161: Contract 9: How much of contract did you review?"
		label var 	Q162				"Q162: Contract 9: How understandable/straightforward was the contract?"
	//	label var 	Q163_FirstClick		"Q163: Timing: First click (Contract 10, Part 1)"
	//	label var 	Q163_LastClick		"Q163: Timing: Last click (Contract 10, Part 1)"
	//	label var 	Q163_PageSubmit		"Q163: Timing: Page submit (Contract 10, Part 1)"
	//	label var 	Q163_ClickCount		"Q163: Timing: Click count (Contract 10, Part 1)"
		label var 	Q165				"Q165: Contract 10: Would you choose to sign up for this program?"
		label var 	Q166_FirstClick		"Q166: Timing: First click (Contract 10, Part 2)"
		label var 	Q166_LastClick		"Q166: Timing: Last click (Contract 10, Part 2)"
		label var 	Q166_PageSubmit		"Q166: Timing: Page submit (Contract 10, Part 2)"
		label var 	Q166_ClickCount		"Q166: Timing: Click count (Contract 10, Part 2)"
		label var 	Q167				"Q167: Contract 10: How much of contract did you review?"
		label var 	Q168				"Q168: Contract 10: How understandable/straightforward was the contract?"
	//	label var 	Q169_FirstClick		"Q169: Timing: First click (Contract 11, Part 1)"
	//	label var 	Q169_LastClick		"Q169: Timing: Last click (Contract 11, Part 1)"
	//	label var 	Q169_PageSubmit		"Q169: Timing: Page submit (Contract 11, Part 1)"
	//	label var 	Q169_ClickCount		"Q169: Timing: Click count (Contract 11, Part 1)"
		label var 	Q171				"Q171: Contract 11: Would you choose to sign up for this program?"
		label var 	Q172_FirstClick		"Q172: Timing: First click (Contract 11, Part 2)"
		label var 	Q172_LastClick		"Q172: Timing: Last click (Contract 11, Part 2)"
		label var 	Q172_PageSubmit		"Q172: Timing: Page submit (Contract 11, Part 2)"
		label var 	Q172_ClickCount		"Q172: Timing: Click count (Contract 11, Part 2)"
		label var 	Q173				"Q173: Contract 11: How much of contract did you review?"
		label var 	Q174				"Q174: Contract 11: How understandable/straightforward was the contract?"
	//	label var 	Q175_FirstClick		"Q175: Timing: First click (Contract 12, Part 1)"
	//	label var 	Q175_LastClick		"Q175: Timing: Last click (Contract 12, Part 1)"
	//	label var 	Q175_PageSubmit		"Q175: Timing: Page submit (Contract 12, Part 1)"
	//	label var 	Q175_ClickCount		"Q175: Timing: Click count (Contract 12, Part 1)"
		label var 	Q177				"Q177: Contract 12: Would you choose to sign up for this program?"
		label var 	Q178_FirstClick		"Q178: Timing: First click (Contract 12, Part 2)"
		label var 	Q178_LastClick		"Q178: Timing: Last click (Contract 12, Part 2)"
		label var 	Q178_PageSubmit		"Q178: Timing: Page submit (Contract 12, Part 2)"
		label var 	Q178_ClickCount		"Q178: Timing: Click count (Contract 12, Part 2)"
		label var 	Q179				"Q179: Contract 12: How much of contract did you review?"
		label var 	Q180				"Q180: Contract 12: How understandable/straightforward was the contract?"
	//	label var 	Q181_FirstClick		"Q181: Timing: First click (Contract 13, Part 1)"
	//	label var 	Q181_LastClick		"Q181: Timing: Last click (Contract 13, Part 1)"
	//	label var 	Q181_PageSubmit		"Q181: Timing: Page submit (Contract 13, Part 1)"
	//	label var 	Q181_ClickCount		"Q181: Timing: Click count (Contract 13, Part 1)"
		label var 	Q183				"Q183: Contract 13: Would you choose to sign up for this program?"
		label var 	Q184_FirstClick		"Q184: Timing: First click (Contract 13, Part 2)"
		label var 	Q184_LastClick		"Q184: Timing: Last click (Contract 13, Part 2)"
		label var 	Q184_PageSubmit		"Q184: Timing: Page submit (Contract 13, Part 2)"
		label var 	Q184_ClickCount		"Q184: Timing: Click count (Contract 13, Part 2)"
		label var 	Q185				"Q185: Contract 13: How much of contract did you review?"
		label var 	Q186				"Q186: Contract 13: How understandable/straightforward was the contract?"
//		label var 	Q187_FirstClick		"Q187: Timing: First click (Contract 14, Part 1)"
//		label var 	Q187_LastClick		"Q187: Timing: Last click (Contract 14, Part 1)"
//		label var 	Q187_PageSubmit		"Q187: Timing: Page submit (Contract 14, Part 1)"
//		label var 	Q187_ClickCount		"Q187: Timing: Click count (Contract 14, Part 1)"
		label var 	Q189				"Q189: Contract 14: Would you choose to sign up for this program?"
		label var 	Q190_FirstClick		"Q190: Timing: First click (Contract 14, Part 2)"
		label var 	Q190_LastClick		"Q190: Timing: Last click (Contract 14, Part 2)"
		label var 	Q190_PageSubmit		"Q190: Timing: Page submit (Contract 14, Part 2)"
		label var 	Q190_ClickCount		"Q190: Timing: Click count (Contract 14, Part 2)"
		label var 	Q191				"Q191: Contract 14: How much of contract did you review?"
		label var 	Q192				"Q192: Contract 14: How understandable/straightforward was the contract?"
//		label var 	Q193_FirstClick		"Q193: Timing: First click (Contract 15, Part 1)"
//		label var 	Q193_LastClick		"Q193: Timing: Last click (Contract 15, Part 1)"
//		label var 	Q193_PageSubmit		"Q193: Timing: Page submit (Contract 15, Part 1)"
//		label var 	Q193_ClickCount		"Q193: Timing: Click count (Contract 15, Part 1)"
		label var 	Q195				"Q195: Contract 15: Would you choose to sign up for this program?"
		label var 	Q196_FirstClick		"Q196: Timing: First click (Contract 15, Part 2)"
		label var 	Q196_LastClick		"Q196: Timing: Last click (Contract 15, Part 2)"
		label var 	Q196_PageSubmit		"Q196: Timing: Page submit (Contract 15, Part 2)"
		label var 	Q196_ClickCount		"Q196: Timing: Click count (Contract 15, Part 2)"
		label var 	Q197				"Q197: Contract 15: How much of contract did you review?"
		label var 	Q198				"Q198: Contract 15: How understandable/straightforward was the contract?"
//		label var 	Q199_FirstClick		"Q199: Timing: First click (Contract 16, Part 1)"
//		label var 	Q199_LastClick		"Q199: Timing: Last click (Contract 16, Part 1)"
//		label var 	Q199_PageSubmit		"Q199: Timing: Page submit (Contract 16, Part 1)"
//		label var 	Q199_ClickCount		"Q199: Timing: Click count (Contract 16, Part 1)"
		label var 	Q201				"Q201: Contract 16: Would you choose to sign up for this program?"
		label var 	Q202_FirstClick		"Q202: Timing: First click (Contract 16, Part 2)"
		label var 	Q202_LastClick		"Q202: Timing: Last click (Contract 16, Part 2)"
		label var 	Q202_PageSubmit		"Q202: Timing: Page submit (Contract 16, Part 2)"
		label var 	Q202_ClickCount		"Q202: Timing: Click count (Contract 16, Part 2)"
		label var 	Q203				"Q203: Contract 16: How much of contract did you review?"
		label var 	Q204				"Q204: Contract 16: How understandable/straightforward was the contract?"
//		label var 	Q205_FirstClick		"Q205: Timing: First click (Contract 17, Part 1)"
//		label var 	Q205_LastClick		"Q205: Timing: Last click (Contract 17, Part 1)"
//		label var 	Q205_PageSubmit		"Q205: Timing: Page submit (Contract 17, Part 1)"
//		label var 	Q205_ClickCount		"Q205: Timing: Click count (Contract 17, Part 1)"
		label var 	Q207				"Q207: Contract 17: Would you choose to sign up for this program?"
		label var 	Q208_FirstClick		"Q208: Timing: First click (Contract 17, Part 2)"
		label var 	Q208_LastClick		"Q208: Timing: Last click (Contract 17, Part 2)"
		label var 	Q208_PageSubmit		"Q208: Timing: Page submit (Contract 17, Part 2)"
		label var 	Q208_ClickCount		"Q208: Timing: Click count (Contract 17, Part 2)"
		label var 	Q209				"Q209: Contract 17: How much of contract did you review?"
		label var 	Q210				"Q210: Contract 17: How understandable/straightforward was the contract?"
//		label var 	Q211_FirstClick		"Q211: Timing: First click (Contract 18, Part 1)"
//		label var 	Q211_LastClick		"Q211: Timing: Last click (Contract 18, Part 1)"
//		label var 	Q211_PageSubmit		"Q211: Timing: Page submit (Contract 18, Part 1)"
//		label var 	Q211_ClickCount		"Q211: Timing: Click count (Contract 18, Part 1)"
		label var 	Q213				"Q213: Contract 18: Would you choose to sign up for this program?"
		label var 	Q214_FirstClick		"Q214: Timing: First click (Contract 18, Part 2)"
		label var 	Q214_LastClick		"Q214: Timing: Last click (Contract 18, Part 2)"
		label var 	Q214_PageSubmit		"Q214: Timing: Page submit (Contract 18, Part 2)"
		label var 	Q214_ClickCount		"Q214: Timing: Click count (Contract 18, Part 2)"
		label var 	Q215				"Q215: Contract 18: How much of contract did you review?"
		label var 	Q216				"Q216: Contract 18: How understandable/straightforward was the contract?"
//		label var 	Q217_FirstClick		"Q217: Timing: First click (Contract 19, Part 1)"
//		label var 	Q217_LastClick		"Q217: Timing: Last click (Contract 19, Part 1)"
//		label var 	Q217_PageSubmit		"Q217: Timing: Page submit (Contract 19, Part 1)"
//		label var 	Q217_ClickCount		"Q217: Timing: Click count (Contract 19, Part 1)"
		label var 	Q219				"Q219: Contract 19: Would you choose to sign up for this program?"
		label var 	Q220_FirstClick		"Q220: Timing: First click (Contract 19, Part 2)"
		label var 	Q220_LastClick		"Q220: Timing: Last click (Contract 19, Part 2)"
		label var 	Q220_PageSubmit		"Q220: Timing: Page submit (Contract 19, Part 2)"
		label var 	Q220_ClickCount		"Q220: Timing: Click count (Contract 19, Part 2)"
		label var 	Q221				"Q221: Contract 19: How much of contract did you review?"
		label var 	Q222				"Q222: Contract 19: How understandable/straightforward was the contract?"
//		label var 	Q223_FirstClick		"Q223: Timing: First click (Contract 20, Part 1)"
//		label var 	Q223_LastClick		"Q223: Timing: Last click (Contract 20, Part 1)"
//		label var 	Q223_PageSubmit		"Q223: Timing: Page submit (Contract 20, Part 1)"
//		label var 	Q223_ClickCount		"Q223: Timing: Click count (Contract 20, Part 1)"
		label var 	Q225				"Q225: Contract 20: Would you choose to sign up for this program?"
		label var 	Q226_FirstClick		"Q226: Timing: First click (Contract 20, Part 2)"
		label var 	Q226_LastClick		"Q226: Timing: Last click (Contract 20, Part 2)"
		label var 	Q226_PageSubmit		"Q226: Timing: Page submit (Contract 20, Part 2)"
		label var 	Q226_ClickCount		"Q226: Timing: Click count (Contract 20, Part 2)"
		label var 	Q227				"Q227: Contract 20: How much of contract did you review?"
		label var 	Q228				"Q228: Contract 20: How understandable/straightforward was the contract?"
//		label var 	Q229_FirstClick		"Q229: Timing: First click (Contract 21, Part 1)"
//		label var 	Q229_LastClick		"Q229: Timing: Last click (Contract 21, Part 1)"
//		label var 	Q229_PageSubmit		"Q229: Timing: Page submit (Contract 21, Part 1)"
//		label var 	Q229_ClickCount		"Q229: Timing: Click count (Contract 21, Part 1)"
		label var 	Q231				"Q231: Contract 21: Would you choose to sign up for this program?"
		label var 	Q232_FirstClick		"Q232: Timing: First click (Contract 21, Part 2)"
		label var 	Q232_LastClick		"Q232: Timing: Last click (Contract 21, Part 2)"
		label var 	Q232_PageSubmit		"Q232: Timing: Page submit (Contract 21, Part 2)"
		label var 	Q232_ClickCount		"Q232: Timing: Click count (Contract 21, Part 2)"
		label var 	Q233				"Q233: Contract 21: How much of contract did you review?"
		label var 	Q234				"Q234: Contract 21: How understandable/straightforward was the contract?"
//		label var 	Q235_FirstClick		"Q235: Timing: First click (Contract 22, Part 1)"
//		label var 	Q235_LastClick		"Q235: Timing: Last click (Contract 22, Part 1)"
//		label var 	Q235_PageSubmit		"Q235: Timing: Page submit (Contract 22, Part 1)"
//		label var 	Q235_ClickCount		"Q235: Timing: Click count (Contract 22, Part 1)"
		label var 	Q237				"Q237: Contract 22: Would you choose to sign up for this program?"
		label var 	Q238_FirstClick		"Q238: Timing: First click (Contract 22, Part 2)"
		label var 	Q238_LastClick		"Q238: Timing: Last click (Contract 22, Part 2)"
		label var 	Q238_PageSubmit		"Q238: Timing: Page submit (Contract 22, Part 2)"
		label var 	Q238_ClickCount		"Q238: Timing: Click count (Contract 22, Part 2)"
		label var 	Q239				"Q239: Contract 22: How much of contract did you review?"
		label var 	Q240				"Q240: Contract 22: How understandable/straightforward was the contract?"
//		label var 	Q241_FirstClick		"Q241: Timing: First click (Contract 23, Part 1)"
//		label var 	Q241_LastClick		"Q241: Timing: Last click (Contract 23, Part 1)"
//		label var 	Q241_PageSubmit		"Q241: Timing: Page submit (Contract 23, Part 1)"
//		label var 	Q241_ClickCount		"Q241: Timing: Click count (Contract 23, Part 1)"
		label var 	Q243				"Q243: Contract 23: Would you choose to sign up for this program?"
		label var 	Q244_FirstClick		"Q244: Timing: First click (Contract 23, Part 2)"
		label var 	Q244_LastClick		"Q244: Timing: Last click (Contract 23, Part 2)"
		label var 	Q244_PageSubmit		"Q244: Timing: Page submit (Contract 23, Part 2)"
		label var 	Q244_ClickCount		"Q244: Timing: Click count (Contract 23, Part 2)"
		label var 	Q245				"Q245: Contract 23: How much of contract did you review?"
		label var 	Q246				"Q246: Contract 23: How understandable/straightforward was the contract?"
//		label var 	Q247_FirstClick		"Q247: Timing: First click (Contract 24, Part 1)"
//		label var 	Q247_LastClick		"Q247: Timing: Last click (Contract 24, Part 1)"
//		label var 	Q247_PageSubmit		"Q247: Timing: Page submit (Contract 24, Part 1)"
//		label var 	Q247_ClickCount		"Q247: Timing: Click count (Contract 24, Part 1)"
		label var 	Q249				"Q249: Contract 24: Would you choose to sign up for this program?"
		label var 	Q250_FirstClick		"Q250: Timing: First click (Contract 24, Part 2)"
		label var 	Q250_LastClick		"Q250: Timing: Last click (Contract 24, Part 2)"
		label var 	Q250_PageSubmit		"Q250: Timing: Page submit (Contract 24, Part 2)"
		label var 	Q250_ClickCount		"Q250: Timing: Click count (Contract 24, Part 2)"
		label var 	Q251				"Q251: Contract 24: How much of contract did you review?"
		label var 	Q252				"Q252: Contract 24: How understandable/straightforward was the contract?"
//		label var 	Q74_FirstClick		"Q74: Timing: First click (Community solar preferences 1)"
//		label var 	Q74_LastClick		"Q74: Timing: Last click (Community solar preferences 1)"
//		label var 	Q74_PageSubmit		"Q74: Timing: Page submit (Community solar preferences 1)"
//		label var 	Q74_ClickCount		"Q74: Timing: Click count (Community solar preferences 1)"
		label var 	Q31_1				"Q31-1: Community solar is possible solution for addressing climate change"
		label var 	Q31_2				"Q31-2: Contracts gave enough information to make an informed decision"
		label var 	Q31_3				"Q31-3: Would participate primarily because of electricity bill savings"
		label var 	Q31_4				"Q31-4: Would participate primarily because of environmental benefits"
//		label var 	Q75_FirstClick		"Q75: Timing: First click (Community solar preferences 2)"
//		label var 	Q75_LastClick		"Q75: Timing: Last click (Community solar preferences 2)"
//		label var 	Q75_PageSubmit		"Q75: Timing: Page submit (Community solar preferences 2)"
//		label var 	Q75_ClickCount		"Q75: Timing: Click count (Community solar preferences 2)"
		label var 	Q57_1				"Q57-1: More likely to sign up for program that creates jobs in my community"
		label var 	Q57_2				"Q57-2: More likely to sign up for program if solar garden in my community"
		label var 	Q57_3				"Q57-3: More likely to sign up for program with battery storage"
//		label var 	Q57_4				"Q57-4: Would support my utility applying small fee to fund community solar"
//		label var 	Q57_5				"Q57-5: Important to me to pay a single bill per month for my electricity"
//		label var 	Q57_6				"Q57-6: Prefer solar/clean energy over the current source provided by my utility"
//		label var 	Q76_FirstClick		"Q76: Timing: First click (Community solar preferences 3)"
//		label var 	Q76_LastClick		"Q76: Timing: Last click (Community solar preferences 3)"
//		label var 	Q76_PageSubmit		"Q76: Timing: Page submit (Community solar preferences 3)"
//		label var 	Q76_ClickCount		"Q76: Timing: Click count (Community solar preferences 3)"
		label var 	Q58_1				"Q58-1: Feel confident program would deliver the promised savings"
		label var 	Q58_2				"Q58-2: Feel more confident to sign up if my electric utility was leading it"
		label var 	Q58_3				"Q58-3: Feel more confident to sign up if my city government was leading it"
		label var 	Q58_4				"Q58-4: Feel more confident to sign up if nonprofit in community was leading it"
//		label var 	Q58_5				"Q58-5: Feel more confident to sign up if I knew someone enrolled in the program"
//		label var 	Q58_6				"Q58-6: Less interested if required to provide my credit score"
//		label var 	Q58_7				"Q58-7: COVID-19 pandemic has impacted my ability to make electricity payments"
//		label var 	Q77_FirstClick		"Q77: Timing: First click (Community solar preferences 4)"
//		label var 	Q77_LastClick		"Q77: Timing: Last click (Community solar preferences 4)"
//		label var 	Q77_PageSubmit		"Q77: Timing: Page submit (Community solar preferences 4)"
//		label var 	Q77_ClickCount		"Q77: Timing: Click count (Community solar preferences 4)"
		label var 	Q59					"Q59-1: Which form of payment do you most prefer?"
		label var 	Q59_4_TEXT			"Q59-2: Which form of payment do you most prefer? (Other)"
		label var 	Q33_1				"Q33-1: Willingess to sign up: No savings"
		label var 	Q33_2				"Q33-2: Willingess to sign up: 1-5% savings"
		label var 	Q33_3				"Q33-3: Willingess to sign up: 6-10% savings"
		label var 	Q33_4				"Q33-4: Willingess to sign up: 11-15% savings"
		label var 	Q33_5				"Q33-5: Willingess to sign up: 16-20% savings"
		label var 	Q33_6				"Q33-6: Willingess to sign up: 21-50% savings"
		label var 	Q33_7				"Q33-7: Willingess to sign up: More than 50% savings"
//		label var 	Q78_FirstClick		"Q78: Timing: First click (Community solar preferences 5)"
//		label var 	Q78_LastClick		"Q78: Timing: Last click (Community solar preferences 5)"
//		label var 	Q78_PageSubmit		"Q78: Timing: Page submit (Community solar preferences 5)"
//		label var 	Q78_ClickCount		"Q78: Timing: Click count (Community solar preferences 5)"
		label var 	Q34_1				"Q34-1: Willingness to sign up: 0-1 year term length"
		label var 	Q34_2				"Q34-2: Willingess to sign up: 1-3 year term length"
		label var 	Q34_3				"Q34-3: Willingess to sign up: 4-6 year term length"
		label var 	Q34_4				"Q34-4: Willingess to sign up: 7-10 year term length"
		label var 	Q34_5				"Q34-5: Willingess to sign up: 11-15 year term length"
		label var 	Q34_6				"Q34-6: Willingess to sign up: 16-20 year term length"
		label var 	Q34_7				"Q34-7: Willingess to sign up: 21+ year term length"
//		label var 	Q79_FirstClick		"Q79: Timing: First click (Community solar preferences 6)"
//		label var 	Q79_LastClick		"Q79: Timing: Last click (Community solar preferences 6)"
//		label var 	Q79_PageSubmit		"Q79: Timing: Page submit (Community solar preferences 6)"
//		label var 	Q79_ClickCount		"Q79: Timing: Click count (Community solar preferences 6)"
		label var 	Q36_1				"Q36-1: Willingess to sign up: No cancellation fees"
		label var 	Q36_2				"Q36-2: Willingess to sign up: $1-$100 cancellation fees"
		label var 	Q36_3				"Q36-3: Willingess to sign up: $101-$250 cancellation fees"
		label var 	Q36_4				"Q36-4: Willingess to sign up: $251-$500 cancellation fees"
		label var 	Q36_5				"Q36-5: Willingess to sign up: $501-$1000 cancellation fees"
		label var 	Q36_6				"Q36-6: Willingess to sign up: More than $1000 cancellation fees"
//		label var 	Q82_FirstClick		"Q82: Timing: First click (Demographics 1)"
//		label var 	Q82_LastClick		"Q82: Timing: Last click (Demographics 1)"
//		label var 	Q82_PageSubmit		"Q82: Timing: Page submit (Demographics 1)"
//		label var 	Q82_ClickCount		"Q82: Timing: Click count (Demographics 1)"
		label var 	Q3					"Q03: Which of the following best describes your current housing situation?"
		label var 	Q4					"Q04: If you are a renter, are electricity costs included in your rent payments?"
		label var 	Q5					"Q05: How long have you lived in your current place of residence?"
//		label var 	Q81_FirstClick		"Q81: Timing: First click (Demographics 2)"
//		label var 	Q81_LastClick		"Q81: Timing: Last click (Demographics 2)"
//		label var 	Q81_PageSubmit		"Q81: Timing: Page submit (Demographics 2)"
//		label var 	Q81_ClickCount		"Q81: Timing: Click count (Demographics 2)"
		label var 	Q50					"Q50-1: Which gender do you identify as (All that apply)"
		label var 	Q50_6_TEXT			"Q50-2: Which gender do you identify as (All that apply) (Other)"
		label var 	Q51					"Q51-1: How would you identify your race/ethnicity? (All that apply)"
		label var 	Q51_7_TEXT			"Q51-2: How would you identify your race/ethnicity? (All that apply) (Other)"
		label var 	Q52					"Q52-1: What type of community best describes where you live?"
		label var 	Q52_4_TEXT			"Q52-2: What type of community best describes where you live? (Other)"
		label var 	Q53					"Q53-1: Do you speak a language other than English at home?"
		label var 	Q53_5_TEXT			"Q53-2: Do you speak a language other than English at home? (Which language)"
		label var 	Q54					"Q54-1: Enrolled in any of the following gov't programs? (All that apply)"
		label var 	Q54_10_TEXT			"Q54-2: Enrolled in any of the following gov't programs? (All that apply) (Other)"
		label var 	Q224				"Q224: Which best describes your annual household income?"
		label var 	Q37					"Q37: Any other information helpful to make an informed decision?"
		label var 	Q38					"Q38: Any comments/questions/concerns regarding this survey?"
		label var 	ZipCodeAnswer		"Embedded Data: Zip code"
		label var 	HHSizeAnswer		"Embedded Data: Household size"
		label var 	bucket1				"Embedded Data: Income bucket 1"
		label var 	bucket2				"Embedded Data: Income bucket 2"
		label var 	bucket3				"Embedded Data: Income bucket 3"
		label var 	bucket4				"Embedded Data: Income bucket 4"
		label var 	bucket5				"Embedded Data: Income bucket 5"
		label var 	elig				"Embedded Data: Eligible for survey"
		
		//JF Added
		label var 	Q226_1 				"Q226-1: Would support my utility applying small fee to fund community solar"
		label var 	Q226_2 				"Q226-2: Important to me to pay a single bill per month for my electricity"
		label var 	Q226_3				"Q226-3: Prefer solar/clean energy over the current source provided by my utility"
		label var 	Q225_1 				"Q225-1: Less interested if required to provide my credit score"
		label var 	Q225_2 				"Q225-2: Feel confident the program would deliver the promised savings"
		label var 	Q225_3				"Q225-3: COVID-19 pandemic has impacted my ability to make electricity payments"
		label var	FL_11_DO			"Contract review order"  //JF has to be manually concatenated


	*---------------------------------------------------------------------------
	* Clean variable names based on the Excel file 
	* "pilot data variable names.xlsx"
	*---------------------------------------------------------------------------
		
		rename	StartDate			start_date
		rename	EndDate				end_date
		rename	Status				response_type
		rename	Progress			progress
		rename	Durationinseconds	duration_sec
		rename	Finished			finished
		rename	RecordedDate		recorded_date
		rename	ResponseId			respid
		rename	DistributionChannel	dist_channel
		rename 	Q_RecaptchaScore 	recaptcha_score //JF
		rename	UserLanguage		user_lang
	//	rename	Q83_FirstClick		time_first_click_intro
	//	rename	Q83_LastClick		time_last_click_intro
	//	rename	Q83_PageSubmit		time_page_submit_intro
	//	rename	Q83_ClickCount		time_click_count_intro
	//	rename	Q84_FirstClick		time_first_click_consent
	//	rename	Q84_LastClick		time_last_click_consent
	//	rename	Q84_PageSubmit		time_page_submit_consent
	//	rename	Q84_ClickCount		time_click_count_consent
		rename	Q67					consent
		rename	Q91					zip
		rename	Q248				hhsize
	//	rename	Q80_FirstClick		time_first_click_csback
	//	rename	Q80_LastClick		time_last_click_csback
	//	rename	Q80_PageSubmit		time_page_submit_csback
	//	rename	Q80_ClickCount		time_click_count_csback
		rename	Q14					elec_bills_who_pays
		rename	Q14_5_TEXT			elec_bills_who_pays_oth
		rename	Q96					elec_bill_miss
		rename	Q15					familiarity
		rename	Q97					cs_how_hear
		rename	Q16					elec_bills_imp_pay
		rename	Q17					elec_bills_imp_save
		rename	Q18					climate_change
	//	rename	Q70_FirstClick		time_first_click_c1_p1
	//	rename	Q70_LastClick		time_last_click_c1_p1
	//	rename	Q70_PageSubmit		time_page_submit_c1_p1
	//	rename	Q70_ClickCount		time_click_count_c1_p1
		rename	Q20					c1_signup
		rename	Q86_FirstClick		time_first_click_c1_p2
		rename	Q86_LastClick		time_last_click_c1_p2
		rename	Q86_PageSubmit		time_page_submit_c1_p2
		rename	Q86_ClickCount		time_click_count_c1_p2
		rename	Q23					c1_review
		rename	Q24					c1_understand
	//	rename	Q115_FirstClick		time_first_click_c2_p1
	//	rename	Q115_LastClick		time_last_click_c2_p1
	//	rename	Q115_PageSubmit		time_page_submit_c2_p1
	//	rename	Q115_ClickCount		time_click_count_c2_p1
		rename	Q117				c2_signup
		rename	Q118_FirstClick		time_first_click_c2_p2
		rename	Q118_LastClick		time_last_click_c2_p2
		rename	Q118_PageSubmit		time_page_submit_c2_p2
		rename	Q118_ClickCount		time_click_count_c2_p2
		rename	Q119				c2_review
		rename	Q120				c2_understand
	//	rename	Q121_FirstClick		time_first_click_c3_p1
	//	rename	Q121_LastClick		time_last_click_c3_p1
	//	rename	Q121_PageSubmit		time_page_submit_c3_p1
	//	rename	Q121_ClickCount		time_click_count_c3_p1
		rename	Q123				c3_signup
		rename	Q124_FirstClick		time_first_click_c3_p2
		rename	Q124_LastClick		time_last_click_c3_p2
		rename	Q124_PageSubmit		time_page_submit_c3_p2
		rename	Q124_ClickCount		time_click_count_c3_p2
		rename	Q125				c3_review
		rename	Q126				c3_understand
	//	rename	Q127_FirstClick		time_first_click_c4_p1
	//	rename	Q127_LastClick		time_last_click_c4_p1
	//	rename	Q127_PageSubmit		time_page_submit_c4_p1
	//	rename	Q127_ClickCount		time_click_count_c4_p1
		rename	Q129				c4_signup
		rename	Q130_FirstClick		time_first_click_c4_p2
		rename	Q130_LastClick		time_last_click_c4_p2
		rename	Q130_PageSubmit		time_page_submit_c4_p2
		rename	Q130_ClickCount		time_click_count_c4_p2
		rename	Q131				c4_review
		rename	Q132				c4_understand
	//	rename	Q133_FirstClick		time_first_click_c5_p1
	//	rename	Q133_LastClick		time_last_click_c5_p1
	//	rename	Q133_PageSubmit		time_page_submit_c5_p1
	//	rename	Q133_ClickCount		time_click_count_c5_p1
		rename	Q135				c5_signup
		rename	Q136_FirstClick		time_first_click_c5_p2
		rename	Q136_LastClick		time_last_click_c5_p2
		rename	Q136_PageSubmit		time_page_submit_c5_p2
		rename	Q136_ClickCount		time_click_count_c5_p2
		rename	Q137				c5_review
		rename	Q138				c5_understand
	//	rename	Q139_FirstClick		time_first_click_c6_p1
	//	rename	Q139_LastClick		time_last_click_c6_p1
	//	rename	Q139_PageSubmit		time_page_submit_c6_p1
	//	rename	Q139_ClickCount		time_click_count_c6_p1
		rename	Q141				c6_signup
		rename	Q142_FirstClick		time_first_click_c6_p2
		rename	Q142_LastClick		time_last_click_c6_p2
		rename	Q142_PageSubmit		time_page_submit_c6_p2
		rename	Q142_ClickCount		time_click_count_c6_p2
		rename	Q143				c6_review
		rename	Q144				c6_understand
	//	rename	Q145_FirstClick		time_first_click_c7_p1
	//	rename	Q145_LastClick		time_last_click_c7_p1
	//	rename	Q145_PageSubmit		time_page_submit_c7_p1
	//	rename	Q145_ClickCount		time_click_count_c7_p1
		rename	Q147				c7_signup
		rename	Q148_FirstClick		time_first_click_c7_p2
		rename	Q148_LastClick		time_last_click_c7_p2
		rename	Q148_PageSubmit		time_page_submit_c7_p2
		rename	Q148_ClickCount		time_click_count_c7_p2
		rename	Q149				c7_review
		rename	Q150				c7_understand
	//	rename	Q151_FirstClick		time_first_click_c8_p1
	//	rename	Q151_LastClick		time_last_click_c8_p1
	//	rename	Q151_PageSubmit		time_page_submit_c8_p1
	//	rename	Q151_ClickCount		time_click_count_c8_p1
		rename	Q153				c8_signup
		rename	Q154_FirstClick		time_first_click_c8_p2
		rename	Q154_LastClick		time_last_click_c8_p2
		rename	Q154_PageSubmit		time_page_submit_c8_p2
		rename	Q154_ClickCount		time_click_count_c8_p2
		rename	Q155				c8_review
		rename	Q156				c8_understand
//		rename	Q157_FirstClick		time_first_click_c9_p1
//		rename	Q157_LastClick		time_last_click_c9_p1
//		rename	Q157_PageSubmit		time_page_submit_c9_p1
//		rename	Q157_ClickCount		time_click_count_c9_p1
		rename	Q159				c9_signup
		rename	Q160_FirstClick		time_first_click_c9_p2
		rename	Q160_LastClick		time_last_click_c9_p2
		rename	Q160_PageSubmit		time_page_submit_c9_p2
		rename	Q160_ClickCount		time_click_count_c9_p2
		rename	Q161				c9_review
		rename	Q162				c9_understand
//		rename	Q163_FirstClick		time_first_click_c10_p1
//		rename	Q163_LastClick		time_last_click_c10_p1
//		rename	Q163_PageSubmit		time_page_submit_c10_p1
//		rename	Q163_ClickCount		time_click_count_c10_p1
		rename	Q165				c10_signup
		rename	Q166_FirstClick		time_first_click_c10_p2
		rename	Q166_LastClick		time_last_click_c10_p2
		rename	Q166_PageSubmit		time_page_submit_c10_p2
		rename	Q166_ClickCount		time_click_count_c10_p2
		rename	Q167				c10_review
		rename	Q168				c10_understand
//		rename	Q169_FirstClick		time_first_click_c11_p1
//		rename	Q169_LastClick		time_last_click_c11_p1
//		rename	Q169_PageSubmit		time_page_submit_c11_p1
//		rename	Q169_ClickCount		time_click_count_c11_p1
		rename	Q171				c11_signup
		rename	Q172_FirstClick		time_first_click_c11_p2
		rename	Q172_LastClick		time_last_click_c11_p2
		rename	Q172_PageSubmit		time_page_submit_c11_p2
		rename	Q172_ClickCount		time_click_count_c11_p2
		rename	Q173				c11_review
		rename	Q174				c11_understand
//		rename	Q175_FirstClick		time_first_click_c12_p1
//		rename	Q175_LastClick		time_last_click_c12_p1
//		rename	Q175_PageSubmit		time_page_submit_c12_p1
//		rename	Q175_ClickCount		time_click_count_c12_p1
		rename	Q177				c12_signup
		rename	Q178_FirstClick		time_first_click_c12_p2
		rename	Q178_LastClick		time_last_click_c12_p2
		rename	Q178_PageSubmit		time_page_submit_c12_p2
		rename	Q178_ClickCount		time_click_count_c12_p2
		rename	Q179				c12_review
		rename	Q180				c12_understand
//		rename	Q181_FirstClick		time_first_click_c13_p1
//		rename	Q181_LastClick		time_last_click_c13_p1
//		rename	Q181_PageSubmit		time_page_submit_c13_p1
//		rename	Q181_ClickCount		time_click_count_c13_p1
		rename	Q183				c13_signup
		rename	Q184_FirstClick		time_first_click_c13_p2
		rename	Q184_LastClick		time_last_click_c13_p2
		rename	Q184_PageSubmit		time_page_submit_c13_p2
		rename	Q184_ClickCount		time_click_count_c13_p2
		rename	Q185				c13_review
		rename	Q186				c13_understand
//		rename	Q187_FirstClick		time_first_click_c14_p1
//		rename	Q187_LastClick		time_last_click_c14_p1
//		rename	Q187_PageSubmit		time_page_submit_c14_p1
//		rename	Q187_ClickCount		time_click_count_c14_p1
		rename	Q189				c14_signup
		rename	Q190_FirstClick		time_first_click_c14_p2
		rename	Q190_LastClick		time_last_click_c14_p2
		rename	Q190_PageSubmit		time_page_submit_c14_p2
		rename	Q190_ClickCount		time_click_count_c14_p2
		rename	Q191				c14_review
		rename	Q192				c14_understand
//		rename	Q193_FirstClick		time_first_click_c15_p1
//		rename	Q193_LastClick		time_last_click_c15_p1
//		rename	Q193_PageSubmit		time_page_submit_c15_p1
//		rename	Q193_ClickCount		time_click_count_c15_p1
		rename	Q195				c15_signup
		rename	Q196_FirstClick		time_first_click_c15_p2
		rename	Q196_LastClick		time_last_click_c15_p2
		rename	Q196_PageSubmit		time_page_submit_c15_p2
		rename	Q196_ClickCount		time_click_count_c15_p2
		rename	Q197				c15_review
		rename	Q198				c15_understand
//		rename	Q199_FirstClick		time_first_click_c16_p1
//		rename	Q199_LastClick		time_last_click_c16_p1
//		rename	Q199_PageSubmit		time_page_submit_c16_p1
//		rename	Q199_ClickCount		time_click_count_c16_p1
		rename	Q201				c16_signup
		rename	Q202_FirstClick		time_first_click_c16_p2
		rename	Q202_LastClick		time_last_click_c16_p2
		rename	Q202_PageSubmit		time_page_submit_c16_p2
		rename	Q202_ClickCount		time_click_count_c16_p2
		rename	Q203				c16_review
		rename	Q204				c16_understand
//		rename	Q205_FirstClick		time_first_click_c17_p1
//		rename	Q205_LastClick		time_last_click_c17_p1
//		rename	Q205_PageSubmit		time_page_submit_c17_p1
//		rename	Q205_ClickCount		time_click_count_c17_p1
		rename	Q207				c17_signup
		rename	Q208_FirstClick		time_first_click_c17_p2
		rename	Q208_LastClick		time_last_click_c17_p2
		rename	Q208_PageSubmit		time_page_submit_c17_p2
		rename	Q208_ClickCount		time_click_count_c17_p2
		rename	Q209				c17_review
		rename	Q210				c17_understand
//		rename	Q211_FirstClick		time_first_click_c18_p1
//		rename	Q211_LastClick		time_last_click_c18_p1
//		rename	Q211_PageSubmit		time_page_submit_c18_p1
//		rename	Q211_ClickCount		time_click_count_c18_p1
		rename	Q213				c18_signup
		rename	Q214_FirstClick		time_first_click_c18_p2
		rename	Q214_LastClick		time_last_click_c18_p2
		rename	Q214_PageSubmit		time_page_submit_c18_p2
		rename	Q214_ClickCount		time_click_count_c18_p2
		rename	Q215				c18_review
		rename	Q216				c18_understand
//		rename	Q217_FirstClick		time_first_click_c19_p1
//		rename	Q217_LastClick		time_last_click_c19_p1
//		rename	Q217_PageSubmit		time_page_submit_c19_p1
//		rename	Q217_ClickCount		time_click_count_c19_p1
		rename	Q219				c19_signup
		rename	Q220_FirstClick		time_first_click_c19_p2
		rename	Q220_LastClick		time_last_click_c19_p2
		rename	Q220_PageSubmit		time_page_submit_c19_p2
		rename	Q220_ClickCount		time_click_count_c19_p2
		rename	Q221				c19_review
		rename	Q222				c19_understand
//		rename	Q223_FirstClick		time_first_click_c20_p1
//		rename	Q223_LastClick		time_last_click_c20_p1
//		rename	Q223_PageSubmit		time_page_submit_c20_p1
//		rename	Q223_ClickCount		time_click_count_c20_p1
		rename	Q225				c20_signup
		rename	Q226_FirstClick		time_first_click_c20_p2
		rename	Q226_LastClick		time_last_click_c20_p2
		rename	Q226_PageSubmit		time_page_submit_c20_p2
		rename	Q226_ClickCount		time_click_count_c20_p2
		rename	Q227				c20_review
		rename	Q228				c20_understand
//		rename	Q229_FirstClick		time_first_click_c21_p1
//		rename	Q229_LastClick		time_last_click_c21_p1
//		rename	Q229_PageSubmit		time_page_submit_c21_p1
//		rename	Q229_ClickCount		time_click_count_c21_p1
		rename	Q231				c21_signup
		rename	Q232_FirstClick		time_first_click_c21_p2
		rename	Q232_LastClick		time_last_click_c21_p2
		rename	Q232_PageSubmit		time_page_submit_c21_p2
		rename	Q232_ClickCount		time_click_count_c21_p2
		rename	Q233				c21_review
		rename	Q234				c21_understand
//		rename	Q235_FirstClick		time_first_click_c22_p1
//		rename	Q235_LastClick		time_last_click_c22_p1
//		rename	Q235_PageSubmit		time_page_submit_c22_p1
//		rename	Q235_ClickCount		time_click_count_c22_p1
		rename	Q237				c22_signup
		rename	Q238_FirstClick		time_first_click_c22_p2
		rename	Q238_LastClick		time_last_click_c22_p2
		rename	Q238_PageSubmit		time_page_submit_c22_p2
		rename	Q238_ClickCount		time_click_count_c22_p2
		rename	Q239				c22_review
		rename	Q240				c22_understand
//		rename	Q241_FirstClick		time_first_click_c23_p1
//		rename	Q241_LastClick		time_last_click_c23_p1
//		rename	Q241_PageSubmit		time_page_submit_c23_p1
//		rename	Q241_ClickCount		time_click_count_c23_p1
		rename	Q243				c23_signup
		rename	Q244_FirstClick		time_first_click_c23_p2
		rename	Q244_LastClick		time_last_click_c23_p2
		rename	Q244_PageSubmit		time_page_submit_c23_p2
		rename	Q244_ClickCount		time_click_count_c23_p2
		rename	Q245				c23_review
		rename	Q246				c23_understand
//		rename	Q247_FirstClick		time_first_click_c24_p1
//		rename	Q247_LastClick		time_last_click_c24_p1
//		rename	Q247_PageSubmit		time_page_submit_c24_p1
//		rename	Q247_ClickCount		time_click_count_c24_p1
		rename	Q249				c24_signup
		rename	Q250_FirstClick		time_first_click_c24_p2
		rename	Q250_LastClick		time_last_click_c24_p2
		rename	Q250_PageSubmit		time_page_submit_c24_p2
		rename	Q250_ClickCount		time_click_count_c24_p2
		rename	Q251				c24_review
		rename	Q252				c24_understand
//		rename	Q74_FirstClick		time_first_click_cspref1
//		rename	Q74_LastClick		time_last_click_cspref1
//		rename	Q74_PageSubmit		time_page_submit_cspref1
//		rename	Q74_ClickCount		time_click_count_cspref1
		rename	Q31_1				cs_solution_climate
		rename	Q31_2				enough_info
		rename	Q31_3				participate_savings
		rename	Q31_4				participate_environ
//		rename	Q75_FirstClick		time_first_click_cspref2
//		rename	Q75_LastClick		time_last_click_cspref2
//		rename	Q75_PageSubmit		time_page_submit_cspref2
//		rename	Q75_ClickCount		time_click_count_cspref2
		rename	Q57_1				program_jobs
		rename	Q57_2				program_garden_comm
		rename	Q57_3				program_battery
		
		//JF Added 226_1-3
		
		rename 	Q226_1 				utility_small_fee
		rename 	Q226_2 				single_bill 
		rename  Q226_3 				prefer_solar 
		
		
//		rename	Q57_4				utility_small_fee
//		rename	Q57_5				single_bill
//		rename	Q57_6				prefer_solar
//		rename	Q76_FirstClick		time_first_click_cspref3
//		rename	Q76_LastClick		time_last_click_cspref3
//		rename	Q76_PageSubmit		time_page_submit_cspref3
//		rename	Q76_ClickCount		time_click_count_cspref3
		rename	Q58_1				program_savings
		rename	Q58_2				program_run_util
		rename	Q58_3				program_run_govt
		rename	Q58_4				program_run_nonprof
		
		
		// JF added 
		rename 	Q225_1				credit_score 
		rename 	Q225_2				confident_program
		rename 	Q225_3				covid19
		
//		rename	Q58_5				program_know_someone
//		rename	Q58_6				credit_score
//		rename	Q58_7				covid19
//		rename	Q77_FirstClick		time_first_click_cspref4
//		rename	Q77_LastClick		time_last_click_cspref4
//		rename	Q77_PageSubmit		time_page_submit_cspref4
//		rename	Q77_ClickCount		time_click_count_cspref4
		rename	Q59					preferred_payment
		rename	Q59_4_TEXT			preferred_payment_oth
		rename	Q33_1				savings_none
		rename	Q33_2				savings_1_5
		rename	Q33_3				savings_6_10
		rename	Q33_4				savings_11_15
		rename	Q33_5				savings_16_20
		rename	Q33_6				savings_21_50
		rename	Q33_7				savings_50_plus
//		rename	Q78_FirstClick		time_first_click_cspref5
//		rename	Q78_LastClick		time_last_click_cspref5
//		rename	Q78_PageSubmit		time_page_submit_cspref5
//		rename	Q78_ClickCount		time_click_count_cspref5
		rename	Q34_1				years_0_1
		rename	Q34_2				years_1_3
		rename	Q34_3				years_4_6
		rename	Q34_4				years_7_10
		rename	Q34_5				years_11_15
		rename	Q34_6				years_16_20
		rename	Q34_7				years_21_plus
//		rename	Q79_FirstClick		time_first_click_cspref6
//		rename	Q79_LastClick		time_last_click_cspref6
//		rename	Q79_PageSubmit		time_page_submit_cspref6
//		rename	Q79_ClickCount		time_click_count_cspref6
		rename	Q36_1				fees_none
		rename	Q36_2				fees_1_100
		rename	Q36_3				fees_101_250
		rename	Q36_4				fees_251_500
		rename	Q36_5				fees_501_1000
		rename	Q36_6				fees_1000_plus
//		rename	Q82_FirstClick		time_first_click_demo1
//		rename	Q82_LastClick		time_last_click_demo1
//		rename	Q82_PageSubmit		time_page_submit_demo1
//		rename	Q82_ClickCount		time_click_count_demo1
		rename	Q3					housing
		rename	Q4					elec_incl_rent
		rename	Q5					housing_duration
//		rename	Q81_FirstClick		time_first_click_demo2
//		rename	Q81_LastClick		time_last_click_demo2
//		rename	Q81_PageSubmit		time_page_submit_demo2
//		rename	Q81_ClickCount		time_click_count_demo2
		rename	Q50					gender
		rename	Q50_6_TEXT			gender_oth
		rename	Q51					race_eth
		rename	Q51_7_TEXT			race_eth_other
		rename	Q52					community_type
		rename	Q52_4_TEXT			community_type_oth
		rename	Q53					lang_home
		rename	Q53_5_TEXT			lang_which
		rename	Q54					govt_prog
		rename	Q54_10_TEXT			govt_prog_oth
		rename	Q224				household_inc
		rename	Q37					additional_info
		rename	Q38					comments
		rename	ZipCodeAnswer		embed_zip
		rename	HHSizeAnswer		embed_hhsize
		rename	bucket1				embed_inc1
		rename	bucket2				embed_inc2
		rename	bucket3				embed_inc3
		rename	bucket4				embed_inc4
		rename	bucket5				embed_inc5
		rename	elig				embed_elig
		
	*---------------------------------------------------------------------------
	* Save an intermediate dataset
	* JF: drop any observations with 'GRID' in the 'Source' column, as these were identified as bots. This represents a majority of the responsess from the community survey
	*---------------------------------------------------------------------------
		
		
		
		drop if strpos(Source,"GRID")>0
		
		
		save "$temp/survey_data_clean_names_community.dta", replace

*===============================================================================
* End of file
*===============================================================================

