/* Econ 125 Empirical Project */ 
/* Code for Regression Analysis  */ 
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
log using "Empirical_Project_Treatment_Output.log", replace  

clear all 		/* Clear memory */
set more off		/* Uninterrupted Scrolling for Results */

* Import Consolidated Growth and Country Data
*   Command:  use {filename}
use "GrowthData.dta", clear

/* III.A.3 Estimate a simple regression of gdp change on [treatment] 
	with Robust standard errors:  
     lgdp_change = b0 + b1*[treatment] + u 
   Command:  regress {y} {x1} {x2} ... {xk}, robust */
regress lgdp_change internet_usage, robust
   
/* III.A.5 Estimate a simple regression of capital change on [treatment] 
	with Robust standard errors:  
     lcapital_change = b0 + b1*[treatment] + u 
   Command:  regress {y} {x1} {x2} ... {xk}, robust */
reg lcapital_change internet_usage, robust
   
/* III.A.7 Estimate a simple regression of labor force supply change on 
	[treatment] with Robust standard errors:  
     llabor_change = b0 + b1*[treatment] + u 
   Command:  regress {y} {x1} {x2} ... {xk}, robust */
regress llabor_change internet_usage, robust
   
/* III.B.1 Install outreg2 package*/
ssc install outreg2

/* III.B.1.a Re-estimate a simple regression of gdp change on [treatment] 
	with Robust standard errors:  
     lgdp_change = b0 + b1*[treatment] + u 
   Command:  regress {y} {x1} {x2} ... {xk}, robust */
regress lgdp_change internet_usage, robust
   
   
/* III.B.1.b Use outreg2 to store the regression outputs in a Word doc
   Command:  outreg2 using "TreatmentRegs.doc", replace ///
					ctitle(Simple Model) label */
outreg2 using "TreatmentRegs.doc", replace ///
					ctitle(Simple Model) label
					
/* III.B.2.a Estimate the Solow Regression for gdp change adding [treatment] 
	with lcapital_change and llabor_change, with Robust standard errors:  
     lgdp_change = b0 + b1*[treatment] + b2*lcapital_change 
						+ b3*llabor_change + u  */
reg lgdp_change internet_usage lcapital_change llabor_change, robust
      
/* III.B.2.b Use outreg2 to append the regression outputs to the Word doc
   Command:  outreg2 using "TreatmentRegs.doc", append ///
					ctitle(Solow Model) label */
outreg2 using "TreatmentRegs.doc", append ///
					ctitle(Solow Model) label
					
/* III.B.3.a Estimate a multiple regression of gdp change on [treatment], 
	including only the control variables from :  
     lgdp_change = b0 + b1*[treatment] + b2*[control1] + ...
						+ b6*[control5] + u */
regress lgdp_change internet_usage corruption_control rule_of_law rural_popn_pct telephone_subs elect_access_rural, robust
/* III.B.3.b Use outreg2 to append the regression outputs to the Word doc
   Command:  outreg2 using "TreatmentRegs.doc", append ///
					ctitle(Controlled Model) label */
outreg2 using "TreatmentRegs.doc", append ///
					ctitle(Controlled Model) label
		
/* III.B.4.a Estimate a multiple regression of gdp change on [treatment], 
	including only the control variables from :  
     lgdp_change = b0 ++ b1*[treatment] + b2*lcapital_change 
						+ b3*llabor_change + b4*[control1] + ...
						+ b8*[control5] + u */
regress lgdp_change internet_usage lcapital_change llabor_change corruption_control rule_of_law rural_popn_pct telephone_subs elect_access_rural, robust
/* III.B.4.b Use outreg2 to append the regression outputs to the Word doc
   Command:  outreg2 using "TreatmentRegs.doc", append ///
					ctitle(Solow with Controls) label */
outreg2 using "TreatmentRegs.doc", append ///
					ctitle(Solow with Controls) label
 
log close
* End of Do File

