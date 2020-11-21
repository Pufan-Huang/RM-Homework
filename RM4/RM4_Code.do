* Install package
ssc install estout
ssc install ivreg2

* Table option
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"

* Read in data: 
insheet using D:\crime-iv.csv, comma names clear

* Balance test
reg severityofcrime republicanjudge
eststo Reg_1
esttab Reg_1 using D:\RM4_Table_1.rtf, $tableoptions

* First stage
reg monthsinjail republicanjudge severityofcrime
eststo Reg_2
esttab Reg_2 using D:\RM4_Table_2.rtf, $tableoptions

* Reduced form
reg recidivates republicanjudge severityofcrime
eststo Reg_3
esttab Reg_3 using D:\RM4_Table_3.rtf, $tableoptions

* IV regression
ivreg2 recidivates (monthsinjail=republicanjudge) severityofcrime
eststo Reg_4
esttab Reg_4 using D:\RM4_Table_4.rtf, $tableoptions