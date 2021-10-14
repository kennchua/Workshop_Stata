*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 1								  *
********************************************************************************

/*1. Set up this do file. Make sure to clear data in memory, 
declare version number of STATA in use, and use a home path or directory that
leads to a folder on your PC." */ 


/*2. Start a log file where your output for the day will be stored. */ 


/*3. Load incdec_day1_lec.dta on STATA. You should not specify the entire file 
path when doing so. The file incdec_day1_lec.dta should be in your directory. */ 


/*4. List the country_code, country_name, year, and fh_pr in the first 7 rows
of the data set. */


/*5. Generate simple summary statistics for fh_pr, polity, educ_avgyears, and 
gini. Using the result, do you sense that there might be errors in the data?
Which variable has a problem? Can we rectify this by replacing the "weird" value 
with a missing value? Hint: What are reasonabe values for these variables? */


/*6. Your codebook reports that democ_score and autoc_score should take on
integer values between 0 and 10. Are there observations that don't fulfill this
criterion? Check by using -tab- command on each variable. Replace these weird 
values w/ a missing value using -replace- for one and -recode- for the other. */


/*7. Check for duplicates and get rid of them. */


/*8. Using the -tabstat- command, check the mean and sd of fh_pr. In one line,
generate a dummy that =1 if country is above the mean fh_pr and =0 otherwise. 
Call this variable fh_pr_abovemean. Account for the fact that fh_pr has missing
values which means fh_pr_abovemean must also be missing for these countries. */


/*9. Display a two-way frequency table of fh_pr_abovemean and gini_abovemean. 
How many countries are really undemocratic (fh_pr abovemean==0) and unequal
(gini_abovemean==1)? Calculate what proportion it is of the total number of 
countries with values for both variables using the -di- command. Then use -di-
to write a comment that says: "The share of countries that are undemocratic and 
unequal is: xx% ", where xx is the percentage you calculated. */ 

 
/*10. Often we may  want to normalize continuous variables to have mean 0
and standard deviation 1. Use the egen and gen commands to create a normalized
fh_pr score. Hint: We did something similar in the lecture. */ 


/*11. Again using egen and gen, generate a new variable called popn_sh_world
which divides popn by the total population of the world. Hint: You will use the
-total- function with egen. Use the help file to figure out how it works. */ 

 
/*12. Can you generate a new variable that stores the info in the variable
powerdbn_ses as a string? What about the info in democ_score as string? 
Do not replace existing variables. Generate new ones instead.
Did you use different commands? Why? */  


/*13. Your boss wants a really simple dataset with COMPLETE (i.e. no missing 
values) information on the following variables: country_code, year, fh_pr, 
polity, rgdppc, regiongeo, fh_pr_abovemean. Can you reduce your data to only 
these variables, whilst keeping only those observations with 
non-missing values in all 7 of these variable? Use -describe- to view how
many observations are left in your final dataset. */


/*14. Save the reduced dataset that you have as a new .xls file. */


/*15. Close your log file. Save your do file. Can you re-run your code 
and reproduce all of your results (including log file and .xls file) 
with no errors? */ 

