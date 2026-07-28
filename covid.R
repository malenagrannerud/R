


## COVID-19 PROBABILITY — POISSON DISTRIBUTION
#
#        P(X>k) = 1 - Σ_{i=0}^{k} (λ^i * e^{-λ}) / i!
#        P(X>k two weeks in a row) = [P(X>k)]², 
# where
#        X: random variable (number of events)
#        k: nr of events we calculate the probability for (k = 0, 1, 2, …)
#        i: summation index (i = 0, 1, 2, ..., k)
#        λ: average nr of events per time unit 
#        e: Euler's number (≈ 2.71828)
#        i!: the factorial of i

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

