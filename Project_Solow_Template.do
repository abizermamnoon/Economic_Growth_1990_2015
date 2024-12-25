/* Econ 125 Individual Empirical Project */ 
/* Code for Solow Regression Analysis  */ 
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
log using "Empirical_Project_Solow_Output.log", replace  

clear all 		/* Clear memory */
set more off		/* Uninterrupted Scrolling for Results */

* II.A Import Growth Data Dataset
*  Command:  
use "GrowthData.dta", clear



/* II.A.2 Fit Solow Growth model using OLS with Robust standard errors:  
     lgdp_change = b0 + b1*lcapital_change + b2*llabor_change + u 
   Command:  regress {y} {x1} {x2} ... {xk}, robust */
regress lgdp_change lcapital_change llabor_change, robust
   
/* II.B.3.a Generate interaction variables between colonial_origin with 
	lcapital_change and llabor_change */
	
 gen col_lcap = colonial_origin*lcapital_change
 gen col_llabor = colonial_origin*llabor_change
 
/* II.B.3.b Regress lgdp_change on llabor_change, lcapital_change, 
	colonial_origin, and the generated interaction variables using 
	Robust standard errors */
regress lgdp_change lcapital_change llabor_change colonial_origin col_lcap col_llabor, robust

/* II.B.3.d Test the joint significance of colonial_origin and the generated 
	interaction variables in the regression */

test colonial_origin col_lcap col_llabor

   
log close
* End of Do File

