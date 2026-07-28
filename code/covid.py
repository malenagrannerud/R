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

# --- SKAPA HÄR TVÅ PLOTTAR BREDVID VARANDRA (1 rad, 2 kolumner) ---
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))

# ================= PLOT 1: EN ENSKILD VECKA =================
y_vals_single = stats.poisson.pmf(x_vals, lambda_val)
colors_single = ["red" if x > k else "steelblue" for x in x_vals]

ax1.bar(x_vals, y_vals_single, color=colors_single, width=0.8, edgecolor='black', alpha=0.8)
ax1.axvline(x=k + 0.5, color="red", linestyle="--", linewidth=2, label=f"Threshold k = {k}")
ax1.text(14, max(y_vals_single) * 0.8, f"P(X > {k}) =\n{p_single_week*100:.2f}%", color="red", fontsize=12, weight="bold")

ax1.set_title("Single Week Probability", fontsize=12, weight="bold")
ax1.set_xlabel("Number of cases", fontsize=10)
ax1.set_ylabel("Probability P(X = k)", fontsize=10)
ax1.set_xticks(x_vals[::2]) # Visar varannat tal på x-axeln så det inte blir trångt
ax1.grid(axis='y', linestyle='--', alpha=0.5)
ax1.legend(loc="upper right")

# ================= PLOT 2: TVÅ VECKOR I RAD =================
# För två veckor i rad multipliceras den andra veckans utfall med p_single_week
y_vals_two = y_vals_single * p_single_week
colors_two = ["darkred" if x > k else "steelblue" for x in x_vals]

ax2.bar(x_vals, y_vals_two, color=colors_two, width=0.8, edgecolor='black', alpha=0.8)
ax2.axvline(x=k + 0.5, color="red", linestyle="--", linewidth=2, label=f"Threshold k = {k}")
ax2.text(14, max(y_vals_single) * 0.8, f"P(Both > {k}) =\n{p_two_weeks*100:.4f}%", color="darkred", fontsize=12, weight="bold")

ax2.set_title("Two Consecutive Weeks", fontsize=12, weight="bold")
ax2.set_xlabel("Number of cases", fontsize=10)
ax2.set_ylabel("Probability", fontsize=10)
ax2.set_xticks(x_vals[::2])
ax2.grid(axis='y', linestyle='--', alpha=0.5)
ax2.legend(loc="upper right")

# Spara hela figuren med båda plottarna i din rotmapp
plt.savefig("covid_python_plot.png", dpi=100, bbox_inches="tight")
print("Bilden har sparats som 'covid_python_plot.png' i din rotmapp!\n")