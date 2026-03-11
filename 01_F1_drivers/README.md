# Formula 1 DNF Prediction Dataset (1950–2024)

## Table of contents

- [Overview](#overview)
- [Dataset](#dataset)
- [Tools &amp; Libraries](#tools-and-libraries)
- [Results](#results)
- [Key Insights](#key-insights)
- [Acknowledgments](#acknowledgments)

## Overview

This project explores Formula 1 race data (1950–2024) to predict Did Not Finish (DNF) outcomes — cases where drivers fail to complete a race due to mechanical issues, crashes, disqualifications, or other factors.

The goal is to identify key predictors of race completion and evaluate the performance of several machine learning models.

## Dataset

The dataset combines:

- Race results
- Driver performance metrics
- Team information
- Circuit characteristics
- Historical context

It provides a comprehensive foundation for analyzing performance, safety, and reliability trends in Formula 1 over more than seven decades.

## **Tools & Libraries**

The analysis and modeling were conducted in **Python** using the following libraries:

**Data manipulation**

- pandas
- numpy

**Visualization**

- matplotlib
- seaborn

**Machine learning**

* scikit-learn
  * Logistic Regression
  * Random Forest
  * Train/test split
  * Model evaluation utilities
  * Partial dependence plots
* xgboost

**Model evaluation**

* ROC curve
* AUC score
* Accuracy
* Confusion matrix
* Classification report

## Results

I applied several classification models to predict whether a driver finishes a race or records a DNF, comparing their performance using the Area Under the ROC Curve (AUC) metric.

| Model               | AUC  | Accuracy |
| ------------------- | ---- | -------- |
| Logistic Regression | 0.94 | 86.9%    |
| Random Forest       | 0.97 | 91.4%    |
| XGBoost             | 0.98 | 92.6%    |

## Key Insights

- **Starting position** is a strong predictor of finishing probability.
  Drivers starting near the front of the grid are more likely to finish, possibly because rear cars are exposed to more on-track incidents.
- **Year of the race** also matters.
  Finish rates have steadily improved over time, likely due to stricter safety regulations, technological advances, and better car reliability.

## Acknowledgments

Data sourced from the [Historical DNF data with driver and constructor dataset on Kaggle](https://www.kaggle.com/datasets/pranay13257/f1-dnf-classification/data).
