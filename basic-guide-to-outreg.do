********************************************************************************
*   Overview
********************************************************************************

*	'Outreg' is a SSC package used for generating tables of regression output.
*	While other packages + built-in functions can accomplish the same task, I 
*	find outreg a bit more intuitive, and substantially easier to use when you 
*	want to do anything "non-standard." 

*	Start by installing package

*	ssc install outreg

********************************************************************************
*   Setting File-Level Macros
********************************************************************************

*	One advantage of outreg (for me at least) is that the way options like 
*	formatting are specified is  more verbose + transparent than the 'est' 
*	family of functions (which can be mystifying). Below, I define globals that
*	specify formatting options that I use cosistently for all tables, so having 
*	them defined here saves clutter + makes formatting tweaks easier later.

    # d ;   
  
global outreg_opts "starlevel(10 5 1) sigsymb(*,**,***) se bdec(3) 
                    summstat(N) summdec(0 5) varlabels
                    summtitle("{\i Observations}") 
                    starloc(1) titlfont(fs10) basefont(fs8) coljust(l{c})"; 
                                        
global sig_levels  "* p<0.10; ** p<0.05; *** p<0.01"; 

    # d cr 

********************************************************************************
*   Loading Auto Data + Running Regressions
********************************************************************************

*	For this example, we'll use Stata's 'auto' example data set. In the code 
*	below, we'll use the 'estimates store' == 'est sto' command to save the 
*	results from running each regression below. Our goal is to create two tables
*	with the output saved to a .rtf formatted-document. 

sysuse auto, clear

*	TABLE I:  Just 1 row + 1 columns here then two rows in TABLE II below

eststo n1: reg mpg displacement, robust

eststo n2: reg mpg displacement weight, robust

*	TABLE II: First row will be regressing price on covariates...

eststo m1: reg price weight length, robust

eststo m2: reg price weight length i.rep78, robust

*	TABLE II: ...then second row will be regressing mpg on covariates

eststo m3: reg mpg weight length, robust

eststo m4: reg mpg weight length i.rep78, robust

********************************************************************************
*   Using Outreg to Create .rtf Document with Regression Output
********************************************************************************

    # d ;  

*	Generate first table then export it as a .rtf file -- a couple of things to 
*	note at this stage. First, we are going to save each cell of the table to 
*	an outreg object named "t1r1" so we want to clear that before starting; 
    
outreg, clear(t1r1);

est restore n1;

*	Now we restore our first regression results, keep the coefficients we want, 
*	and use 'merge' option begin building the first row + column of results; 
    
    outreg, keep(displacement) merge(t1r1) ctitle("" "(1)") ${outreg_opts};

est restore n2;

*	Second set of results forms the second column (specified using ctitle 
*	option) in first row; 
    
    outreg, keep(displacement) merge(t1r1) ctitle("" "(2)") ${outreg_opts};

*	Now we'll create the .rtf document (note use of 'replace' option here) and
*	output first table -- options here include 'replay' which kicks out the t1r1 
*	row of results created above, 'hlines' specify where horizontal lines should
*	appear in text, and we can easily add titles + notes + additional rows of
*	explanatory text; 

outreg using "~/Desktop/outreg-example-tables.rtf", replace
    keep(displacement)
    replay(t1r1)  
    hlines(11000101)
    ${outreg_opts} 
    title("{\scaps \fs24 Table I:} Outreg Example First Table")
    addrows("{\b Controls}", "", "" \
     		"Weight", "No", "Yes")
    note("Robust errors clustered at reported in parentheses."); 

*	Then export the second table and add it as second page to file above -- 
*	process is similiar, but now we have two rows of results; 

outreg, clear(t2r1);
outreg, clear(t2r2);

est restore m1;
    
    outreg, keep(weight length) merge(t2r1) ctitle("" "(1)") ${outreg_opts};

est restore m2;
    
    outreg, keep(weight length) merge(t2r1) ctitle("" "(2)") ${outreg_opts};

est restore m3;
    
    outreg, keep(weight length) merge(t2r2) ctitle("" "(1)") ${outreg_opts};

est restore m3;
    
    outreg, keep(weight length) merge(t2r2) ctitle("" "(2)") ${outreg_opts};

*	This is where we combine rows 1 (t2r1) and 2 (t2r2) to form a matrix of 
*	regression results using the 'append' option; 

outreg, replay(t2r1) append(t2r2);

*	Finally, export the second table using 'append' so that Table II is added
*	below Table I in the .rtf document; 

outreg using "~/Desktop/outreg-example-tables.rtf", append 
    keep(weight length)
    replay(t2r1)  
    ${outreg_opts} 
    hlines(11000010000101)
    title("{\scaps \fs24 Table II:} Outreg Example Second Table")
    addrows("{\b Controls}", "", "" \
     		"Rep78 Fixed Effect", "No", "Yes")
    note("Robust errors clustered at reported in parentheses."); 

    # d cr

********************************************************************************
*	End of File
********************************************************************************

capture log close 

exit 
