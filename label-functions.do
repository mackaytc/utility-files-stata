********************************************************************************
* 	Variable and Value Labels
********************************************************************************

*	This file provides a quick highlight of useful commands related to using
*	variable and values labels, listing value labels, etc. 

clear all

sysuse auto

*	We can use 'describe' or 'codebook' to get a sense of what the data looks
*	like (including listing variable + value labels)

codebook

describe 

*	The value label for 'foreign' is 'origin' -- we can list the labels and the 
*	corresponding values using 'label list' 

label list origin 

*	We can use value labels instead of the underlying numerical values when 
*	creating new variables defined in terms of conditional statements over 
*	levels of a factor variable 

gen example = (foreign == "Domestic":origin)

	tabulate example foreign 

*	We can also save a variable label as a local using extended macro fns 

local var_label : variable label foreign

	display "`var_label'"
	
********************************************************************************
* 	End of File
********************************************************************************

capture log close

exit
