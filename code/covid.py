import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as stats

lambda_val = 12
k = 20

# stats.poisson.cdf(k, lambda) beräknar P(X <= 20)
# 1 minus cdf ger komplementhändelsen P(X > 20)
p_single_week = 1 - stats.poisson.cdf(k, lambda_val)
p_two_weeks = p_single_week ** 2

print(f"Average cases per week (lambda):    {lambda_val}")
print(f"Threshold (k):                      {k}")
print(f"(i) Single week P(X > {k}):          {p_single_week:.6f} (approx {p_single_week*100:.4f}%)")
print(f"(ii) Two consecutive weeks:         {p_two_weeks:.8f} (approx {p_two_weeks*100:.6f}%)")

x_vals = np.arange(0, 31)
y_vals = stats.poisson.pmf(x_vals, lambda_val) # Färdig funktion för stapelhöjder
colors = ["red" if x > k else "steelblue" for x in x_vals]
plt.figure(figsize=(10, 6))
plt.bar(x_vals, y_vals, color=colors, width=0.8, edgecolor='black', alpha=0.8)

# Röd streckad linje vid tröskelvärdet 20
plt.axvline(x=k, color="red", linestyle="--", linewidth=2, label=f"Threshold k = {k}")

# Lägg till text i själva plotten
plt.text(k - 5, max(y_vals) * 0.8, f"P(X > {k}) = {p_single_week*100:.2f}%", color="red", fontsize=12, weight="bold")
plt.text(k - 5, max(y_vals) * 0.7, f"P(Both > {k}) = {p_two_weeks*100:.4f}%", color="darkred", fontsize=12, weight="bold")

# Inställningar för diagrammet
plt.title(f"Poisson Distribution: Covid-19 Cases per Week (lambda = {lambda_val})", fontsize=14, weight="bold")
plt.xlabel("Number of cases", fontsize=12)
plt.ylabel("Probability P(X = k)", fontsize=12)
plt.xticks(x_vals)
plt.grid(axis='y', linestyle='--', alpha=0.5)
plt.legend(loc="upper right")

plt.savefig("covid_python_plot.png", dpi=100, bbox_inches="tight")
print("Bilden har sparats som 'covid_python_plot.png' i din rotmapp!\n")
