clear
use "C:\Users\18575\Downloads\Programming\Replication\maketable2.dta"



graph twoway scatter logpgp95 avexpr if !missing(logpgp95, avexpr), mlabel(shortnam) mcolor(white) msize(0) mlabcolor(black) || lfit logpgp95 avexpr, ylabel(4(2)10) ytitle("Log GDP per capita, PPP, 1995") xtitle("Average Expropriation Risk 1985-95") lcolor(black) legend(off) b1title("FIGURE 2. OLS RELATIONSHIP BETWEEN EXPROPRIATION RISK AND INCOME", size(small)) 
