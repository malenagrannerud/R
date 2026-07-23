# ==========================================================================================================
# TOE ARTERY PRESSURE — TWO-GROUP COMPARISON
# Description: Compares two statistical approaches for two-group inference,demonstrating method selection 
#              based on data structure and assumption evaluation.
# ==========================================================================================================

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