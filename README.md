
## COVID-19 PROBABILITY — POISSON DISTRIBUTION
### Risk/probability. Demonstrates Poisson distribution for count data, probability calculations, assumption evaluation, and critical interpretation for real-world planning.
#### Author: Malena Grannerud

#### INTRODUCTION
A city of 120,000 inhabitants has been experiencing a Covid-19 outbreak with on average 12 new cases per week.

The goal of this report is to 
- (i) Calculate the probability of > 20 new cases in one week
- (ii) Calculate the probability of (i) occurring two weeks in a row

to help healthcare services prepare for potential surges in cases.

#### METHOD
##### Data Collection & Sampling
Target Population: 120 000 individuals.

##### Variables & Measurement
Random Variable (X): Number of new Covid-19 cases per week. Discrete quantitative variable.
Parameter λ: Average number of cases per week = 12.
Operational Definitions: A "case" is defined as a new positive Covid-19 test during a calendar week.
Data Scale: True zero exists, counts are meaningful --> Ratio.
                                                                    
##### Statistical Analysis & Modeling
To answer (i) and (ii), The Poisson distribution was used since it models the number of rare, independent events over time or space, where mean = variance = λ.

       P(X>k) = 1 - Σ_{i=0}^{k} (λ^i * e^{-λ}) / i!
       P(X>k two weeks in a row) = [P(X>k)]², 
where
       X: random variable (number of events)
       k: nr of events we calculate the probability for (k = 0, 1, 2, …)
       i: summation index (i = 0, 1, 2, ..., k)
       λ: average nr of events per time unit 
       e: Euler's number (≈ 2.71828)
       i!: the factorial of i

Assumptions: 
1. Independent events
2. Constant average rate 
3. No simultaneous events
4. Proportionality. Assumptions 1–4 imply Dispersion index=Var(X)/E(X)≈1
5. Independence between consecutive weeks for the two-week calculation

Significance Level: α = 0.05, Type I error 


#### RESULTS


##### (i) The probability of > 20 new cases in one week


##### (ii) The probability of (i) occurring two weeks in a row




Additional: Expected frequency



#### DISCUSSION
Poisson distribution is simple, well-established, and requires only λ. It is suitable for rare, 
independent count events in a large population & gives quick analytical answers without simulation.

##### (i) The probability of > 20 new cases in one week 
The probability of >20 cases in a single week ≈ 1.13% → such an event occurs on average once every 88 weeks (~1.7 years). This is uncommon but not extremely rare. Covid cases are often clustered (households, workplaces) → may cause overdispersion (Var > λ). λ is rarely constant in reality due to seasonality, restrictions, new variants, and behavioural changes.

##### (ii) The probability of (i) occurring two weeks in a row
This is very unlikely (0.013%) under the assumption of independence between weeks. Transmission waves often span multiple weeks → [P(X>20)]² likely UNDERESTIMATES the true probability. If overdispersion is present, a Negative Binomial model would be more appropriate, as it allows variance > mean.

#### CONCLUSION
For healthcare planning, these results should be treated as a lower bound, and models accounting for temporal dependence (e.g., time-series or Negative Binomial models) should be considered.














