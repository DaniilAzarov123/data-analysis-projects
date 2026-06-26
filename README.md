# Data Analysis Projects

A collection of end-to-end data analysis and machine learning projects covering classification, regression, and statistical modeling. Each project follows a full analytical pipeline — from exploratory data analysis to model evaluation and diagnostics.

---

## Skills Demonstrated

- **Languages:** Python, R
- **Machine learning:** Classification, Regression, Ensemble methods (Random Forest, XGBoost, Boosting)
- **Statistical modeling:** OLS, GLM, LDA/QDA, Naive Bayes, Ridge/Lasso regularization
- **Dimensionality reduction:** PCA, K-Means clustering
- **Model selection:** AIC-based search, cross-validation, permutation resampling
- **Model diagnostics:** ROC/AUC, residual analysis, heteroscedasticity tests, VIF
- **Visualization:** matplotlib, seaborn, ggplot2

---

## Contact

Feel free to reach out via [GitHub](https://github.com/DaniilAzarov123), [email](mailto:azarov.dj@gmail.com), or connect on [LinkedIn](https://www.linkedin.com/in/daniil-azarov-998584355/). You can also visit [my personal website](https://daniilazarov123.github.io/).

---

## Projects

### 01 · F1 DNF Prediction

**Goal:** Predict whether a Formula 1 driver will fail to finish a race (DNF) based on historical data from 1950–2024.
**Methods:** Logistic Regression, Random Forest, XGBoost
**Best result:** XGBoost — AUC 0.98, Accuracy 92.6%
**Stack:** Python · scikit-learn · XGBoost · pandas · seaborn
📂 [`01_F1_drivers/`](./01_F1_drivers)

---

### 02 · California Housing Price Prediction

**Goal:** Predict median house values across California districts using 1990 census data and engineered geographic features.
**Methods:** Linear/Ridge/Lasso Regression, Random Forest, XGBoost, K-Means clustering
**Best result:** XGBoost — R² 0.8748
**Stack:** Python · scikit-learn · XGBoost · SciPy · pandas · seaborn
📂 [`02_California_houses/`](./02_California_houses)

---

### 03 · Loan Default Modelling

**Goal:** Predict loan default risk from 45,000 applicant records using a wide range of classification models.
**Methods:** Logistic Regression (AIC / Ridge / Lasso), LDA, QDA, Naive Bayes, Random Forest, Boosting — with permutation-based resampling
**Best result:** Random Forest — Accuracy 90.3%
**Stack:** R · dplyr· car · glmnet · randomForest · gbm · pROC · ggplot2
📂 [`03_Loan_Prediction/`](./03_Loan_Prediction)

---

### 04 · Mobile Price Analysis

**Goal:** Predict mobile phone prices from hardware and software features using linear regression with PCA-based dimensionality reduction.
**Methods:** OLS Regression, PCA, AIC-based exhaustive model selection
**Best result:** R² 0.781 · Adj. R² 0.745 — no assumption violations detected
**Stack:** Python · statsmodels · scikit-learn · pingouin · pandas · seaborn
📂 [`04_Mobile_Price/`](./04_Mobile_Price)

---

### 05 · Brazilian Marketplace — Product Analytics

**Goal:** Diagnose revenue stagnation for a Brazilian e-commerce startup using order, customer, and product data from Sep 2016 – Aug 2018.
**Methods:** Cohort Analysis (retention), PMF assessment, ICE hypothesis prioritisation, A/B test metric design
**Key finding:** PMF absent — M1 retention below 1% across all cohorts; order processing bug identified as highest-priority fix (ICE = 192)
**Stack:** Python · pandas · NumPy · matplotlib · seaborn
📂 [`05_Marketplace/`](./05_Marketplace)

---

### 06 · A/B Test Analysis — Dating App Premium Pricing

**Goal:** Evaluate whether a pricing change for premium subscriptions introduced via two new payment methods had a positive effect on new user behaviour. 
**Methods:** Chi-square test, Mann-Whitney U, Kruskal-Wallis, pairwise z-tests with Bonferroni correction, cohort retention analysis
**Key finding:** Experiment unsuccessful — conversion dropped by ~40% in the test group; failed transaction rate of 8% (vs ~2% in controls) indicates a payment processing bug as the primary cause
**Stack:** Python · pandas · NumPy · scipy · statsmodels · matplotlib · seaborn 
📂 [`06_Dating_AB_test/`](./06_Dating_AB_test)
