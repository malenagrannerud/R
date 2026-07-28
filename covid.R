# Parametrar
lambda <- 12
k <- 20

# Sannolikhetsberäkningar
p_single_week <- ppois(k, lambda = lambda, lower.tail = FALSE)
p_two_weeks <- p_single_week^2

# Skriv ut textresultat i terminalen
cat("=====================RESULTS===================\n")
cat(sprintf("Parameter \u03bb:                        %d\n", lambda))
cat(sprintf("Threshold k:                        %d\n", k))
cat(sprintf("Expected value, E(X) = \u03bb:           %d cases/week\n", lambda))
cat(sprintf("Variance, Var(X) = \u03bb:               %d\n", lambda))
cat(sprintf("Standard deviation, SD(X) = sqrt(\u03bb): %.2f\n", sqrt(lambda)))
cat("----------------------------------------\n")
cat("(i) Single week:\n")
cat(sprintf("    P(X > %d) = %.6f (\u2248 %.4f%%)\n", k, p_single_week, p_single_week * 100))
cat(sprintf("    P(X \u2264 %d) = %.6f\n", k, 1 - p_single_week))
cat("----------------------------------------\n")
cat("(ii) Two consecutive weeks:\n")
cat(sprintf("    P(X > %d) = %.8f (\u2248 %.6f%%)\n", k, p_two_weeks, p_two_weeks * 100))
cat("========================================\n")
cat(sprintf("\nExpected frequency:\n  > %d cases occurs once every %.1f weeks (\u2248 %.1f years)\n", k, 1/p_single_week, 1/p_single_week/52))

# --- visualisering Codespaces ---
png("covid_poisson_plot.png", width = 800, height = 600, res = 100)

x_vals <- 0:30
y_vals <- dpois(x_vals, lambda = lambda)

barplot(y_vals, names.arg = x_vals,
        main = sprintf("Poisson Distribution: Covid-19 Cases per Week (\u03bb = %d)", lambda),
        xlab = "Number of cases (k)",
        ylab = "Probability P(X = k)",
        col = ifelse(x_vals > k, "red", "steelblue"),
        border = NA)

abline(v = k + 0.5, col = "red", lwd = 2, lty = 2)

legend("topright",
       legend = c(sprintf("X \u2264 %d", k), sprintf("X > %d", k), sprintf("Threshold k = %d", k)),
       fill = c("steelblue", "red", NA),
       border = c("black", "black", NA),
       lty = c(NA, NA, 2),
       lwd = c(NA, NA, 2),
       col = c(NA, NA, "red"))

# 2. Stäng filen och spara den
dev.off()

cat("\nDiagrammet har sparats som 'covid_poisson_plot.png'!\n")
