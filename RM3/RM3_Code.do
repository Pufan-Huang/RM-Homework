* Install package
ssc install estout

* Read in data: 
insheet using D:\sports-and-education.csv, comma names clear

* Table option
global TP01 "prehead(\begin{tabular}{l*{6}{c}}) postfoot(\end{tabular}) noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01)"
global TP02 "bf(%15.2gc) sfmt(%15.2gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) nolast)  starlevels(* 0.1 ** 0.05 *** 0.01) replace r2"

* Balance table
estpost ttest academicquality athleticquality nearbigmarket, by(ranked2017) unequal welch
esttab . using D:\RM3_Table_1.tex, cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide label collabels("Control" "Treatment" "Difference") noobs $TP01 mlabels(none) eqlabels(none) replace mgroups(none)

* Propensity score model
logit ranked2017 academicquality athleticquality nearbigmarket
eststo Reg_2
esttab Reg_2 using D:\RM3_Table_2.rtf, $TP02
logit ranked2017 academicquality athleticquality nearbigmarket
predict propoensity_score, pr

* Build block
sort propoensity_score
gen block = floor(_n/4)

* Treatment effect
reg alumnidonations2018 ranked2017 i.block
eststo Reg_3
esttab Reg_3 using D:\RM3_Table_3.rtf, $TP02