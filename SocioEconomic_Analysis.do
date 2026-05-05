* ==============================================================================
* Project: Impact of Rural vs Urban Residency on BMI
* Researcher: Denix Gitonga
* ==============================================================================

clear all
set more off

* 1. SET DIRECTORY
cd "C:\Users\USER\OneDrive\denixgitonga18@gmail.com\OneDrive\Documents\Denix-Projects"

* 2. LOAD DATA
webuse nhanes2, clear

* 3. DATA CLEANING
* Label the 'rural' variable so the tables look professional
label define rural_lbl 0 "Urban" 1 "Rural"
label values rural rural_lbl

* 4. DESCRIPTIVE STATISTICS
* Compare average BMI between Urban and Rural residents
tabulate rural, summarize(bmi)

* 5. HYPOTHESIS TESTING (T-TEST)
* Testing if the difference in BMI is statistically significant
ttest bmi, by(rural)

* 6. REGRESSION ANALYSIS
* Model 1: Simple impact of location on BMI
regress bmi rural
est store model1

* Model 2: Adjusted for Age and Sex (Control variables)
regress bmi rural age i.sex
est store model2

* 7. EXPORT PUBLICATION-READY TABLE
outreg2 [model1 model2] using "Final_SocioEconomic_Analysis.doc", word replace ///
	title("Table 1: Rural vs Urban Impact on BMI") ///
	ctitle("Basic Model", "Adjusted Model") ///
	addnote("Source: NHANES II dataset. 'Rural' is 1, 'Urban' is 0.")

di "SUCCESS! Check your folder for the Word document."
