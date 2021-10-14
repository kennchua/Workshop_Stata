*******************************************************************************
*						Introduction to STATA								  *
*						August 2017 Exercise 2								  *
********************************************************************************

/*1. For this exercise, make sure you have access to the following files:
- incdec_day2_lec_main.dta
- incdec_day2_lec_append.dta
- incdec_day2_lec_merge.dta
*/  


/*2. Set up this do file. Make sure to clear data in memory, declare version 
number of STATA in use, and use a home path or directory that leads to the 
files pertained to in previous item." */ 
clear all
capture log close
set more off
version 13.0

cd "/Users/kenngarrychua/Desktop/STATA Course/Day 2/" 

/*3. Start a log file from this item. */
log using "STATAcamp_Day2.log", replace 


/*4. Load the file incdec_day2_lec_main.dta, which is the year 2000 
cross-section of countries. Generate a variable for log(popn), log(rgdppc),
and squared log(rgdppc). */
use "incdec_day2_lec_main.dta", clear

gen lpopn= log(popn)
gen lrgdppc = log(rgdppc)
gen lgdppc_sq = lrgdppc^2

/*5. Label the following variables and variable values. 
Variables:
- fh_pr as "Freedom House Democracy Index" 
- polity as "Polity Democracy Index"

Variable values: 
- region_geo (as in lecture)
- gini_abovemean==1 as "Highly Unequal" and gini_abovemean==0 as "Unequal"
*/ 

label var fh_pr "Freedom House Democracy Index"
label var polity "Polity Democracy Index"

label define region_geo_l ///
			1 "Eastern Europe and post-Soviet Union" ///
			2 "Latin America" ///
			3 "North Africa and Middle East" ///
			4 "Sub-Saharan Africa" ///
			5 "Western Europe and North America" ///
			6 "East Asia" ///
			7 "South East Asia" ///
			8 "South Asia" ///
			9 "The Pacific (excluding AUS and NZL)" ///
			10 "The Carribean" 
label values region_geo region_geo_l 

label define gini_abovemean_l 0 "Unequal" 1 "Highly unequal"
label values gini_abovemean gini_abovemean_l 

/*6. Check that the following are now true of the data (i.e. no erros):
- region_sh_dem is within reasonable bounds e.g. [0, 1]
- medage is numeric and not string
If they are still present, correct these errors. 
Hint: You will need to use -replace- and -destring- commands. 
*/  

tab region_sh_dem 
replace region_sh_dem=84.21053 if region_sh_dem==900

desc medage
destring medage, replace 

/*7. Your boss tells you that he found valuable data online for the same set of 
countries in your dataset but from other years! He/she provides this file to 
you. Its filename is incdec_day2_lec_append.dta, and he/she asks you to add it 
to your current dataset. */

append using "incdec_day2_lec_append.dta"


/*8. Sort the resulting dataset as follows:
- first by country_name in alphabetical order (A-Z)
- next by year in ascending order  
Then check whether there are duplicates in terms of country_name and year. 
Drop the duplicates. You will need to use the force option. 
What is the commonality of these duplicates if any?
Hint: use -duplicates- command. 
Note: Total number of observations should be 7953 at the end of this item. */ 

gsort+ country_name year 

*duplicates report  
*duplicates drop  

duplicates report country_name year 
duplicates list country_name year in 1/500
duplicates drop country_name year, force  

describe

/*9. Your boss has even better news! He/she found additional variables online 
related to your study! This new info about the countries is contained in the 
file incdec_day2_lec_merge.dta. Merge it to your original dataset. Are there 
countries that weren't matched in the master and using? */ 

merge 1:1 country_name country_code year using "incdec_day2_lec_merge.dta" 
drop _merge
*Note: All are matched!

/*10. Now your boss wants you to generate the simple average of fh_pr and polity 
by region_geo and year. Can you use the -egen- command to do so? */ 

egen fh_pr_mean = mean(fh_pr), by(region_geo year)
egen polity_mean = mean(polity), by(region_geo year)


/*11. THIS IS AN ADVANCED QUESTION. RETURN TO THIS IF YOU HAVE TIME LEFT.

He/she also thinks the population shares by age group (i.e. age_veryyoung
age_young,  age_midage, age_old, age_veryold) of a region is important. 
But this cannot be the simple average and instead must be population weighted. 
Can you use the -collapse- function along with -preserve- and -restore- 
to generate a variable with the weighted average of each of these for a region 
in a particular year? These variables should be given new names (e.g. m_age_vy).
Then save the resulting "variables" (actually, dataset) as a file that will be
merged back to the data you were using as of the end of the previous item.  */ 

preserve
collapse (mean) m_age_vy= age_veryyoung m_age_y = age_young ///
				m_age_mid=age_midage m_age_o=age_old ///
				m_age_vo=age_veryold, by(region_geo year) 

save "incdec_regage_merge.dta", replace
restore				

merge m:1 region_geo year using "incdec_regage_merge.dta"
				
/*12. IF YOU HAVE NOT ANSWERED #11, just reduce the dataset to mean of 
rgdppc and the median of powerdbn_ses by region_geo and year. 

IF YOU HAVE ANSWERED #11, do the following:
Now collapse the resulting dataset into regions and years. We want the
means of the variables you generated from the previous item and rgdppc 
as well as the median of powerdbn_ses. No need to save this dataset. */  

collapse (mean) m_age* rgdppc  ///
		(median) powerdbn_ses, by(region_geo year) 

/*13. You should now have longitudinal data of regions across years. 
Use -reshape- to transform your data to wide form. Then use the same
command to transform it back to long form. */

gsort+ region_geo year

reshape wide m_age_vy m_age_y m_age_mid m_age_vo m_age_o rgdppc ///
			 powerdbn_ses, i(region_geo) j(year)

reshape long m_age_vy m_age_y m_age_mid m_age_vo m_age_o rgdppc	///
			 powerdbn_ses, i(region_geo) j(year)
 
/*14. THIS IS A DATA VISUALIZATION QUESTION. IGNORE FOR NOW.
Can you create a scatter plot with log(rgdppc) on the y-axis and the share
of those of middle aged (30-45) in the region on the x-axis? Label the axes. 
Provide a subtitle for the graph. (e.g. "Age 30-45") Superimpose a quadratic fit
(-qfit-) on the scatter plot. Save the graph as a .png file. */

gen lrgdppc = log(rgdppc) 

graph tw (qfit lrgdppc m_age_mid)  || (scatter lrgdppc m_age_mid), ///
	  title("Income and Middle Age Shares") ///
	  subtitle(Age 30-45) ///
	  ytitle(Log Real GDP per Capita) ///
	  xtitle(Share of Population)
	  
graph export "incdem_m.png", as(png) replace 
		

/*15. THIS IS TO SET UP THE DATA VISUALIZATION QUESTIONS. IGNORE FOR NOW.
Your boss is somewhat fickle / difficult. Now he/she wants you to work 
only with the dataset you had in the first place -  incdec_day2_lec_main.dta. 
Moreover he wants you to keep only the following variables: 
country_name, country_code, year, fh_pr, polity, popn, rgdppc, powerdbn_ses  
He/she also happens to create a variable for popn and rgdppc in log form. 
No need to save the dataset. */

use "incdec_day2_lec_main.dta", clear
keep country_name country_code year fh_pr polity rgdppc popn powerdbn_ses  

gen lrgdppc = log(rgdppc)
gen lpopn = log(popn)  

/*16. THIS IS A DATA VISUALIZATION QUESTION. IGNORE FOR NOW.
Can you create a bar graph comparing median democracy levels (polity) and 
distribution of power by socioeconomic status (powerdbn_ses)? Clean up the 
labels and titles of both y-axis and x-asis. Add a note at the bottom of 
the graph with the following "Source: V-Dem Project". Save graph as .png. */ 

graph bar (median) polity, over(powerdbn_ses, ///
			relabel(1 "Monopoly" 2 " " 3 "Semi-monopoly" 4 " " 5 "Equal")) ///
			title("Democracy and Socioeconomic Equality") ///
			subtitle (" ") ///
			ytitle("Democracy Index") ///
			note("Source: V-Dem project") 

graph export "incdem_p_power.png", as(png) replace
			
/*17. THIS IS A DATA VISUALIZATION QUESTION. IGNORE FOR NOW. 
Can you create a scatter plot with fh_pr on the y-axis and log(rgdppc)
on the x-axis? Label the axes. Provide a subtitle for the graph. 
(e.g. "Freedom House Measure") Superimpose a linear fit (-lfit-) on the
scatter plot. Save the graph as a .gph file. */

#delimit ;
graph twoway (lfit lrgdppc fh_pr) ||  (scatter lrgdppc fh_pr,
			msymbol(o) mcolor(erose)			/* options for scatter */
			subtitle("Freedom House Measure")	/* for subtitle */
			ytitle("Log Real GDP per capita")	/* y-axis title */
			xtitle("Democracy")					/* x-axis title */
			ylabel(5(2)11, labsize(2.65))		/* y-axis label */
			xlabel(0(0.2)1, labsize(2.65))); 	/* x-axis label */ 

graph save incdem_fh, replace;
#delimit cr 

/*18. THIS IS A DATA VISUALIZATION QUESTION. IGNORE FOR NOW.
Can you create a scatter plot with polity on the y-axis and log(rgdppc)
on the x-axis? Label the axes. Provide a subtitle for the graph. 
(e.g. "Polity Measure")  Superimpose a linear fit (-lfit-) on the
scatter plot. Save the graph as a .gph file. */

#delimit ;
graph twoway (lfit lrgdppc polity) ||  (scatter lrgdppc polity,
			msymbol(t) mcolor(eltgreen)			/* options for scatter */
			subtitle("Polity Measure")			/* for subtitle */
			ytitle("Log Real GDP per capita")	/* y-axis title */
			xtitle("Democracy")					/* x-axis title */
			ylabel(5(2)11, labsize(2.5))		/* y-axis label */
			xlabel(0(0.2)1, labsize(2.65))); 	/* x-axis label */ 

graph save incdem_p, replace;
#delimit cr 

/*19. THIS IS A DATA VISUALIZATION QUESTION. IGNORE FOR NOW.
Can you combine the two previous scatter plots? Provide a common title to
the combined graph (e.g. "Income and Democracy"). Save this graph as .png. */   

graph combine incdem_fh.gph incdem_p.gph, ycommon ///
			  title("Income and Democracy") 
			  
graph export "incdem_fh_and_p.png", as(png) replace


/*20. Close your log file. Save your do file. Can you re-run your code 
and reproduce all of your results (including log file and graphs) 
with no errors? */ 
log close 



