*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 2								  *
********************************************************************************

/*1. Select a folder that will serve as your home directory. Make sure to have 
the following files inside: (you may use the one we've been working with)
- incdec_day2_lec_main.dta
- incdec_day2_lec_append.dta
- incdec_day2_lec_merge.dta
*/  


/*2. Set up this do file. Make sure to clear data in memory, declare version 
number of STATA in use, and use a home path or directory that leads to the 
files pertained to in previous item." */ 


/*3. Start a log file from this item. */


/*4. Load the file incdec_day2_lec_main.dta, which is the year 2000 
cross-section of countries. Generate a variable for log(popn), log(rgdppc),
and squared log(rgdppc). */


/*5. Label the following variables and variable values. 
Variables:
- fh_pr as "Freedom House Democracy Index" 
- polity as "Polity Democracy Index"

Variable values: 
- region_geo (as in lecture)
- gini_abovemean==1 as "Highly Unequal" and gini_abovemean==0 as "Unequal"
*/ 



/*6. Check that the following are now true of the data (i.e. no erros):
- region_sh_dem is within reasonable bounds e.g. [0, 100]
- medage is numeric and not string
If they are still present, correct these errors. 
Hint: You will need to use -replace- and -destring- commands. 
*/  



/*7. Your boss tells you that he found valuable data online for the same set of 
countries in your dataset but from other years! He/she provides this file to 
you. Its filename is incdec_day2_lec_append.dta, and he/she asks you to add it 
to your current dataset. */



/*8. Sort the resulting dataset as follows:
- first by country_name in alphabetical order (A-Z)
- next by year in ascending order  
Then check whether there are duplicates. Hint: use -duplicates- command. 
Drop the duplicates. What is the commonality of these duplicates if any?
Note: Total number of observations should be 7953 at the end of this item. */ 



/*9. Your boss has even better news! He/she found additional variables online 
related to your study! This new info about the countries is contained in the 
file incdec_day2_lec_merge.dta. Merge it to your original dataset. Are there 
countries that weren't matched in the master and using? */ 



/*10. Now your boss wants you to generate the simple average of fh_pr and polity 
by region_geo and year. Can you use the -egen- command to do so? */ 



/*11. THIS IS AN ADVANCED QUESTION. RETURN TO THIS IF YOU HAVE TIME LEFT.

He/she also thinks the population shares by age group (i.e. age_veryyoung
age_young,  age_midage, age_old, age_veryold) of a region is important. 
But this cannot be the simple average and instead must be population weighted. 
Can you use the -collapse- function along with -preserve- and -restore- 
to generate a variable with the weighted average of each of these for a region 
in a particular year? These variables should be given new names (e.g. m_age_vy).
Then save the resulting "variables" (actually, dataset) as a file that will be
merged back to the data you were using as of the end of the previous item.  */ 


/*12. IF YOU HAVE NOT ANSWERED #11, just reduce the dataset to mean of 
rgdppc and the median of powerdbn_ses by region_geo and year using -collapse-. 


IF YOU HAVE ANSWERED #11, do the following:
Now collapse the resulting dataset into regions and years. We want the
means of the variables you generated from the previous item and rgdppc 
as well as the median of powerdbn_ses. No need to save this dataset. */  



/*13. You should now have longitudinal data of regions across years. 
Use -reshape- to transform your data to wide form. Then use the same
command to transform it back to long form. */

		

/*20. Close your log file. Save your do file. Can you re-run your code 
and reproduce all of your results (including log file and graphs) 
with no errors? */ 



