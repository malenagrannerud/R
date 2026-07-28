
# COVID-19 PROBABILITY — POISSON DISTRIBUTION
**Author:** Malena Grannerud
**Skills demonstrated:**  probability modeling · Poisson distribution · Python (scipy, matplotlib) · statistical communication

## Quick start
```bash
pip install numpy scipy matplotlib
cd code
python covid.py
```

---
#### INTRODUCTION
A city of 120,000 inhabitants has been experiencing a Covid-19 outbreak with on average 12 new cases per week.

**Aim** Estimate the probability of extreme weekly caseloads to assist healthcare capacity planning: **(i)** of more than 20 new cases occurring within one week (\(P(X > 20)\)), and **(ii)** of this threshold being breached for two consecutive weeks (\(P(X > 20)^2\)).

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

# Toe Artery Pressure — Comparing Two Treatment Regimes

**Author:** Malena Grannerud
**Skills demonstrated:** hypothesis testing · normality diagnostics · parametric vs. non-parametric methods · Python (scipy, pandas, matplotlib)

## Quick start
```bash
pip install pandas numpy scipy matplotlib
cd code
python toe_pressure.py
```

## INTRODUCTION
Toe artery pressure, measured by photoplethysmography, can indicate arterial disease in the lower limbs. Pressure readings were collected from 28 patients under two treatment regimes: **standard** (n=10) and **new** (n=18).

**Aim:** Determine whether toe pressure differs between the two treatment groups, using at least two statistical approaches suited to the data's structure.

## METHOD
**Data:** `tprdata.csv` — 28 patients, each with a treatment group (`standard`/`new`) and a toe pressure reading (mmHg).

**Approach:** Since group sizes are unequal (10 vs. 18) and it isn't known in advance whether toe pressure is normally distributed within each group, two complementary tests were used:

1. **Welch's t-test** (parametric) — compares group means, does not assume equal variances. Appropriate if data are approximately normally distributed.
2. **Mann-Whitney U test** (non-parametric) — compares group *distributions/ranks* rather than means. Makes no normality assumption and is robust to outliers — a useful cross-check given the small "standard" group (n=10) and the visible spread of values (min 20, max 110).

**Assumption checks performed first:**
- **Shapiro-Wilk test** — checks normality within each group
- **Levene's test** — checks equality of variances between groups

**Significance level:** α = 0.05

## RESULTS

| Statistic | Standard (n=10) | New (n=18) |
|---|---|---|
| Mean | 53.90 | 68.57 |
| SD | 15.41 | 20.28 |
| Median | 54.55 | 70.55 |

**Assumption checks**

| Test | Result |
|---|---|
| Shapiro-Wilk, standard | W=0.918, p=0.344 (normal) |
| Shapiro-Wilk, new | W=0.975, p=0.886 (normal) |
| Levene's test (equal variance) | p=0.198 (variances not significantly different) |

**Group comparison**

| Test | Statistic | p-value |
|---|---|---|
| Welch's t-test | t = 2.149 | **p = 0.042** |
| Mann-Whitney U | U = 132.0 | **p = 0.047** |

**Effect size:** Cohen's d = 0.78 (medium–large effect); mean difference = **14.67 mmHg** higher in the "new" group.

##### Plot
<img width="900" alt="toe pressure results" src="ATTACH_YOUR_IMAGE_LINK_HERE" />

## DISCUSSION
Both the Shapiro-Wilk tests (p > 0.05 in both groups) and visual inspection (Q-Q plot) suggest toe pressure is reasonably normally distributed within each group, and Levene's test shows no significant difference in variance between groups — so the parametric t-test assumptions are reasonably well met.

Both tests agree: there is a **statistically significant difference** between groups (both p < 0.05), with the "new" treatment associated with **higher toe pressure** on average (~14.7 mmHg higher). The Mann-Whitney U test, which does not rely on normality, gives a very similar p-value (0.047 vs. 0.042), reinforcing that the result is not an artifact of a parametric assumption being violated.

The effect size (Cohen's d ≈ 0.78) indicates a **medium-to-large** practical difference, not just statistical significance — relevant when judging clinical importance.

**Limitations:** Group sizes are unequal and small (10 vs. 18), which limits statistical power, especially for the standard group. The study design here appears observational/comparative rather than randomized in this dataset excerpt — if patients were not randomly assigned to treatments, other factors (disease severity, age, etc.) could confound the comparison.

## CONCLUSION
There is evidence of a statistically significant and practically relevant difference in toe pressure between the "standard" and "new" treatment groups, with higher pressures observed under the "new" regime. Because two independent tests (parametric and non-parametric) converge on the same conclusion, the finding appears robust to distributional assumptions. Confirmation via a larger, ideally randomized, sample is recommended before drawing firm clinical conclusions.








