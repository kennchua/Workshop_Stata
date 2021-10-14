*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 1								  *
********************************************************************************

/*1. Set up this do file. Make sure to clear data in memory, 
declare version number of STATA in use, and use a home path or directory that
leads to a folder on your PC." */
clear all
capture log close
set more off
version 13.0

cd "/Users/kenngarrychua/Desktop/STATA Course/Day 1/" 

/*2. Start a log file where your output for the day will be stored. */ 
log using "STATAcamp_Day1.log", replace 

/*3. Load incdec_day1_lec.dta on STATA. You should not specify the entire file 
path when doing so. The file incdec_day1_lec.dta should be in your directory. */ 
use "incdec_day1_lec.dta", clear

/*4. List the country_code, country_name, year, and fh_pr in the first 7 rows
of the data set. */
list country_code country_name year fh_pr in 1/7 


/*5. Generate simple summary statistics for fh_pr, polity, educ_avgyears, and 
gini. Using the result, do you sense that there might be errors in the data?
Which variable has a problem? Can we rectify this by replacing the "weird" value 
with a missing value? Hint: What are reasonabe values for these variables? */
sum fh_pr polity educ_avgyears gini

replace educ_avgyears = . if educ_avgyears>=20
replace gini = . if gini<0

/*6. Your codebook reports that democ_score and autoc_score should take on
integer values between 0 and 10. Are there observations that don't fulfill this
criterion? Check by using -tab- command on each variable. Replace these weird 
values w/ a missing value using -replace- for one and -recode- for the other. */
tab democ_score
replace democ_score=. if democ_score<0 | democ_score>=10

tab autoc_score 
recode autoc_score (-100/-50=.)


/*7. Check for duplicates and get rid of them. */
duplicates report 
duplicates list country_name  
duplicates drop
 
/*8. Using the -tabstat- command, check the mean and sd of fh_pr. In one line,
generate a dummy that =1 if country is above the mean fh_pr and =0 otherwise. 
Call this variable fh_pr_abovemean. Account for the fact that fh_pr has missing
values which means fh_pr_abovemean must also be missing for these countries. */
tabstat fh_pr, stat(mean sd)

gen fh_pr_abovemean = (fh_pr>.5608782) 
replace fh_pr_abovemean=. if fh_pr==.

/*9. Display a two-way frequency table of fh_pr_abovemean and gini_abovemean. 
How many countries are really undemocratic (fh_pr abovemean==0) and unequal
(gini_abovemean==1)? Calculate what proportion it is of the total number of 
countries with values for both variables using the -di- command. Then use -di-
to write a comment that says: "The share of countries that are undemocratic and 
unequal is: xx% ", where xx is the percentage you calculated. */ 

tab fh_pr_abovemean gini_abovemean

di 45/135

di "The share of countries that are undemocratic and unequal is: 33.3% "

 
/*10. Often we may  want to normalize continuous variables to have mean 0
and standard deviation 1. Use the egen and gen commands to create a normalized
fh_pr score. Hint: We did something similar in the lecture. */ 
egen fh_pr_mean = mean(fh_pr)
egen fh_pr_sd = sd(fh_pr)
gen fh_pr_std = (fh_pr - fh_pr_mean)/fh_pr_sd

/*11. Again using egen and gen, generate a new variable called popn_sh_world
which divides popn by the total population of the world. Hint: You will use the
-total- function with egen. Use the help file to figure out how it works. */ 
egen popn_world_total = total(popn)
gen popn_sh_world = popn/popn_world_total

 
/*12. Can you generate a new variable that stores the info in the variable
powerdbn_ses as a string? What about the info in democ_score as string? 
Do not replace existing variables. Generate new ones instead.
Did you use different commands? Why? */  
decode powerdbn_ses, gen(powerdbn_ses_str)

tostring democ_score, gen(democ_score_str) 

/*13. Your boss wants a really simple dataset with COMPLETE (i.e. no missing 
values) information on the following variables: country_code, year, fh_pr, 
polity, rgdppc, regiongeo, fh_pr_abovemean. Can you reduce your data to only 
these variables, whilst keeping only those observations with 
non-missing values in all 7 of these variable? Use -describe- to view how
many observations are left in your final dataset. */
keep if fh_pr!=. & polity!=. & rgdppc!=. & region_geo!=. 
keep country_code year fh_pr polity rgdppc region_geo fh_pr_abovemean
describe 

di "The number of observations in this dataset is 146." 

/*14. Save the reduced dataset that you have as a new .xls file. */
export excel "incdec_day_exer.xls", replace firstrow(variables)

/*15. Close your log file. Save your do file. Can you re-run your code 
and reproduce all of your results (including log file and .xls file) 
with no errors? */ 
log close 


  



