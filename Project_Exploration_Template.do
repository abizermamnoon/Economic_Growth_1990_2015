/* Econ 125 Individual Empirical Project */ 
/* Code for Project Exploration  */ 
/* Abizer Mamnoon */ 
/* 11/21/2023  */

*** Initialization Commands *** 
version 15 		/* Use Stata Version 15 Interpreter */
capture log close	/* Close log (if one is open) */

/* Set Working Directory 
1. Uncomment the appropriate "cd" command depending on your OS.  
   - If you are using Windows, erase the * at the beginning of line 18.  
   - If you are using Windows, erase the * at the beginning of line 21.  
   
2. Update USERNAME to your login's user name. */

/* Windows Working Directory */
cd "C:\Users\abize\OneDrive\Desktop\Econometrics\Empirical_Project"

/* MacOS Working Directory */
* cd "/Users/USERNAME/Desktop/Empirical_Project/"

/* Open new log file in Working Directory */
log using "Empirical_Project_Exploration_Output.log", replace  

clear all 		/* Clear memory */
set more off		/* Uninterrupted Scrolling for Results */

* I.A Import Growth Data Dataset
*  Command:  
use "GrowthData.dta", clear

* I.A.1 Describe variables in the dataset
*  Command:  
describe

* I.A.2 Plot histograms for the cross-section of average changes in gdp, 
*  capital, and labor.  
*  Command:  
histogram lgdp_change 
graph export "lgdp_change.pdf" 

histogram lcapital_change
graph export "lcapital_change.pdf"

histogram llabor_change
graph export "llabor_change.pdf"
*  Command:  graph export "{Export Filename}.pdf" 



* I.A.3 Plot scatterplot matrix for average changes in gdp, capital, and labor.  
*  Command:  
graph matrix lgdp_change lcapital_change llabor_change
*  Command:  
graph export "scat_gcl.pdf" 


* I.B.2 Plot histogram for [treatment] and export it to pdf file
*  Command:  
histogram internet_usage
*  Command:  
graph export "internet_usage.pdf" 


* I.B.3 Plot scatterplot for treatment against average changes in gdp, 
*  capital, and labor.  
*  Command:  scatter [treatment] {variable name}
*  Command:  graph export "{Export Filename}.pdf" 
scatter internet_usage lgdp_change
graph export "intvgdp.pdf" 

scatter internet_usage lcapital_change
graph export "intvcap.pdf" 

scatter internet_usage llabor_change
graph export "intvlabor.pdf" 

* I.B.4 Compute the correlation between treatment variable, % Change in GDP, 
*  and all other variables included in the data set
*  Command:  
correl internet_usage lgdp_change *

* I.B.6 Relabel the selected control variables with simple but descriptive names
*  Command:  
label variable corruption_control "WB corruption control measure"
label variable rule_of_law "WB rule of law measure"
label variable rural_popn_pct "rural pop (% of pop)"
label variable telephone_subs "tel subs (/100 ppl)"
label variable elect_access_rural "access to electricity (% of rural pop)"
label variable internet_usage "% of pop using internet"
label variable lgdp_change "avg GDP growth rate"
label variable internet_usage "% of pop using internet"

describe lgdp_change internet_usage elect_access_rural telephone_subs rural_popn_pct rule_of_law corruption_control

* I.C.1 Compute summary statistics for % change in GDP, % change in Capital 
*  stock, % change in labor supply, [treatment], and your five control variables
* Command:  
tabstat lgdp_change lcapital_change llabor_change internet_usage ///
                corruption_control rule_of_law rural_popn_pct telephone_subs elect_access_rural, ///
                 stats(n mean sd min p5 p25 median p75 p95 max)

* I.C.2 Compute the Correlation matrix for the relevant variables in your study
* Command:  
correl lgdp_change lcapital_change llabor_change internet_usage ///
                corruption_control rule_of_law rural_popn_pct telephone_subs elect_access_rural


log close
* End of Do File

