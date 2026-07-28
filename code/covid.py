"""
Covid-19 weekly caseload analysis
Poisson model: lambda = 12 cases/week
(i)  P(X > 20)
(ii) P(X > 20) for two consecutive weeks (independence assumed)
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import poisson

lam = 12          # average weekly cases
k = 20            # threshold

p_single = poisson.sf(k, lam)      # P(X > 20) = 1 - CDF(20)
p_two    = p_single ** 2           # two consecutive weeks (independent)

print(f"P(X > {k})            = {p_single:.6f}  ({p_single*100:.2f} %)")
print(f"P(X > {k}) two weeks  = {p_two:.6f}  ({p_two*100:.4f} %)")

# Combined figure: 1 row x 3 columns

x = np.arange(0, 35)
pmf = poisson.pmf(x, lam)
sf = poisson.sf(x, lam)

fig, axes = plt.subplots(1, 3, figsize=(18, 5.5))

# --- Panel 1: PMF ---
ax = axes[0]
colors = ['#c0392b' if xi > k else '#2874a6' for xi in x]
ax.bar(x, pmf, color=colors, edgecolor='white', linewidth=0.6)
ax.axvline(lam, color='black', linestyle='--', linewidth=1, label=f'λ = {lam}')
ax.axvline(k, color='#c0392b', linestyle=':', linewidth=1.3, label=f'k = {k}')
ax.set_title(f'Poisson PMF (λ = {lam})\nP(X > {k}) = {p_single:.4f}')
ax.set_xlabel('Cases per week (X)')
ax.set_ylabel('P(X = x)')
ax.legend(frameon=False)

# --- Panel 2: Survival function ---
ax = axes[1]
ax.step(x, sf, where='post', color='#2874a6', linewidth=2, label='P(X > x)')
ax.plot(k, p_single, 'o', color='#c0392b', zorder=5)
ax.axhline(p_single, color='#c0392b', linestyle=':', linewidth=1.2)
ax.axvline(k, color='#c0392b', linestyle=':', linewidth=1.2)
ax.set_title('Survival function P(X > x)')
ax.set_xlabel('Number of x weekly cases ')
ax.set_ylabel('P(X > x) - Probability of exceeding x weekly cases')
ax.legend(frameon=False)

# --- Panel 3: Single week vs. two weeks ---
ax = axes[2]
bars = ax.bar(['Single week\nP(X > 20)', 'Two weeks\nP(X > 20)²'],
              [p_single, p_two], color=['#2874a6', '#c0392b'], width=0.5)
for b, val in zip(bars, [p_single, p_two]):
    ax.text(b.get_x() + b.get_width() / 2, val + max(p_single, p_two) * 0.03,
            f'{val:.4f}\n({val*100:.3f} %)', ha='center')
ax.set_ylabel('Probability')
ax.set_title('Single week vs. two consecutive weeks')

plt.tight_layout()
plt.savefig('../images/covid.png', dpi=200)
plt.close()

print("Saved combined figure as covid.png")