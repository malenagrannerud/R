# ==============================================================================
# TASK 1: COVID-19 CASES ANALYSIS (IMRAD REPORT)
# ==============================================================================

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
print(paste("Probability > 20 cases (two consecutive weeks):", round(p_two_weeks, 6)))
# [Result: ~0.000135 or 0.014%]

# PLOTS
x <- 0:30
y <- dpois(x, lambda = 12)

colors <- ifelse(x > 20, "firebrick", "steelblue")
barplot(y, names.arg = x, col = colors, border = "white",
        main = "Poisson Distribution (lambda = 12)",
        xlab = "Number of New Cases per Week",
        ylab = "Probability")
legend("topright", legend = c("P(X <= 20)", "P(X > 20)"), 
       fill = c("steelblue", "firebrick"), btree = "n")


# DISCUSSION & CONCLUSION
# The results show a very low probability for both scenarios under normal conditions.
# Reliability: You should NOT blindly trust these results. 
# Covid-19 spreads via chains of transmission (dependent events), which violates the Poisson assumption. 
# During an outbreak, cases cluster, leading to "overdispersion" (variance > mean).
# 
# The model underestimates the risk of extreme weeks. Healthcare services should instead 
# use a Negative Binomial distribution to account for cluster transmission effects.
