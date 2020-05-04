********************************************************************************
*	Translating a Table with Policy Implentation Dates to Panel-Formatted Data
********************************************************************************

*	A common task in applied work is translating a table or list of dates in
*	which something happened - a law was implemented, a policy was ended, etc -
*	into panel-formatted data. The resulting panel data set would list each 
*	treated unit (e.g. state, individual, etc.), a succession of dates, and a 
*	binary indicator for whether or not the relevant event has occurred. 

*	While this sounds straightforward in principle, in practice there are a lot 
* 	of approaches to implementing this, some of which are clearer than others.

clear all

*	For this example, we'll use data on states implemented stay at home (SAHO)
*	orders in response to the Covid-19 pandemic. Data is saved to github in 
*	.csv form (URL shortned using git.io) -- start by downloading it: 

copy "https://git.io/JfGOg" "`c(pwd)'\NYT-SAHO-dates.csv", replace

import delimited "`c(pwd)'\NYT-SAHO-dates.csv", clear

*	Dates for law implementation copied from NYT (4.19.2020) -- see link below: 

*		www.nytimes.com/interactive/2020/us/coronavirus-stay-at-home-order.html

rm "`c(pwd)'\NYT-SAHO-dates.csv"

********************************************************************************
*	Formatting date of implementation variable
********************************************************************************

*	We can start by inspecting the format of the data -- each row corresponds 
*	to a given state + lists the date when that state implemented a SAHO order
*	(note that not all states implemented SAHO)

list in 1/5

*	Date variable is string-formatted, so first thing we need to do is use 
*	Stata's `date' function to convert the SAHO variable into a useable format. 
*	DM20Y specifies format of SAHO with "20Y" indicating 2-digit years occuring
*	in the 2000's. 

gen SAHO_start_date = date(saho, "DM20Y")

*	Format code %td gives human-readable formatting of resulting (numerical) 
*	date variable SAHO_start_date. 

	format SAHO_start_date %td
	
	drop saho 

*	Now generate a variable corresponding to beginning date of the panel we'd
*	like to create

gen start = date("01012020", "DMY")

	format start %td
	
********************************************************************************
*	Expand to panel data set
********************************************************************************

*	Expand creates n new copies of each existing row in the data set
 
expand 120 

*	Now we'll create counter variable below to index successive observations 
*	within a given state and use counter + start date above to convert _n index
*	to date measure relative to start date of panel

bysort statefip : gen counter = _n - 1

gen date = start + counter 

	format date %td

*	Now that we have data variable we can drop intermediate variables below

	drop start counter 
	
*	Policy measure is then set equal to 0 when no policy is in effect for a 
*	given state + day and equal to 1 when the state has a policy implemented

gen SAHO_in_place = (date >= SAHO_start_date)

	la var SAHO_in_place "Indicator for Given State Having a SAHO in Effect"

	browse

********************************************************************************
* 	End of File
********************************************************************************

capture log close

exit
