clear
use "C:\Users\18575\Downloads\Programming\Replication\maketable2.dta"

label var avexpr "Average protection against expropriation risk, 1985-1995"
label var lat_abst "Latitude"
label var asia "Asia dummy"
label var africa "Africa dummty"
label var other "Other continent dummy"


reg logpgp95 avexpr, robust
estimates store m1, title(Whole world) 

reg logpgp95 avexpr if baseco == 1, robust 
estimates store m2, title(Base sample)

reg logpgp95 avexpr lat_abst, robust
estimates store m3, title(Whole world)

reg logpgp95 avexpr lat_abst if baseco == 1, robust
estimates store m4, title(Base sample)

reg logpgp95 avexpr lat_abst asia africa other, robust
estimates store m5, title(Whole world)

reg logpgp95 avexpr lat_abst asia africa other if baseco == 1, robust
estimates store m6, title(Base sample)

reg loghjypl avexpr, robust
estimates store m7, title(Whole world)

reg loghjypl avexpr if baseco == 1, robust
estimates store m8, title(Base sample)

estout m1 m2 m3 m4 m5 m6 m7 m8, cells(b(fmt(2)) se(par fmt(2))) legend label drop(`drop' _cons) stats(r2 N, label(R-squared Number of observations)) numbers mgroups("Dependent variable is log GDP per capita in 1995" "Dependent variable is log output per worker in 1988", pattern(1 0 0 0 0 0 1 0)) title("TABLE 2—OLS REGRESSIONS") 