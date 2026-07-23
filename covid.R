# Author: Malena Grannerud
# ==========================================================================================================
# COVID-19 CASE PROBABILITY — POISSON DISTRIBUTION
# Description: Risk/probability. Demonstrates Poisson distribution for count data, probability calculations, 
#              assumption evaluation, and critical interpretation for real-world planning.
# ==========================================================================================================
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


