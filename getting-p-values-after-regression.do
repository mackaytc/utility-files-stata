********************************************************************************
* 	Storing P-Values After Estimation
********************************************************************************

*	After running "reg" Stata stores coefficients and standard errors as macros
*	that can be accessed using "_b[varname]" and "_se[varname]". But getting
*	p-values isn't quite as direct. This do file demonstrates two different 
*	ways of outputting p-values after a regression command.

clear all

sysuse auto

reg price weight length

********************************************************************************
* 	Method One: Use the "ttail" function
********************************************************************************

*	We'll just the estimated beta + SE for the constant term below -- note that
*	its easy to recover beta + coefficient here. 

local tstat = (_b[_cons]/_se[_cons])

local pval = round((2 * ttail (e(df_r)), abs(`tstat')), 0.001)

*	Now we can display our display p-value

di "`pval'"

********************************************************************************
* 	Method Two: Use the stored matrix output results
********************************************************************************

*	Matrix r(table) below gives betas, SE's, t-values, p-values, etc. stored 
*	as rows for each RHS variable stored as columns. We can store these results
*	as a matrix to access p-values. 

matrix def A = r(table)

mat list A

local pval = round(A[4,3], 0.001)

di "`pval'"

*	The method above is fine in this context, but what if we have lots of 
*	covariates? Subsetting by numerical indexes isn't as covenient as by name, 
*	so we can use "rownumb" + "colnumb" functions to identify numerical indices
*	(which is what Stata is looking for).

local pval = round(A[rownumb(A, "pvalue"), colnumb(A, "_cons")], 0.001)

di "`pval'"

********************************************************************************
* 	End of File
********************************************************************************

capture log close

exit
