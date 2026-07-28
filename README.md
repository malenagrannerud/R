
## COVID-19 PROBABILITY — POISSON DISTRIBUTION
#### Risk/probability. Demonstrates Poisson distribution for count data, probability calculations, assumption evaluation, and critical interpretation for real-world planning.
##### Author: Malena Grannerud

#### INTRODUCTION
A city of 120,000 inhabitants has been experiencing a Covid-19 outbreak with on average 12 new cases per week.

##### AIM
The goal of this report is to calculate the probability
- (i) of > 20 new cases occurring in one week
- (ii) of (i) occurring two weeks in a row

to help healthcare services prepare.

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





-------------------------------------------------------

## TOE ARTERY PRESSURE — TWO-GROUP COMPARISON
#### Compares two statistical approaches for two-group inference, demonstrating method selection based on data structure and assumption evaluation.
##### Author: Malena Grannerud


#### INTRODUCTION
The arterial pressure in the toes can be an indicator of arterial disease in the lower limbs. 
Such pressure measurements were collected of two different treatments, "standard" and "new". 

##### AIM
Determine whether a "new" treatment differs from "standard" treatment in toe artery pressure.

#### METHOD 
##### Data & Study Design 
Design: Independent groups design 
Data source: tprdata.csv.

##### Variables
Outcome (Y): Toe artery pressure (continuous, Ratio scale).
Predictor (X): Treatment group (binary categorical: standard / new).

##### Statistical Methods 
Two complementary approaches selected:

METHOD A: Independent samples t-test (Welch's t-test) 
  Parametric test. Assumptions: 
       (i) Independence, 
       (ii) Approximate normality per group. Tested with Shapiro-Wilk test.
       (iii) Welch's does not assume equal variances. Tested with Q-Q plots per group.
  H₀: μ_standard = μ_new
  H₁: μ_standard ≠ μ_new
  Test statistic: t = (x̄₁ − x̄₂) / √(s₁²/n₁ + s₂²/n₂)

METHOD B: Wilcoxon rank-sum test (Mann–Whitney U). 
  Non-parametric. Assumptions: 
       (i) Independence, 
       (ii) Observations are ordinal/comparable. Tested with Levene's test. 
       (iii) Under H₀, distributions have same shape. Tested with F-test. 
  H₀: Distributions are equal (stochastic equality).
  H₁: Distributions differ (shift alternative).
  Test statistic: U = sum of ranks in group 1.

Significance level: α = 0.05 (two-sided).

#### RESULTS 
DESCRIPTIVE STATISTICS
Standard — n: [n], Mean: [mean], SD: [sd]
New      — n: [n], Mean: [mean], SD: [sd]

NORMALITY (Shapiro-Wilk):
  Standard: W = [W], p = [p]  ([OK/DEVIATES])
  New:      W = [W], p = [p]  ([OK/DEVIATES])

INFERENTIAL RESULTS (α = 0.05)
METHOD A — Welch's t-test:
  t = [t], df = [df], p = [p]
  Mean difference: [diff] [CI_lower, CI_upper]
  Decision: [Significant difference / No significant difference]

METHOD B — Wilcoxon rank-sum test:
  W = [W], p = [p]
  Decision: [Significant difference / No significant difference]

#### DISCUSSION

  t-test: More powerful if normality holds. Wilcoxon: Robust to outliers and non-normality; uses ranks.
  Comparing both shows whether conclusion is sensitive to assumptions.

CONVERGENCE OF METHODS:
Both methods [agree/disagree] → conclusion is [robust/sensitive to assumptions].
If t-test gives p < 0.05 but Wilcoxon does not → potential outlier influence
or normality violation driving parametric result.

METHOD SELECTION JUSTIFICATION:
- t-test: Assumes normality; more powerful if met. Welch's variant used to
  avoid equal-variance assumption.
- Wilcoxon: Uses ranks, not values → robust to outliers and skewness.
  Trade-off: slightly lower power when normality holds.

ASSUMPTION EVALUATION:
- Shapiro-Wilk [showed/did not show] deviation from normality.
- Q-Q plots [confirm/suggest caution regarding] normality.
- If normality violated → Wilcoxon is primary; t-test is supportive.
- If normality holds → t-test is primary; Wilcoxon confirms robustness.

PRACTICAL INTERPRETATION:
A statistically significant difference means the new treatment affects
toe pressure. Clinical relevance depends on effect size (mean difference
and confidence interval), not just p-value.

#### CONCLUSION 
Based on [Method A / Method B / both], there [is/is not] a statistically
significant difference in toe artery pressure between standard and new
treatments (α = 0.05).
Using two methods with different assumptions ensures the conclusion is
not an artefact of a single method's limitations — a hallmark of
rigorous statistical practice.








