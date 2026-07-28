

# 1. Beräkna sannolikheterna
k <- 20
lamb<-12

p_en_vecka <- ppois(k, lambda = lamb, lower.tail = FALSE)
p_tva_veckor <- p_en_vecka^2

print(p_en_vecka)  # 0.01159774
print(p_tva_veckor) # 0.0001345075

# 2. Skapa och spara plotten
png("covid_plot.png")

x <- 0:30
y <- dpois(x, lambda = lamb)

barplot(y, names.arg = x, col = ifelse(x > k, "red", "steelblue"))
abline(v = k + 0.5, col = "red", lty = 2)

dev.off()