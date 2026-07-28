
## COVID-19 PROBABILITY — POISSON DISTRIBUTION
##### Author: Malena Grannerud
### Skills demonstrated: probability modeling · Poisson distribution · Python (scipy, matplotlib) · statistical communication

Quick start

  pip install numpy scipy matplotlib
  python covid.py

#### INTRODUCTION
A city of 120,000 inhabitants has been experiencing a Covid-19 outbreak with on average 12 new cases per week.

**Aim** Estimate the probability of extreme weekly caseloads to assist healthcare capacity planning:
- **(i)** of more than 20 new cases occurring within one week (\(P(X > 20)\)).      
- **(ii)** of this threshold being breached for two consecutive weeks (\(P(X > 20)^2\)).

#### METHOD
**Population:** 120 000 individuals.
                                                            
**Statistical Analysis:** The Poisson distribution models rare, independent count events over time where mean = variance = λ: 

​```
P(X > k) = 1 − Σ_{i=0}^{k} (λ^i · e^{−λ}) / i!
​```
- X: number of events, k: threshold, i: summation index
- λ: average events per time unit, e: Euler's number (≈ 2.71828), i!: the factorial of i
- in Python: `poisson.sf(k, lam)`, where, k=20,lam=12

**Assumptions:**
1. Independent events
2. Constant average rate 
3. No simultaneous events
4. Proportionality. Assumptions 1–4 imply Dispersion index=Var(X)/E(X)≈1
5. Independence between consecutive weeks for the two-week calculation

**Significance Level:** α = 0.05, Type I error 

#### RESULTS
| Metric | Value |
|---|---|
| (i) P(X > 20) | 0.01160 → **1.16%** |
| (ii) P(X > 20)² | 0.0001345 → **0.0135%** |

##### Plot
<img width="3600" height="1100" alt="covid" src="https://github.com/user-attachments/assets/c2f10d71-262f-4e7d-b3f4-87029c7c1515" />

#### DISCUSSION
The Poisson model is simple, well-established, and analytically fast — well-suited to rare, independent events in a large population.

**(i)** ≈1.16% corresponds to roughly once every 86 weeks (~1.7 years) — uncommon but not extreme. In practice, Covid cases cluster (households, workplaces), which can cause overdispersion (Var > λ); λ itself is rarely constant due to seasonality, restrictions, variants, and behaviour changes.

**(ii)** 0.0135% is very low under the independence assumption. Since transmission waves typically span multiple weeks, this figure likely underestimates the true probability. A Negative Binomial model, which allows Var > mean, would better capture overdispersion.

#### CONCLUSION
These results should be treated as a **lower bound**. Models accounting for temporal dependence and overdispersion (e.g., time-series or Negative Binomial models) should be considered for more robust capacity planning.


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








