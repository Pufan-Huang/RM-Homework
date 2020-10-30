* Install package
ssc install estout

* Table option
global tableoptions "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"

* Read in data: 
insheet using D:\Dataset_RM1.csv, comma names clear

* Label variables
label variable calledback "Called Back"
label variable eliteschoolcandidate "Elite School"
label variable malecandidate "Male"
label variable bigcompanycandidate "Big Company"
label variable recruiteriswhite "RecruiterWhite"
label variable recruiterismale "RecruiterMale"

* Regression: 
reg calledback eliteschoolcandidate malecandidate
eststo Reg_1
reg calledback eliteschoolcandidate bigcompanycandidate malecandidate recruiteriswhite recruiterismale
eststo Reg_2
reg calledback eliteschoolcandidate bigcompanycandidate c.eliteschoolcandidate#c.bigcompanycandidate
eststo Reg_3
reg calledback eliteschoolcandidate malecandidate c.eliteschoolcandidate#c.malecandidate
eststo Reg_4

* Make graph
esttab Reg_1 Reg_2 Reg_3 Reg_4 using D:\RM1_Table.rtf, $tableoptions
