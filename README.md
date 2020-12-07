# Utility Files for Stata

This repo contains useful bits of Stata code. Files include:
 * [`label-functions.do`](https://github.com/mackaytc/utility-files-stata/blob/master/label-functions.do): highlights some simple commands related to variable and value labeling
 * [`basic-guide-to-outreg.do`](https://github.com/mackaytc/utility-files-stata/blob/master/basic-guide-to-outreg.do): create easy-to-customize regression tables using `outreg`
 * [`getting-p-values-after-regression.do`](https://github.com/mackaytc/utility-files-stata/blob/master/getting-p-values-after-regression.do): retrieve p-values after running `reg` command in Stata using `ttest` and `r(table)`
 * [`convert-policy-start-dates-to-panel.do`](https://github.com/mackaytc/utility-files-stata/blob/master/convert-policy-start-dates-to-panel.do): convert a list / table of dates some event occurs (e.g. legislation is enacted, a policy is implemented, etc.) into a panel-formatted data set

## Other Helpful Resources

In no particular order:
 * [Stata cheatsheets](https://github.com/mackaytc/utility-files-stata/blob/master/pdf-guides/stata-cheat-sheets.pdf)
 * [A set of useful links](https://sites.google.com/site/mkudamatsu/stata) from Masayuki Kudamatsu
 * [Code and Data for the Social Sciences: A Practitioner’s Guide](https://github.com/mackaytc/utility-files-stata/blob/master/pdf-guides/code-and-data-stata-practitioners-guide.pdf) by Gentzkow and Shapiro (2014) 
 * I really like using Sublime Text as a code editor - [here's a useful guide for getting ST set up with Stata](https://acarril.github.io/posts/use-st3)
 
 ## Workflow Notes
 
 I use the following programs (on a Windows PC) + packages: 
  * [Sublime Text](https://www.sublimetext.com/) for editing `.do` files 
    * Includes useful code highlighting, autocomplete for things like macros that Stata's built-in editor handles poorly, and useful code diff tools
    * For running `.do` files, download the [Stata Editor](https://packagecontrol.io/packages/StataEditor) package and follow installation instructions
  * Useful SSC packages
    * ``egenmore``
    * ``reghdfe``
    * ``outreg``
    * ``fre``
