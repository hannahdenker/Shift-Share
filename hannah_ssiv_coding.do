
cd "/Users/hannahdenker/Documents/GitHub/Shift-Share/Lab/"
ssc install ssaggregate, replace
ssc install ivreg2, replace
ssc install ranktest, replace
clear all

** Construct the ADH (location-by-year) instrument by appropriately combining the data on shocks and shares.
use adh_shares, clear
merge m:1 year industry using adh_shocks, nogen
** Shocks will be constant across industry-years. 

** Construct z - weighted avg of shocks with exposure shares
cap drop z
generate z = ind_share * shock
collapse (sum) z, by(location year) // aggregates


** Merge this instrument into the adh_noIV dataset to get main working dataset
merge 1:1 location year using adh_noIV, nogen //location year


** Run IV! Not shift-share specific** 
** and estimate an IV regression of the outcome onto the treatment which 
** controls for year (i.e. the post variable) and weights by baseline total 
** employment (the weight variable), clustering by state. 

ivreg2 y (x=z) post [aw=weight], cluster(state)  // 'post' controls by year

**Could also run on lag of outcome as placebo check! 
ivreg2 y_lag (x=z) post [aw=weight], cluster(state) 
** nonsig coefficient in this specification builds support for no pretrends

**report kleibergen f stat, could include year indicator instead of post dummy for year if i want

** Specific to shift-share....
** Need to control for sum of shares
preserve
	use adh_shares, clear
	collapse (sum) sum_shares=ind_share, by(location year)
	tempfile sum_share
	save `sum_share'
restore

** Run IV again w sum_share
merge 1:1 location year using `sum_share', nogen
ivreg2 y (x=z) post sum_shares [aw=weight], cluster(state)
** coefficient much lower - a lot of it coming in variation across man. location. sum_share is v. sig. 
** when we adjust for it, we get a smaller effect

**Let's interact sum_shares with year
cap drop post_sum_shares
generate post_sum_shares = post*sum_shares

ivreg2 y (x=z) post sum_shares post_sum_shares [aw=weight], cluster(state)

** to show we remove within period varition with post_sum_shares interaction 
preserve
	use adh_shocks, clear
	reg shock year, cluster(industry) // to show in 2000 (post) mean of shocks is much higher than pre period
	**if i don't interact sum_shares w/ post, i am not isolating within period varition in shocks. 
restore 


** use the ssaggregate command to run both of the previous IV regressions at the shock level. 
ssaggregate y x y_lag [aw=weight], ///
	n(industry) l(location) t(year) /// 
	s(ind_share) sfilename(adh_shares) ///
	controls("post sum_shares post_sum_shares") // partials out these controls using shares
	
**merge back the shocks to get everything in one dataset
merge 1:1 industry year using adh_shocks, nogen

ivreg2 y (x=shock) i.year [aw=s_n], cluster(industry)	// should be same coefficient at the state level but diff. SE



/*


use "/Users/hannahdenker/Documents/GitHub/Shift-Share/Lab/location_level.dta", clear

