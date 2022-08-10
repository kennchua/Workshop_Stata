*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 5								  *
********************************************************************************

/*1. Set up this do file. Make sure to clear data in memory, declare version 
number of STATA in use. Do NOT declare a home folder using cd command.*/ 


/*2. Define three global macros (or simply, globals) that will set the path to 
the subfolders of Day5\Exercises: RawData, OutData, Figures 

Hint: It should look something like this:
global RAPATH "C:\....\STATA Course\Exercise\RawData"
*/


/*3. This folder has raw data in Excel (.xls) format for the years 1950-2000 in
intervals of 5 years. Use a loop to convert all of these .xls files into .dta
files. Save the .dta files in the OutData folder. 

Hints:  
- import excel using "${RAPATH}\filename_year.xls", firstrow clear    
- save "${OTPATH}\filename_year.dta"
*/


/*4. You now have ~11 .dta files which are cross-sections of 1950-2000 in the 
OutData folder. Append these datasets together using a loop. Save the resulting 
panel dataset of countries in the OutData folder.  

Hint:
- You will first have to load one of the 11 in STATA (e.g. 1950)
- Then write a loop to append the rest of them. */



/*5. Notice the variables and observations are in disarray. In particular, 
you want to do the following:
- Arrange your variables such that the first variables are country_name
country_code year fh_pr polity popn rgdppc in this order.
- Label the variables fh_pr and polity
- Sort the observations by country_name and year */ 


/*6. Using the -replace- command, rescale gini to be between [0,1] instead of
[0,100]. This is easily achieved by dividing gini by 100. */


/*7. If you tabulate the variable autoc_score, you will notice that it takes on
integer values between 0 and 10 as well as some negative values. 
Using the -recode- command, set all negative values of democ_score to be
a missing value, while the values 0, 1,..., 10 to 0, 10,..., 100 respectively.

Now suppose you want to do the same recoding for the variable democ_score. Can
you write a loop that applies the same -recode- command to both variables? */



/*8. Using -gen- command, generate variables for log(popn) and log(rgdppc). */ 


/*9. Using -sum- and its associated r-class object, generate normalized 
(i.e. mean 0 and standard deviation 1) version of fh_pr and polity. You may or 
may not choose to use a loop; it's up to you. Bonus points if you did!
Hint: Normalized means (var - meanofvariable) / sdofvariabe. */ 



/*10. Use the -encode- command to generate a numeric version for country_name.
We will need this when we use -xtset-. Recall -xtset- only accepts numeric 
variables. Hint: We did this in class. */ 


/*11. Declare the dataset as a panel of countries using -xtset-. */



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


/*13. Rerun the entire do-file as a whole. Make sure everything runs without
error. Then save your do file.*/ 
 
