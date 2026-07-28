"""
Toe Artery Pressure Analysis

"""

import pandas as pd
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv('../datasets/tprdata.csv', sep=';', decimal=',')

new = df.loc[df.treatment == 'new', 'toepr']
std = df.loc[df.treatment == 'standard', 'toepr']

print("--- Descriptives ---")
for name, g in [('new', new), ('standard', std)]:
    print(f"{name}: n={len(g)}, mean={g.mean():.2f}, sd={g.std():.2f}, "
          f"median={g.median():.2f}")

# Assumption checks
print("\n--- Shapiro-Wilk normality test ---")
for name, g in [('new', new), ('standard', std)]:
    w, p = stats.shapiro(g)
    print(f"{name}: W={w:.3f}, p={p:.4f}")

print("\n--- Levene's test for equal variance ---")
lev_stat, lev_p = stats.levene(new, std)
print(f"stat={lev_stat:.3f}, p={lev_p:.4f}")

# Statistical tests
print("\n--- Welch's t-test (unequal variances) ---")
t_stat, t_p = stats.ttest_ind(new, std, equal_var=False)
print(f"t={t_stat:.3f}, p={t_p:.4f}")

print("\n--- Mann-Whitney U test ---")
u_stat, u_p = stats.mannwhitneyu(new, std, alternative='two-sided')
print(f"U={u_stat}, p={u_p:.4f}")

pooled_sd = np.sqrt(((len(new)-1)*new.std()**2 + (len(std)-1)*std.std()**2) /
                     (len(new)+len(std)-2))
cohend = (new.mean() - std.mean()) / pooled_sd
print(f"\nCohen's d = {cohend:.3f}")
print(f"Mean difference (new - standard) = {new.mean()-std.mean():.2f} mmHg")

# ---------------------------------------------------------------
# Combined figure: boxplot, histogram/density, Q-Q plot
# ---------------------------------------------------------------
fig, axes = plt.subplots(1, 3, figsize=(18, 5.5))

# Panel 1: Boxplot with individual points
ax = axes[0]
data = [std, new]
bp = ax.boxplot(data, tick_labels=['standard', 'new'], patch_artist=True, widths=0.5)
for patch, color in zip(bp['boxes'], ['#2874a6', '#c0392b']):
    patch.set_facecolor(color)
    patch.set_alpha(0.5)
for i, g in enumerate([std, new], start=1):
    x_jit = np.random.normal(i, 0.04, size=len(g))
    ax.plot(x_jit, g, 'o', color='black', alpha=0.6, markersize=4)
ax.set_ylabel('Toe pressure (mmHg)')
ax.set_title('Toe pressure by treatment group')

# Panel 2: Histogram / density comparison
ax = axes[1]
bins = np.linspace(15, 115, 12)
ax.hist(std, bins=bins, alpha=0.5, color='#2874a6', label='standard', edgecolor='white')
ax.hist(new, bins=bins, alpha=0.5, color='#c0392b', label='new', edgecolor='white')
ax.axvline(std.mean(), color='#2874a6', linestyle='--', linewidth=1.5)
ax.axvline(new.mean(), color='#c0392b', linestyle='--', linewidth=1.5)
ax.set_xlabel('Toe pressure (mmHg)')
ax.set_ylabel('Count')
ax.set_title('Distribution by group')
ax.legend(frameon=False)

# Panel 3: Q-Q plot for normality (new group vs. standard group)
ax = axes[2]
stats.probplot(new, dist="norm", plot=ax)
ax.get_lines()[0].set_markerfacecolor('#c0392b')
ax.get_lines()[0].set_markeredgecolor('#c0392b')
ax.get_lines()[1].set_color('black')
ax.set_title('Q-Q plot: "new" group vs. normal distribution')

plt.tight_layout()
plt.savefig('toe_pressure_results.png', dpi=200)
plt.close()

print("\nFigure saved as toe_pressure_results.png")