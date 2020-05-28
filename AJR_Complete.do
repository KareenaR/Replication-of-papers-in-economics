*Name: Kareena Satia

*Paper: The Colonial Origins of Comparative Development: An Empirical Investigation
*Author(s): Daron Acemoglu, Simon Johnson, James A. Robinson
*Source: The American Economic Review, Vol. 91, No. 5 (Dec., 2001), pp. 1369-1401
*Published by: American Economic Association
*Stable URL: http://www.jstor.org/stable/2677930

*The following codes attempt to replicate some of the important results from the paper. 

**********TABLE 1 - DESCRIPTIVE STATISTICS**************

clear
use "C:\Users\18575\Downloads\Programming\Replication\table1.dta"

label var euro1900 "European settlements in 1900"
label var avexpr "Average protection against expropriation risk, 1985-1995"
label var logpgp95 "Log GDP per capita (PPP) in 1995"
label var cons1 "Constraint on executive in first year of independence"
label var cons90 "Constraint on executive in 1990"
label var democ00a "Democracy in 1900"
label var cons00a "Constraint on executive in 1900"
label var logem4 "Log European settler mortality"
label var loghjypl "Log output per worker in 1988 (with level of United States normalized to 1)"

*Column 1 - Whole world*
estpost sum logpgp95 loghjypl avexpr cons90 cons00a cons1 democ00a euro1900 logem4
eststo m1 


keep if baseco==1

*Column 2 - Base sample* 
estpost sum logpgp95 loghjypl avexpr cons90 cons00a cons1 democ00a euro1900 logem4
eststo m2
drop if extmort4== .
drop if logpgp95 == .
drop if avexpr == .
drop if excolony == 0

*Columns 3 - 6 (quartiles of mortality)
estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 < 65.4 
eststo q1
estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 >= 65.4 & extmort4 < 78.1
eststo q2
estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 >= 78.1 & extmort4 < 280
eststo q3
estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 >= 280 
eststo q4

*Latex export*
esttab m1 m2 q1 q2 q3 q4 using desc1, booktabs style(tex) label nostar main(mean) aux(sd) nonumbers replace

*******FIGURE 2 - OLS GRAPH********************

clear
use "C:\Users\18575\Downloads\Programming\Replication\table2.dta"

graph set window fontface "Times New Roman"

*OLS graph
graph twoway scatter logpgp95 avexpr if !missing(logpgp95, avexpr), mlabel(shortnam) mcolor(white) msize(0) mlabcolor(black) || lfit logpgp95 avexpr, ylabel(4(2)10) ytitle("Log GDP per capita, PPP, 1995") xtitle("Average Expropriation Risk 1985-95") lcolor(black) legend(off) b1title("FIGURE 2. OLS RELATIONSHIP BETWEEN EXPROPRIATION RISK AND INCOME", size(small)) plotregion(fcolor(white)) graphregion(fcolor(white))

*Latex export graph
graph export filename, as(eps) preview(off) replace
!epstopdf filename


******TABLE 2 - OLS REGRESSION********

clear
use "C:\Users\18575\Downloads\Programming\Replication\table2.dta"

*Label variables*
label var avexpr "Average protection against expropriation risk, 1985-1995"
label var lat_abst "Latitude"
label var asia "Asia dummy"
label var africa "Africa dummty"
label var other "Other continent dummy"

*Column 1 - Whole world
reg logpgp95 avexpr, robust
outreg2 using myfile, replace bdec(2) sdec(2) rdec(2) noaster 

*Column 2- Base sample
reg logpgp95 avexpr if baseco == 1, robust 
outreg2 using myfile, append tex bdec(2) sdec(2) rdec(2) noaster 

*Column 3 - Whole world
reg logpgp95 avexpr lat_abst, robust
outreg2 using myfile, append tex bdec(2) sdec(2) rdec(2) noaster 

*Column 4 - Base sample 
reg logpgp95 avexpr lat_abst if baseco == 1, robust
outreg2 using myfile, append tex bdec(2) sdec(2) rdec(2) noaster 

*Column 5 - Whole world 
reg logpgp95 avexpr lat_abst asia africa other, robust
outreg2 using myfile, append tex bdec(2) sdec(2) rdec(2) noaster 

*Column 6 - Base sample
reg logpgp95 avexpr lat_abst asia africa other if baseco == 1, robust
outreg2 using myfile, append tex bdec(2) sdec(2) rdec(2) noaster 

*Column 7 - Whole world
reg loghjypl avexpr, robust
outreg2 using myfile, append tex bdec(2) sdec(2) rdec(2) noaster 

*Column 8 - Base sample
reg loghjypl avexpr if baseco == 1, robust
outreg2 using myfile, append tex bdec(2) sdec(2) rdec(2) noaster 

****TABLE 3 - DETERMINANTS OF INSTITUTIONS*****

clear
use "C:\Users\18575\Downloads\Programming\Replication\table3.dta"

keep if excolony==1
keep if extmort4!=.
gen euro19 = euro1900/100

*Panel A*

*Column 1
reg  avexpr cons00a 
outreg2 using table3, replace bdec(2) sdec(2) noaster

*Column 2
reg  avexpr lat_abst cons00a 
outreg2 using table3, append tex bdec(2) sdec(2) noaster

*Column 3
reg  avexpr democ00a 
outreg2 using table3, append tex bdec(2) sdec(2) noaster

*Column 4
reg  avexpr democ00a lat_abst
outreg2 using table3, append tex bdec(2) sdec(2) noaster 

*Column 5
reg  avexpr indtime cons1 
outreg2 using table3, append tex bdec(2) sdec(2) noaster

*Column 6
reg  avexpr indtime cons1 lat_abst 
outreg2 using table3, append tex bdec(2) sdec(2) noaster

*Column 7
reg  avexpr euro19 
outreg2 using table3, append tex bdec(2) sdec(2) noaster

*Column 8
reg  avexpr euro19 lat_abst 
outreg2 using table3, append tex bdec(2) sdec(2) noaster

*Column 9
reg  avexpr logem4 if logpgp95!=.
outreg2 using table3, append tex bdec(2) sdec(2) noaster

*Column 10
reg  avexpr logem4 lat_abst if logpgp95!=.
outreg2 using table3, append tex bdec(2) sdec(2) noaster


*****Panel B******

*Column 1
reg cons00a euro19 if logpgp95~=.
outreg2 using panelb, replace bdec(2) sdec(2) noaster

*Column 2
reg cons00a euro19 lat_abst if logpgp95!=.
outreg2 using panelb, append tex bdec(2) sdec(2) noaster

*Column 3
reg  cons00a logem4 
outreg2 using panelb, append tex bdec(2) sdec(2) noaster

*Column 4
reg  cons00a lat_abst logem4
outreg2 using panelb, append tex bdec(2) sdec(2) noaster
 
*Column 5
reg democ00a euro19 if logpgp95!=.
outreg2 using panelb, append tex bdec(2) sdec(2) noaster

*Column 6
reg democ00a lat_abst euro19 if logpgp95!=.
outreg2 using panelb, append tex bdec(2) sdec(2) noaster

*Column 7
reg democ00a logem4 if logpgp95!=.
outreg2 using panelb, append tex bdec(2) sdec(2) noaster

*Column 8
reg democ00a lat_abst logem4 if logpgp95!=.
outreg2 using panelb, append tex bdec(2) sdec(2) noaster

*Column 9
reg euro19 logem4 if logpgp95!=.
outreg2 using panelb, append tex bdec(2) sdec(2) noaster

*Column 10
reg euro19 lat_abst logem4 if logpgp95!=.
outreg2 using panelb, append tex bdec(2) sdec(2) noaster


*****TABLE 4 - IV REGRESSION*******

clear 
use "C:\Users\18575\Downloads\Programming\Replication\table4.dta"

*Label Variables*

label var avexpr "Average protection against expropriation risk, 1985-1995"
label var lat_abst "Latitude"
label var asia "Asia dummy"
label var africa "Africa dummy"

keep if baseco == 1

*PANEL A - 2SLS*

*Column 1
ivregress 2sls logpgp95 (avexpr=logem4)
outreg2 using IV, replace bdec(2) sdec(2) rdec(2) noaster

*Column 2
ivregress 2sls logpgp95 (avexpr=logem4) lat_abst
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 3
ivregress 2sls logpgp95 (avexpr=logem4) if rich4!=1
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 4
ivregress 2sls logpgp95 (avexpr=logem4) lat_abst if rich4!=1
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

*Columns 5
ivregress 2sls logpgp95 (avexpr=logem4) if africa!=1
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 6 
ivregress 2sls logpgp95 (avexpr=logem4) lat_abst if africa!=1
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

gen othercontdum=0
replace othercontdum=1 if (shortnam=="AUS" | shortnam=="MLT" | shortnam=="NZL")
label var othercontdum "Other continent dummy"

*Column 7 
ivregress 2sls logpgp95 (avexpr=logem4) africa asia othercontdum
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 8*
ivregress 2sls logpgp95 lat_abst (avexpr=logem4) africa asia othercontdum
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 9 
ivregress 2sls loghjypl (avexpr=logem4)
outreg2 using IV, append tex bdec(2) sdec(2) rdec(2) noaster

*PANEL B - FIRST STAGE*

*Column 1* 
reg avexpr logem4
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 2*
reg avexpr logem4 lat_abst
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 3*
reg avexpr logem4 if rich4!=1
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 4*
reg avexpr logem4 lat_abst if rich4!=1
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Columns 5 
reg avexpr logem4 if africa!=1
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 6
reg avexpr logem4 lat_abst if africa!=1
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Columns 7 
reg avexpr logem4 africa asia othercontdum
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 8*
reg avexpr logem4 lat_abst africa asia othercontdum
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 9 
reg avexpr logem4
outreg2 using panelb1, append tex bdec(2) sdec(2) rdec(2) noaster

*Panel C - OLS*

*Column 1 
reg logpgp95 avexpr
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Columm 2
reg logpgp95 lat_abst avexpr
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 3 
reg logpgp95 avexpr if rich4!=1
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Columm 4
reg logpgp95 lat_abst avexpr if rich4!=1
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 5
reg logpgp95 avexpr if africa!=1
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Columm 6
reg logpgp95 lat_abst avexpr if africa!=1
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 7 
reg logpgp95 avexpr africa asia othercontdum
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Columm 8
reg logpgp95 lat_abst avexpr africa asia othercontdum
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster

*Column 9
reg loghjypl avexpr
outreg2 using OLS, append tex bdec(2) sdec(2) rdec(2) noaster


