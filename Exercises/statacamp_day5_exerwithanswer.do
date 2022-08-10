*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 5								  *
********************************************************************************

/*1. Set up this do file. Make sure to clear data in memory, declare version 
number of STATA in use. Do NOT declare a home folder using cd command.*/ 
clear all
set more off

version 13.0


/*2. Define three global macros (or simply, globals) that will set the path to 
the subfolders of Day5\Exercises: RawData, OutData, Figures 

Hint: It should look something like this:
global RAPATH "C:\....\STATA Course\Exercise\RawData"
*/

global RAWPATH "/Users/kenngarrychua/Desktop/STATA Course/Day 5/Exercise/RawData"
global OUTPATH "/Users/kenngarrychua/Desktop/STATA Course/Day 5/Exercise/OutData"
global FIGPATH "/Users/kenngarrychua/Desktop/STATA Course/Day 5/Exercise/Figures"


/*3. This folder has raw data in Excel (.xls) format for the years 1950-2000 in
intervals of 5 years. Use a loop to convert all of these .xls files into .dta
files. Save the .dta files in the OutData folder. 

Hints:  
- import excel using "${RAPATH}\filename_year.xls", firstrow clear    
- save "${OTPATH}\filename_year.dta"
*/
forvalues k = 1950(5)2000 {
	import excel using "${RAWPATH}/incdec_raw_`k'.xls", firstrow clear  

	save "${OUTPATH}/incdec_`k'.dta", replace
}

/*4. You now have ~11 .dta files which are cross-sections of 1950-2000 in the 
OutData folder. Append these datasets together using a loop. Save the resulting 
panel dataset of countries in the OutData folder.  

Hint:
- You will first have to load one of the 11 in STATA (e.g. 1950)
- Then write a loop to append the rest of them. */

use "${OUTPATH}/incdec_1950.dta", clear

forvalues j = 1955(5)2000 {
		append using "${OUTPATH}/incdec_`j'.dta"
}

/*5. Notice the variables and observations are in disarray. In particular, 
you want to do the following:
- Arrange your variables such that the first variables are country_name
country_code year fh_pr polity popn rgdppc in this order.
- Label the variables fh_pr and polity
- Sort the observations by country_name and year */ 

order country_name country_code year fh_pr polity popn rgdppc

label var fh_pr "Democracy Index 1"
label var polity "Democracy Index 2" 

/*6. Using the -replace- command, rescale gini to be between [0,1] instead of
[0,100]. This is easily achieved by dividing gini by 100. */

replace gini = gini/100

/*7. If you tabulate the variable autoc_score, you will notice that it takes on
integer values between 0 and 10 as well as some negative values. 
Using the -recode- command, set all negative values of democ_score to be
a missing value, while the values 0, 1,..., 10 to 0, 10,..., 100 respectively.

Now suppose you want to do the same recoding for the variable democ_score. Can
you write a loop that applies the same -recode- command to both variables? */

foreach var in democ_score autoc_score {
	recode `var' (-100/-1=.) (1=10) (2=20) (3=30) (4=40) (5=50) ///
				 (6=60) (7=70) (8=80) (9=90) (10=100)
}

/*8. Using -gen- command, generate variables for log(popn) and log(rgdppc). */ 
gen lpopn = log(popn)
gen lrgdppc = log(rgdppc)

/*9. Using -sum- and its associated r-class object, generate normalized 
(i.e. mean 0 and standard deviation 1) version of fh_pr and polity. You may or 
may not choose to use a loop; it's up to you. Bonus points if you did!
Hint: Normalized means (var - meanofvariable) / sdofvariabe. */ 

sum fh_pr
gen fh_pr_normalized = (fh_pr -r(mean)) / r(sd)

sum polity
gen polity_normalized = (fh_pr -r(mean)) / r(sd)

*** Or: 
foreach dem in fh_pr polity {
	sum `dem' 
	gen `dem'_normaliz = (`dem' - r(mean)) / r(sd)
}


/*10. Use the -encode- command to generate a numeric version for country_name.
We will need this when we use -xtset-. Recall -xtset- only accepts numeric 
variables. Hint: We did this in class. */ 

encode country_name, gen(country_numeric) 

/*11. Declare the dataset as a panel of countries using -xtset-. */

xtset country_numeric year 


/*12. Running a regression and exporting its output:

12a) Define three locals for potential regressors  
- first local: log(rgdppc) and dummies for year
- second local: log(rgdppc), log(popn), and dummies for year
- third local: log(rgdppc), log(popn), their interaction, and dummies for year 

12b) Using -xtreg-, regress the normalized polity measure from #9 on each set of 
regressors in #12a. Make sure to have "fe" (fixed effects) as one of the options
and have cluster robust standard errors (vce(cluster country_numeric)). 

12c) Using -outreg2- export the regression results. In particular, keep only
the coefficient for log(rgdppc). The regression result should be exported to
the Figures subfolder under Exercise.

12d) Make sure to use a loop for this. You will also need to use the if and else
conditions as we did in the lecture. */ 


local re1 lrgdppc i.year
local re2 lrgdppc lpopn i.year
local re3 lrgdppc lpopn c.lrgdppc##c.lpopn i.year 

forvalues i=1/3 {
	xtreg polity_normalized `re`i'', fe vce(cluster country_numeric)
	if `i'==1 {
		local outopt "replace"
	}
	else {
		local outopt "append"
	}
	outreg2 using  "${FIGPATH}/mypanelreg.xls", `outopt' keep(lrgdppc)
}
 

/*13. Rerun the entire do-file as a whole. Make sure everything runs without
error. Then save your do file.*/ 
 
