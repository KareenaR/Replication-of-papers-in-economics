clear 
use "C:\Users\18575\Downloads\Programming\Replication\maketable4.dta"

*Label Variables*

label var avexpr "Average protection against expropriation risk, 1985-1995"
label var lat_abst "Latitude"
label var asia "Asia dummy"
label var africa "Africa dummy"

keep if baseco == 1

*PANEL A - 2SLS*

*Column 1*
asdoc ivregress 2sls logpgp95 (avexpr=logem4), replace nest save(IV) label drop(`drop' _cons)

*Column 2*
asdoc ivregress 2sls logpgp95 (avexpr=logem4) lat_abst, nest save(IV) label drop(`drop' _cons)

*Column 3*
asdoc ivregress 2sls logpgp95 (avexpr=logem4) if rich4!=1, nest save(IV) label drop(`drop' _cons)

*Column 4*
asdoc ivregress 2sls logpgp95 (avexpr=logem4) lat_abst if rich4!=1, nest save(IV) label drop(`drop' _cons)

*Columns 5* (Base Sample w/o Africa)
asdoc ivregress 2sls logpgp95 (avexpr=logem4) if africa!=1, nest save(IV) label drop(`drop' _cons)

*Column 6 (Base Sample w/o Africa)*
asdoc ivregress 2sls logpgp95 (avexpr=logem4) lat_abst if africa!=1, nest save(IV) label drop(`drop' _cons)

gen other_cont=0
replace other_cont=1 if (shortnam=="AUS" | shortnam=="MLT" | shortnam=="NZL")
tab other_cont 
label var other_cont "Other continent dummy"

*Column 7 (Base sample with continent dummies)
asdoc ivregress 2sls logpgp95 (avexpr=logem4) africa asia other_cont, nest save(IV) label drop(`drop' _cons)

*Column 8*
asdoc ivregress 2sls logpgp95 lat_abst (avexpr=logem4) africa asia other_cont, nest save(IV) drop(`drop' _cons)

*Column 9 (Base Sample, log GDP per worker)
asdoc ivregress 2sls loghjypl (avexpr=logem4), nest save(IV) label drop(`drop' _cons)wide 


*PANEL B - FIRST STAGE*

*Column 1* 
asdoc reg avexpr logem4, rowappend save(IV) drop(`drop' _cons)

*Column 2*
asdoc reg avexpr logem4 lat_abst, nest save(IV) drop(`drop' _cons)

*Column 3*
asdoc reg avexpr logem4 if rich4!=1, nest save(IV) drop(`drop' _cons)

*Column 4*
asdoc reg avexpr logem4 lat_abst if rich4!=1, nest save(IV) drop(`drop' _cons)

*Columns 5* (Base Sample w/o Africa)
asdoc reg avexpr logem4 if africa!=1, nest save(IV) drop(`drop' _cons)

*Column 6* (Base Sample w/o Africa )
asdoc reg avexpr logem4 lat_abst if africa!=1, nest save(IV) drop(`drop' _cons)

*Columns 7(Base Sample with continent dummies)
asdoc reg avexpr logem4 africa asia other_cont, nest save(IV) drop(`drop' _cons)

*Column 8*
asdoc reg avexpr logem4 lat_abst africa asia other_cont, nest save(IV) drop(`drop' _cons)

*Column 9 (Base Sample, log GDP per worker)
asdoc reg avexpr logem4, nest save(IV) drop(`drop' _cons)




**********************************
*--Panel C, OLS Regressions
**********************************

*Columns 1 - 2 (Base Sample)

asdoc reg logpgp95 avexpr, append save(IV) label drop(`drop' _cons)
asdoc reg logpgp95 lat_abst avexpr, nest save(IV) label drop(`drop' _cons)


*Columns 3 - 4 (Base Sample w/o Neo-Europes)

asdoc reg logpgp95 avexpr if rich4!=1, nest save(IV) label drop(`drop' _cons)
asdoc reg logpgp95 lat_abst avexpr if rich4!=1, nest save(IV) label drop(`drop' _cons)


*Columns 5 - 6 (Base Sample w/o Africa)

asdoc reg logpgp95 avexpr if africa!=1, nest save(IV) label drop(`drop' _cons)
asdoc reg logpgp95 lat_abst avexpr if africa!=1, nest save(IV) label drop(`drop' _cons)


*Columns 7 - 8 (Base Sample with continent dummies)

asdoc reg logpgp95 avexpr africa asia other_cont, nest save(IV) label drop(`drop' _cons)
asdoc reg logpgp95 lat_abst avexpr africa asia other_cont, nest save(IV) label drop(`drop' _cons)


*Column 9 (Base Sample, log GDP per worker)

asdoc reg loghjypl avexpr, nest save(IV) label drop(`drop' _cons)
