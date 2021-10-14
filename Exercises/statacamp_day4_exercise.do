*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 4								  *
********************************************************************************

/*1. Set up this do file. Make sure to clear data in memory, declare version 
number of STATA in use, and use a home path or directory that leads to the 
files you will be using. */ 



/*2. Load the following dataset: incdec_day4_lec.dta. 
Create a variable for popn and rgdppc in log form. */



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



/*4. Some matrix exercises:
4a) Create the following matrix myMAT= (1,2,3\4,rnormal(-5, 1),6\7,8,9)
4b) Can you generate a variable that is equal to the element in the 2nd row
and 2nd column of your matrix? Note you must obtain this element NOT by eyeing
the contents of the matrix but by referring to the element using what we learned
in class today about referring to a matrix element.
4c) Now display the matrix myMAT. Is the value on the 2nd row and 2nd column of
the matrix in the results window the same as the one stored on your variable? */




/*5. Can you create a scatter plot with fh_pr on the y-axis and log(rgdppc)
on the x-axis? Label the axes. Provide a subtitle for the graph. 
(e.g. "Freedom House Measure") Superimpose a linear fit (-lfit-) on the
scatter plot. Save the graph as a .gph file. */



/*6. Can you create a scatter plot with polity on the y-axis and log(rgdppc)
on the x-axis? Label the axes. Provide a subtitle for the graph. 
(e.g. "Polity Measure")  Superimpose a linear fit (-lfit-) on the
scatter plot. Save the graph as a .gph file. */



/*7. Can you combine the two previous scatter plots? Provide a common title to
the combined graph (e.g. "Income and Democracy"). Save this graph as .png. */



/*8. Close your log file. Save your do file. Can you re-run your code 
and reproduce all of your results (including log file and graphs) 
with no errors? */ 
