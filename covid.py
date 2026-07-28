import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as stats

# Parametrar
lam = 12
k = 16

# 1. Beräkna exakta sannolikheter (Samma som i R)
# stats.poisson.cdf(k, lam) är P(X <= k). Vi tar 1 minus det för att få P(X > k)
p_single = 1 - stats.poisson.cdf(k, lam)
p_two = p_single ** 2

print("=================== RESULTAT ===================")
print(f"Sannolikhet för > {k} fall en enskild vecka: {p_single:.4f} ({p_single*100:.2f}%)")
print(f"Sannolikhet för > {k} fall två veckor i rad: {p_two:.6f} ({p_two*100:.4f}%)")
print("================================================")

# 2. Skapa plotten
x = np.arange(0, 31)
y = stats.poisson.pmf(x, lam)

# Färga staplar över 16 röda, resten blå
colors = ["red" if val > k else "steelblue" for val in x]

plt.figure(figsize=(10, 6))
plt.bar(x, y, color=colors, width=0.8, edgecolor='black', alpha=0.8)

# Röd streckad linje precis vid 16
plt.axvline(x=k + 0.5, color="red", linestyle="--", linewidth=2, label=f"Gräns (k = {k})")

plt.title(f"Poissonfördelning: Covid-19 fall per vecka (lambda = {lam})")
plt.xlabel("Antal fall")
plt.ylabel("Sannolikhet P(X = k)")
plt.xticks(x)
plt.grid(axis='y', linestyle='--', alpha=0.5)
plt.legend()

# Spara bilden stabilt
plt.savefig("covid_plot_python.png", dpi=100, bbox_inches="tight")
print("\nBilden har sparats som 'covid_plot_python.png'!")
