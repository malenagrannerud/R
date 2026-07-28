

# 1. Beräkna sannolikheterna
p_en_vecka <- ppois(20, lambda = 12, lower.tail = FALSE)
p_tva_veckor <- p_en_vecka^2

print(p_en_vecka)  # 0.01159774
print(p_tva_veckor) # 0.0001345075

# 2. Skapa och spara plotten
png("covid_plot.png")

x <- 0:30
y <- dpois(x, lambda = 12)

barplot(y, names.arg = x, col = ifelse(x > 20, "red", "steelblue"))
abline(v = 20.5, col = "red", lty = 2)

dev.off()