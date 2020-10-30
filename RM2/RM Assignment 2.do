* Install package
ssc install estout

* Table option
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"

* Read in data: 
insheet using D:\vaping-ban-panel.csv, comma names clear

* Parallel trends test
reg lunghospitalizations year vapingban c.year#c.vapingban i.stateid
eststo Reg_1

* Regression
reg lunghospitalizations vapingban i.year i.stateid 
eststo Reg_2

* Make graph
esttab Reg_1 using D:\RM2_Table_1.rtf, $tableoptions
esttab Reg_2 using D:\RM2_Table_2.rtf, $tableoptions

testparm i.stateid