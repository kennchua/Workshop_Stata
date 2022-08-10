*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 3								  *
********************************************************************************

/*1. Set up this do file. Make sure to clear data in memory, declare version 
number of STATA in use, and use a home path or directory that leads to the 
folder containing incdec_day3_lec.dta */ 


/*2. Start a log file from this item. */


/*3. Load the file incdec_day3_lec.dta, which is the 5-year panel data
of countries 1950-2000. Generate a variable for log(popn), log(rgdppc), 
squared log(rgdppc), and squared log(popn). */


/*4. Create a variable for country_name that signifies countries in numeric form
Hint: We did this in the lecture! */


/*5. Regression models and postestimation tests:
5a) Use -reg- to regress polity on log(rgdppc), year dummies (i.e. i.year)
and country dummies (i.e. i.c_num). 

5b) Generate your model's predicted values (yhat) of polity.

5c) Use -estat hettest- to check whether your model's error terms are
homoskedastic. */
		
			
/*6. Use the -xtset- command to declare the data as panel or longitudinal. */


/*7. Regression models and exporting their results:
For 7a) - 7d) report cluster robust standard errors (i.e. vce(cl c_num)), and
include year dummies (i.e. i.year) in the model. 
For those using -xtreg- command, include fe (fixed effects) as an option. 

7a) Use -reg- to regress polity on log(rgdppc)
7b) Use -xtreg- to regress polity on log(rgdppc)
7c) Use -xtreg- to regress polity on log(rgdppc), squared log(rgdppc)
7d) Use -xtreg- to regress polity on log(rgdppc), squared log(rgdppc)
	as well as interactions between log(rgdppc) and log(popn) and their main
	effects. Note that aforementioned variables are both continuous variables!

7e) Use -outreg2- to save estimation results as a .doc file. The coefficient 
estimates that should be reported in the .doc file are those of log(rgdppc),
and squared log(rgdppc). */ 


/*8. Close your log file. Save your do file. Can you re-run your entire code 
and reproduce all of your results (including log file) 
with no errors? */   
