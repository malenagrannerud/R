# ==============================================================================
# TASK 1: COVID-19 CASES ANALYSIS (IMRAD REPORT)
# ==============================================================================

# INTRODUCTION
# A city of 120,000 inhabitants has been experiencing a Covid-19 outbreak. The average is 12 new cases per week.
# 
# The goal of this report is to 
#   (i) Calculate the probability of more than 20 cases for a week and 
#   (ii) Calculate the probability of (i) happening two weeks in a row
# to help healthcare services prepare for potential surges in cases.
#
# METHOD
# Probability of more than 20 cases during a single week: P(X > 20) = 1 - P(X <= 20)
# Probability of more than 20 cases two weeks in a row (assuming independent weeks):

# We use a Poisson distribution because Covid cases are rare, discrete events in a large population over a fixed period of time.
# Advantages: Simple, requires only the parameter lambda = 12.
# Disadvantages: The model assumes independence between cases and constant intensity. 
# This rarely holds true for infectious diseases that spread in clusters (transmission risk increases).

# RESULTS
lambda <- 12
p_single_week <- 1 - ppois(20, lambda = lambda)
print(paste("Probability > 20 cases (single week):", round(p_single_week, 6)))
# [Result: ~0.011598 or 1.16%]

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
