# ==============================================================================
# COVID-19 CASE PROBABILITY — POISSON DISTRIBUTION
# Author: Malena Grannerud
# Description: Demonstrates Poisson distribution for count data, probability calculations, 
#              assumption evaluation, and critical interpretation for real-world planning.
# ==============================================================================
#
# INTRODUCTION
# A city of 120,000 inhabitants has been experiencing a Covid-19 outbreak with on average 12 new cases per week.
# The goal of this report is to 
#   (i) Calculate the probability of more than 20 cases for a week  
#   (ii) Calculate the probability of (i) happening two weeks in a row
# to help healthcare services prepare for potential surges in cases.
#
# METHOD
# 1. Data Collection & Sampling
# Target Population: 120 000 individuals.
#
# 2. Variables & Measurement
# Random Variable (X): Number of new Covid-19 cases per week. Discrete quantitative variable.
# Parameter λ: Average number of cases per week = 12.
# Operational Definitions: A "case" is defined as a new positive Covid-19 test during a calendar week.
# Data Scale: True zero exists, counts are meaningful --> Ratio.
#                                                                     
# 3. Statistical Analysis & Modeling
# To answer (i) and (ii), The Poisson distribution was used. 
# The Poisson distribution models the number of rare, independent events over time or space, where mean = variance = λ.
#        P(X>k) = 1 - Σ_{i=0}^{k} (λ^i * e^{-λ}) / i!
#        P(X>k two weeks in a row) = [P(X>k)]², 
# where
#        X: random variable (number of events)
#        k: nr of events we calculate the probability for (k = 0, 1, 2, …)
#        i: summation index (i = 0, 1, 2, ..., k)
#        λ: average nr of events per time unit 
#        e: Euler's number (≈ 2.71828)
#        i!: the factorial of i
# Assumptions: 
# 1. Independent events
# 2. Constant average rate 
# 3. No simultaneous events
# 4. Proportionality. Assumptions 1–4 imply Dispersion index=Var(X)/E(X)≈1
# 5. Independence between consecutive weeks for the two-week calculation
# Significance Level: α = 0.05, Type I error 
# Software: RStudio-ppois(), dpois().

# RESULTS
lambda <- 12  # Average number of cases per week
k <- 20 # Threshold value

# (i) Probability of more than 20 cases in a single week
p_single_week <- ppois(k, lambda = lambda, lower.tail = FALSE)

# (ii) Probability of more than 20 cases two weeks in a row
p_two_weeks <- p_single_week^2

# Display results
cat("=====================RESULTS===================\n")
cat(sprintf("Parameter λ:                        %d\n", lambda))
cat(sprintf("Threshold k:                        %d\n", k))
cat(sprintf("Expected value, E(X) = λ:           %d cases/week\n", lambda))
cat(sprintf("Variance, Var(X) = λ:               %d\n", lambda))
cat(sprintf("Standard deviation, SD(X) = sqrt(λ): %.2f\n", sqrt(lambda)))
cat("----------------------------------------\n")
cat("(i) Single week:\n")
cat(sprintf("    P(X > %d) = %.6f\n", k, p_single_week))
cat(sprintf("               ≈ %.4f%%\n", p_single_week * 100))
cat(sprintf("    P(X ≤ %d) = %.6f\n", k, 1 - p_single_week))
cat("----------------------------------------\n")
cat("(ii) Two consecutive weeks:\n")
cat(sprintf("    P(X > %d) = %.8f\n", k, p_two_weeks))
cat(sprintf("             ≈ %.6f%%\n", p_two_weeks * 100))
cat("========================================\n")

# Additional: Expected frequency
cat("\nExpected frequency:\n")
cat(sprintf("  > %d cases occurs on average once every %.1f weeks\n", k, 1/p_single_week))
cat(sprintf("  (≈ %.1f months, ≈ %.1f years)\n", 1/p_single_week/4.33, 1/p_single_week/52))

# Visualization
x_vals <- 0:30
y_vals <- dpois(x_vals, lambda = lambda)

barplot(y_vals, names.arg = x_vals,
        main = sprintf("Poisson Distribution: Covid-19 Cases per Week (λ = %d)", lambda),
        xlab = "Number of cases (k)",
        ylab = "Probability P(X = k)",
        col = ifelse(x_vals > k, "red", "steelblue"),
        border = NA)

abline(v = k + 0.5, col = "red", lwd = 2, lty = 2)

legend("topright",
       legend = c(sprintf("X ≤ %d", k), sprintf("X > %d", k), sprintf("Threshold k = %d", k)),
       fill = c("steelblue", "red", NA),
       border = c("black", "black", NA),
       lty = c(NA, NA, 2),
       lwd = c(NA, NA, 2),
       col = c(NA, NA, "red"))

# ---- DISCUSSION ----
# Poisson distribution is simple, well-established, and requires only λ. It is suitable for rare, 
# independent count events in a large population & gives quick analytical answers without simulation.
#
# (i) CALCULATE THE PROBABILITY OF > 20 CASES IN A WEEK 
# The probability of >20 cases in a single week ≈ 1.13% → such an event occurs on average once every 88 weeks (~1.7 years).
# This is uncommon but not extremely rare.
# Assumption 1: Covid cases are often clustered (households, workplaces) → may cause overdispersion (Var > λ).
# Assumption 2: λ is rarely constant in reality due to seasonality, restrictions, new variants, and behavioural changes.
#
# (ii) CALCULATE THE PROBABILITY OF (i) HAPPENING 2 WEEKS IN A ROW
# Two consecutive weeks with >20 cases is very unlikely (0.013%) under the assumption of independence between weeks.
# Assumption 5: Transmission waves often span multiple weeks → [P(X>20)]² likely UNDERESTIMATES the true probability.
# If overdispersion is present, a Negative Binomial model would be more appropriate, as it allows variance > mean.

# ---- CONCLUSION ----
# For healthcare planning, these results should be treated as a lower bound, and models accounting for temporal dependence
# (e.g., time-series or Negative Binomial models) should be considered.



# ==============================================================================
# TOE ARTERY PRESSURE — TWO-GROUP COMPARISON
# Author: Malena Grannerud
# Description: Compares two statistical approaches for two-group inference,
#              demonstrating method selection based on data structure and
#              assumption evaluation.
# ==============================================================================

# ---- INTRODUCTION ----
# The arterial pressure in the toes,can be an indicator of arterial disease in the lower limbs. 
# Such pressure measurements were collected of two different treatments ("standard" and "new")
# Aim: Determine whether a "new" treatment differs from "standard" treatment in toe artery pressure.
#
# ---- METHOD ----
# 1. Data & Study Design 
# Design: Independent groups design (standard vs. new).
# Data source: tprdata.csv.
#
# 2. Variables
# Outcome (Y): Toe artery pressure (continuous, Ratio scale).
# Predictor (X): Treatment group (binary categorical: standard / new).
#
# 3. Statistical Methods 
# Two complementary approaches selected:
#
# METHOD A: Independent samples t-test (Welch's t-test) 
#   Parametric test. Assumptions: 
#        (i) Independence, 
#        (ii) Approximate normality per group. Tested with Shapiro-Wilk test.
#        (iii) Welch's does not assume equal variances. Tested with Q-Q plots per group.
#   H₀: μ_standard = μ_new
#   H₁: μ_standard ≠ μ_new
#   Test statistic: t = (x̄₁ − x̄₂) / √(s₁²/n₁ + s₂²/n₂)
#
# METHOD B: Wilcoxon rank-sum test (Mann–Whitney U). 
#   Non-parametric. Assumptions: 
#        (i) Independence, 
#        (ii) Observations are ordinal/comparable. Tested with Levene's test. 
#        (iii) Under H₀, distributions have same shape. Tested with F-test. 
#   H₀: Distributions are equal (stochastic equality).
#   H₁: Distributions differ (shift alternative).
#   Test statistic: U = sum of ranks in group 1.
#
# Significance level: α = 0.05 (two-sided).
# Software: R version 4.4.1 — t.test(), wilcox.test(), shapiro.test().

# ---- RESULTS ----
tpr <- read.csv("tprdata.csv") # Load data

cat("==========================================================\n")
cat("         TOE PRESSURE: DESCRIPTIVE STATISTICS              \n")
cat("==========================================================\n")
cat(sprintf("Standard — n: %d, Mean: %.2f, SD: %.2f\n",
            sum(tpr$group == "standard"),
            mean(tpr$pressure[tpr$group == "standard"]),
            sd(tpr$pressure[tpr$group == "standard"])))
cat(sprintf("New      — n: %d, Mean: %.2f, SD: %.2f\n",
            sum(tpr$group == "new"),
            mean(tpr$pressure[tpr$group == "new"]),
            sd(tpr$pressure[tpr$group == "new"])))
cat("==========================================================\n\n")

# Assumption check: Normality
shapiro_standard <- shapiro.test(tpr$pressure[tpr$group == "standard"])
shapiro_new      <- shapiro.test(tpr$pressure[tpr$group == "new"])

cat("NORMALITY (Shapiro-Wilk):\n")
cat(sprintf("  Standard: W = %.3f, p = %.4f  %s\n",
            shapiro_standard$statistic,
            shapiro_standard$p.value,
            ifelse(shapiro_standard$p.value > 0.05, "(OK)", "(DEVIATES)")))
cat(sprintf("  New:      W = %.3f, p = %.4f  %s\n",
            shapiro_new$statistic,
            shapiro_new$p.value,
            ifelse(shapiro_new$p.value > 0.05, "(OK)", "(DEVIATES)")))
cat("\n")


par(mfrow = c(1, 2))
qqnorm(tpr$pressure[tpr$group == "standard"],
       main = "Q-Q Plot: Standard", xlab = "Theoretical Quantiles",
       ylab = "Sample Quantiles")
qqline(tpr$pressure[tpr$group == "standard"], col = "red", lwd = 2)
qqnorm(tpr$pressure[tpr$group == "new"],
       main = "Q-Q Plot: New", xlab = "Theoretical Quantiles",
       ylab = "Sample Quantiles")
qqline(tpr$pressure[tpr$group == "new"], col = "red", lwd = 2)

# METHOD A: Welch's t-test
ttest <- t.test(pressure ~ group, data = tpr, var.equal = FALSE)

# METHOD B: Wilcoxon rank-sum test
wilcox <- wilcox.test(pressure ~ group, data = tpr, exact = FALSE)

# Comparative output
cat("==========================================================\n")
cat("              INFERENTIAL RESULTS (α = 0.05)               \n")
cat("==========================================================\n")
cat("METHOD A — Welch's t-test:\n")
cat(sprintf("  t = %.3f, df = %.1f, p = %.4f\n",
            ttest$statistic, ttest$parameter, ttest$p.value))
cat(sprintf("  Mean difference: %.2f [%.2f, %.2f]\n",
            ttest$estimate[1] - ttest$estimate[2],
            ttest$conf.int[1], ttest$conf.int[2]))
cat(sprintf("  Decision: %s\n",
            ifelse(ttest$p.value < 0.05,
                   "Significant difference (reject H₀)",
                   "No significant difference (fail to reject H₀)")))
cat("----------------------------------------------------------\n")
cat("METHOD B — Wilcoxon rank-sum test:\n")
cat(sprintf("  W = %.0f, p = %.4f\n",
            wilcox$statistic, wilcox$p.value))
cat(sprintf("  Decision: %s\n",
            ifelse(wilcox$p.value < 0.05,
                   "Significant difference (reject H₀)",
                   "No significant difference (fail to reject H₀)")))
cat("==========================================================\n")

# ---- DISCUSSION ----
#
#   t-test: More powerful if normality holds.Wilcoxon: Robust to outliers and non-normality; uses ranks.
#   Comparing both shows whether conclusion is sensitive to assumptions.
#
# CONVERGENCE OF METHODS:
# Both methods [agree/disagree] → conclusion is [robust/sensitive to assumptions].
# If t-test gives p < 0.05 but Wilcoxon does not → potential outlier influence
# or normality violation driving parametric result.
#
# METHOD SELECTION JUSTIFICATION:
# - t-test: Assumes normality; more powerful if met. Welch's variant used to
#   avoid equal-variance assumption.
# - Wilcoxon: Uses ranks, not values → robust to outliers and skewness.
#   Trade-off: slightly lower power when normality holds.
#
# ASSUMPTION EVALUATION:
# - Shapiro-Wilk [showed/did not show] deviation from normality.
# - Q-Q plots [confirm/suggest caution regarding] normality.
# - If normality violated → Wilcoxon is primary; t-test is supportive.
# - If normality holds → t-test is primary; Wilcoxon confirms robustness.
#
# PRACTICAL INTERPRETATION:
# A statistically significant difference means the new treatment affects
# toe pressure. Clinical relevance depends on effect size (mean difference
# and confidence interval), not just p-value.

# ---- CONCLUSION ----
# Based on [Method A / Method B / both], there [is/is not] a statistically
# significant difference in toe artery pressure between standard and new
# treatments (α = 0.05).
# Using two methods with different assumptions ensures the conclusion is
# not an artefact of a single method's limitations — a hallmark of
# rigorous statistical practice.
