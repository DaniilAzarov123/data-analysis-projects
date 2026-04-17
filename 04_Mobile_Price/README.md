# Mobile Price Analysis

A statistical analysis of mobile phone pricing using regression modeling, PCA-based dimensionality reduction, and AIC-driven model selection.

---

## Table of Contents

- [Overview](#overview)
- [Dataset](#dataset)
- [Tools &amp; Libraries](#tools--libraries)
- [Methodology](#methodology)
- [Key Results](#key-results)

---

## Overview

This project builds a linear regression model to predict mobile phone prices (USD) from hardware and software features. Given the small dataset size (n = 15), the analysis uses Principal Component Analysis (PCA) to reduce multicollinearity before fitting the model, and exhaustive AIC-based subset selection to identify the best-performing predictors.

**Final model performance:** R² = 0.781 | Adjusted R² = 0.745

---

## Dataset

- **Source:** [Mobile Price Dataset](https://www.kaggle.com/datasets/jawadaahmed/mobile-price-dataset) (via Kaggle)
- **Target variable:** `Price_USD`
- **Key features:** Screen size, battery capacity, RAM, storage, camera MP, OS, release year

---

## Tools & Libraries

The analysis was conducted in **Python using the following libraries:**

| Library                    | Purpose                                                  |
| -------------------------- | -------------------------------------------------------- |
| `pandas`/`numpy`       | Data loading and manipulation                            |
| `matplotlib`/`seaborn` | Visualization (heatmaps, scatterplots, residual plots)   |
| `statsmodels`            | OLS regression, Breusch-Pagan heteroscedasticity test    |
| `scikit-learn`           | Feature scaling and PCA                                  |
| `pingouin`               | Normality testing and Q-Q plots                          |
| `kagglehub`              | Automated dataset download from Kaggle                   |
| `itertools`              | Exhaustive predictor subset generation for AIC selection |

---

## Methodology

### 1. Exploratory Data Analysis

- Summary statistics for numeric features
- Missing value checks
- Correlation heatmap and pairwise scatterplots
- Variance Inflation Factor (VIF) analysis to detect multicollinearity

### 2. Dimensionality Reduction (PCA)

- Applied to the four most collinear features: `Screen_Size_Inch`, `Battery_mAh`, `RAM_GB`, `Storage_GB`
- Two principal components retained, explaining **86.9%** of the original variance
- Post-PCA VIF values confirmed reduced multicollinearity

### 3. Linear Regression & Model Selection

- Fitted OLS regression using `statsmodels`
- Exhaustive subset search across all predictor combinations
- Best model selected by minimum AIC

### 4. Model Diagnostics

- **Normality:** Q-Q plot + Shapiro-Wilk normality test
- **Heteroscedasticity:** Residuals vs fitted plot + Breusch-Pagan test
- Both checks passed — no major assumption violations found

---

## Key Results

| Metric                 | Value                                |
| ---------------------- | ------------------------------------ |
| Model                  | OLS Linear Regression                |
| R²                    | 0.781                                |
| Adjusted R²           | 0.745                                |
| Selection criterion    | AIC (exhaustive search)              |
| PCA variance explained | 86.9% (4 variables --> 2 components) |
| Assumption violations  | None detected                        |
