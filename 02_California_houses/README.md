# California Housing Price Prediction

A machine learning project that predicts median house values in California using the 1990 California Housing dataset. This project explores various regression algorithms and feature engineering techniques to build accurate predictive models.

## Table of Contents

- [Overview](#overview)
- [Dataset](#dataset)
- [Tools &amp; Libraries](#tools--libraries)
- [Project Structure](#project-structure)
- [Methodology](#methodology)
- [Models Implemented](#models-implemented)
- [Results](#results)
- [Key Findings](#key-findings)
- [Technologies Used](#technologies-used)
- [Usage](#usage)

## Overview

This project implements and compares multiple machine learning algorithms to predict median house values in California districts based on the 1990 census data. The analysis includes exploratory data analysis, feature engineering, data preprocessing, and model evaluation.

## Dataset

The dataset is a modified version of the California Housing dataset originally used in:

> Pace, R. Kelley, and Ronald Barry. "Sparse spatial autoregressions." Statistics & Probability Letters 33.3 (1997): 291-297.

**Source**: [California Housing Prices Dataset (Kaggle)](https://www.kaggle.com/datasets/fedesoriano/california-housing-prices-data-extra-features)

### Features

The dataset contains 20,433 observations with the following features:

**Original Features:**

- **Median House Value**: Median house value for households within a block (target variable) [$]
- **Median Income**: Median income for households within a block [10k$]
- **Median Age**: Median age of houses within a block [years]
- **Total Rooms**: Total number of rooms within a block
- **Total Bedrooms**: Total number of bedrooms within a block
- **Population**: Total number of people residing within a block
- **Households**: Total number of households within a block
- **Latitude**: Geographic coordinate [°]
- **Longitude**: Geographic coordinate [°]

**Engineered Distance Features** (calculated using Haversine formula):

- Distance to coast [m]
- Distance to Los Angeles [m]
- Distance to San Diego [m]
- Distance to San Jose [m]
- Distance to San Francisco [m]

## Tools & Libraries

The analysis and modeling were conducted in **Python** using the following libraries:

**Data manipulation**

- pandas
- numpy

**Visualization**

- matplotlib
- seaborn

**Machine learning** 

- scikit-learn
  - Linear Regression, RidgeCV, LassoCV
  - Random Forest
  - KMeans clustering
  - Train/test split, feature preprocessing, PowerTransformer
  - Model evaluation utilities
  - Partial dependence plots
- xgboost

**Statistical Analysis**

- scipy.stats – distributions, statistical tests

## Project Structure

```
CaliforniaHouses.ipynb    # Main analysis notebook containing:
                          # - Data loading and exploration
                          # - Exploratory Data Analysis (EDA)
                          # - Feature engineering
                          # - Data preprocessing
                          # - Model training and evaluation
                          # - Results visualization
```

## Methodology

### 1. Exploratory Data Analysis

- Statistical summary and distribution analysis
- Correlation analysis between features
- Visualization of geographical patterns
- Missing value detection and handling

### 2. Feature Engineering

- Created derived features (rooms per household, bedrooms per room, population per household)
- K-means clustering to identify elite areas
- Power transformation for handling skewed distributions

### 3. Data Preprocessing

- Train-test split (80-20)
- Feature scaling and transformation
- Handling of multicollinearity

### 4. Model Development

Implemented and compared five regression models:

- Linear Regression (baseline)
- Ridge Regression (L2 regularization)
- Lasso Regression (L1 regularization)
- Random Forest Regressor
- XGBoost Regressor

## Models Implemented

### Linear Regression

Standard ordinary least squares regression serving as a baseline model.

### Ridge Regression

Linear regression with L2 regularization to handle multicollinearity. Implemented with cross-validation for optimal alpha selection.

### Lasso Regression

Linear regression with L1 regularization for feature selection. Implemented with cross-validation for optimal alpha selection.

### Random Forest

Ensemble learning method using multiple decision trees. Includes feature importance analysis and partial dependence plots.

### XGBoost

Gradient boosting algorithm optimized for performance. Includes feature importance analysis.

## Results

### Model Performance Comparison

| Model             | R² Score (Test Set) |
| ----------------- | -------------------- |
| Linear Regression | 0.6439               |
| Ridge Regression  | 0.6438               |
| Lasso Regression  | 0.6452               |
| Random Forest     | 0.8701               |
| XGBoost           | **0.8748**     |

### Best Model: XGBoost

- **Test R² Score**: 0.8748
- **Top 3 Important Features**:
  1. Distance to coast
  2. Median income
  3. Elite area classification (from K-means clustering)

### Second Best: Random Forest

- **Test R² Score**: 0.8701
- **Top 3 Important Features**:
  1. Distance to coast
  2. Median income
  3. Elite area classification

## Key Findings

1. **Ensemble Methods Outperform Linear Models**: XGBoost and Random Forest significantly outperformed linear regression models, achieving R² scores above 0.87 compared to approximately 0.64 for linear models.
2. **Distance to Coast is Critical**: Proximity to the coast emerged as the most important predictor of house values, suggesting coastal properties command premium prices.
3. **Income Correlation**: Median income shows strong predictive power, indicating higher-income areas tend to have more expensive housing.
4. **Elite Areas Matter**: The K-means clustering successfully identified elite areas, which proved to be a significant feature in predicting house values.
5. **Hypothesis**: People with higher incomes tend to purchase houses closer to the coast and in elite areas, which are more expensive. However, interaction effects between these features require further investigation.

## Technologies Used

- **Python 3.12.7**
- **Data Manipulation**: NumPy, Pandas
- **Visualization**: Matplotlib, Seaborn
- **Machine Learning**: scikit-learn, XGBoost
- **Statistical Analysis**: SciPy

### Key Libraries

```python
numpy
pandas
matplotlib
seaborn
scikit-learn
xgboost
scipy
```

## Acknowledgments

- Original dataset: Pace, R. Kelley, and Ronald Barry (1997)
- Modified dataset with distance features: [Kaggle Dataset](https://www.kaggle.com/datasets/fedesoriano/california-housing-prices-data-extra-features)
- Dataset creator: Federico Soriano Palacios

---

*This project demonstrates the application of various machine learning techniques for real estate price prediction and serves as an educational resource for understanding regression analysis and model comparison.*
