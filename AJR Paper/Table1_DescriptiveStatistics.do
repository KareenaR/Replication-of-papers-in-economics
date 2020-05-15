clear
use "C:\Users\18575\Downloads\Programming\Replication\maketable1.dta"
ssc install asdoc

label var euro1900 "European settlements in 1900"
label var avexpr "Average protection against expropriation risk, 1985-1995"
label var logpgp95 "Log GDP per capita (PPP) in 1995"
label var cons1 "Constraint on executive in first year of independence"
label var cons90 "Constraint on executive in 1990"
label var democ00a "Democracy in 1900"
label var cons00a "Constraint on executive in 1900"
label var logem4 "Log European settler mortality"
label var loghjypl "Log output per worker in 1988 (with level of United States normalized to 1)"

estpost sum logpgp95 loghjypl avexpr cons90 cons00a cons1 democ00a euro1900 logem4
eststo m1 


keep if baseco==1

estpost sum logpgp95 loghjypl avexpr cons90 cons00a cons1 democ00a euro1900 logem4
eststo m2
drop if extmort4== .
drop if logpgp95 == .
drop if avexpr == .
drop if excolony == 0

estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 < 65.4 
eststo q1
estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 >= 65.4 & extmort4 < 78.1
eststo q2
estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 >= 78.1 & extmort4 < 280
eststo q3
estpost sum euro1900 avexpr logpgp95 cons1 cons90 democ00a cons00a logem4 loghjypl if extmort4 >= 280 
eststo q4

esttab m1 m2 q1 q2 q3 q4, main(mean) aux(sd) unstack nonote label nonumber mgroups("By quartiles of mortality", pattern(0 0 1 0 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) mtitle("Whole world" "Base sample" "(1)" "(2)" "(3)" "(4)") title("TABLE 1-DESCRIPTIVE STATISTICS")







