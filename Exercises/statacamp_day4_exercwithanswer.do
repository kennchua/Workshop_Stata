*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 4								  *
********************************************************************************

/*1. Set up this do file. Make sure to clear data in memory, declare version 
number of STATA in use, and use a home path or directory that leads to the 
files you will be using. */ 
clear all
capture log close
set more off
version 13.0

cd "/Users/kenngarrychua/Desktop/STATA Course/Day 4/"

/*2. Load the following dataset: incdec_day4_lec.dta. 
Create a variable for popn and rgdppc in log form. */

use "incdec_day4_lec.dta", clear

gen lpopn=log(popn)
gen lrgdppc=log(rgdppc)

/*3. A simple simulation exercise of democracy levels:

3a) Regress fh_pr on log(rgdppc), log(popn), and educ_avgyears. Make sure to 
add the robust option to get heteroskedasticity-robust standard errors. 

3b) Generate the residuals ("uhat") from this regression.

3c) Use -sum- to get the the mean and sd of the residuals variable. Recall that
they are stored as r(class) objects. Save them as scalars.

3d) You should generate a new variable called fh_pr_predicted using the -gen-
command and using the following formula:
fh_pr_predicted = coefficient estimate of log(rgdppc)*log(rgdppc) 		+ 
				  coefficient estimate of log(popn)*log(popn) 			+ 
				  coefficient estimate of educ_avgyears*educ_avgyears 	+
				  estimate of constant term + rnormal(mean_3c, sd_3c)
where mean_3c and sd_3c are the scalars from question 3c). 
Hint: You will use the special scalars _b[...] for regression coefficients.
Note: fh_pr_predicted is your model's approximation/simulation of true fh_pr.
Recall: rnormal(p, q) draws a number from a normal dbn with mean p and sd q  

3e) Compare your model prediction (fh_pr_predicted) and actual democracy levels
(fh_pr) using -summarize-. Are they similar?  */

reg fh_pr lrgdppc lpopn educ_avgyears, robust

predict uhat, resid

summ uhat 

scalar mean_3c=r(mean)
scalar sd_3c=r(sd)

gen fh_pr_predicted = _b[lrgdppc]*lrgdppc + _b[lpopn]*lpopn + ///
					_b[educ_avgyears]*educ_avgyears + _b[_cons] + /// 
					rnormal(mean_3c, sd_3c)

sum fh_pr fh_pr_predicted 

*Note: Our model is pretty bad. 


/*4. Some matrix exercises:
4a) Create the following matrix myMAT= (1,2,3\4,rnormal(-5, 1),6\7,8,9)
4b) Can you generate a variable that is equal to the element in the 2nd row
and 2nd column of your matrix? Note you must obtain this element NOT by eyeing
the contents of the matrix but by referring to the element using what we learned
in class today about referring to a matrix element.
4c) Now display the matrix myMAT. Is the value on the 2nd row and 2nd column of
the matrix in the results window the same as the one stored on your variable? */
matrix myMAT=(1,2,3\4,rnormal(-5, 1),6\7,8,9)

gen MAT22 = myMAT[2,2]

matrix list myMAT
summ MAT22

*Note: You will not all have the same myMAT[2,2] because this is a random var. 


/*5. Can you create a scatter plot with fh_pr on the y-axis and log(rgdppc)
on the x-axis? Label the axes. Provide a subtitle (NOT a title) for the graph. 
(e.g. "Freedom House Measure") Superimpose a linear fit (-lfit-) on the
scatter plot. Save the graph as a .gph file. */

#delimit ;
graph twoway (lfit fh_pr lrgdppc) ||  (scatter fh_pr lrgdppc,
			msymbol(o) mcolor(erose)			/* options for scatter */
			subtitle("Freedom House Measure")	/* for subtitle */
			ytitle("Measure of Democracy")		/* y-axis title */
			xtitle("Log Real GDP per capita"));	/* x-axis title */

graph save incdem_fh, replace;
#delimit cr 

/*6. Can you create a scatter plot with polity on the y-axis and log(rgdppc)
on the x-axis? Label the axes. Provide a subtitle (NOT a title) for the graph. 
(e.g. "Polity Measure")  Superimpose a linear fit (-lfit-) on the
scatter plot. Save the graph as a .gph file. */

#delimit ;
graph twoway (lfit polity lrgdppc) ||  (scatter polity lrgdppc,
			msymbol(t) mcolor(eltgreen)			/* marker  */
			subtitle("Polity Measure")			/* for subtitle */
			ytitle("Measure of Democracy")		/* y-axis title */
			xtitle("Log Real GDP per capita"));	/* x-axis title */ 

graph save incdem_p, replace;
#delimit cr 

/*7. Can you combine the two previous scatter plots? Provide a common title to
the combined graph (e.g. "Income and Democracy"). Save this graph as .png. */

graph combine incdem_fh.gph incdem_p.gph, ycommon ///
			  title("Income and Democracy") 
			  
graph export "incdem_fh_and_p.png", as(png) replace


/*8. Close your log file. Save your do file. Can you re-run your code 
and reproduce all of your results (including log file and graphs) 
with no errors? */ 
log close 
