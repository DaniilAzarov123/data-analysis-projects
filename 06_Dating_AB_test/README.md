# A/B Test Analysis: Premium Subscription Pricing in a Dating App

## Overview

This project is a capstone analysis completed as part of the [Data Analytics course by Karpov Courses](https://karpov.courses/analytics).

The analysis evaluates the results of an A/B test conducted in a large dating application. The experiment changed the price of a premium subscription for new users in several countries when paying through two newly introduced payment methods. The trial period price was kept unchanged. Subscriptions are billed monthly until cancelled.

Three groups were compared: one test group and two control groups. The goal was to determine whether the experiment was successful overall.

## Dataset

Each group has two corresponding files.

**User-level data** contains demographic and behavioural attributes: age, gender, country, attraction coefficient, visit history, subscription status, and normalised total revenue.

**Transaction-level data** contains individual purchase records with timestamps, product type, normalised revenue, payment ID, and the page from which the purchase was initiated. Product types include trial premium subscription, full premium subscription without trial, coin purchases, and other.

## Analysis Summary

### Data Quality Issues Found and Resolved

The data required substantial cleaning before analysis. Key issues addressed:

**Duplicate and empty records.** One transaction file contained a duplicated block of data with 630 fully empty rows. All files contained transactions with identical fields but different payment IDs, indicating payment system errors rather than genuine separate purchases.

**Date parsing errors.** A subset of `paid_at` timestamps were stored in `YYYY-DD-MM` format instead of `YYYY-MM-DD`, causing payment dates to appear earlier than registration dates. The affected rows were identified by a consistent pattern (day value always equal to 11) and corrected by swapping day and month.

**Pre-experiment transactions.** Some records belonged to users who had already purchased a full premium subscription before the experiment began in October 2017. These users were excluded as they do not represent the target audience of new subscribers.

**Anomalous user.** One user in the control group had registration and payment records dating back to 2015 and 2016. This user was excluded as clearly outside the experiment window.

**Successful transaction labelling.** Since subscriptions are billed monthly, multiple premium purchases by the same user within the same calendar month were treated as failed payment attempts. Only the last transaction per user per month was marked as successful.

### Metrics

**Conversion to premium subscription (primary metric).** The share of all new users who made a successful direct premium purchase without a preceding trial or coin subscription.

**ARPPU (proxy metric).** Average revenue per paying user, calculated across premium and other purchase types, to assess whether the new pricing freed up spending on other in-app purchases.

**Daily retention (guardrail metric).** The share of users returning to the app on day 1 and day 10 after registration, to verify the new payment methods did not negatively affect engagement.

**Failed transaction rate (guardrail metric).** The share of premium purchase attempts that were unsuccessful within a given month, to detect potential payment processing issues.

### Key Findings

| Metric                  | Test                      | Control 1 | Control 2 |
| ----------------------- | ------------------------- | --------- | --------- |
| Conversion to premium   | 1.32%                     | 2.07%     | 2.18%     |
| ARPPU median            | 8 216                     | 6 292     | 6 292     |
| Failed transaction rate | 8.0%                      | 1.9%      | 2.8%      |
| Day 1 retention         | no significant difference |           |           |
| Day 10 retention        | no significant difference |           |           |

Conversion was significantly lower in the test group relative to both controls (chi-square test, p = 0.0096; pairwise z-tests with Bonferroni correction confirmed the test group differed from each control). The two control groups did not differ from each other.

ARPPU was significantly higher in the test group (Mann-Whitney U, p < 0.001 for both pairwise comparisons), but this is interpreted as a selection bias effect rather than a positive outcome. With conversion roughly 1.5 times lower, only the most motivated and highest-spending users completed a purchase in the test group.

No significant differences in daily retention were found across groups.

### Conclusion

**The experiment is considered unsuccessful.** Conversion to a full premium subscription dropped significantly in the test group. The failed transaction rate in the test group (8.0%) was notably higher than in controls (approximately 2%), pointing to a technical issue in one or more of the new payment methods. The higher ARPPU in the test group is a selection bias artefact rather than a genuine improvement.

The recommended next steps are to fix the payment processing issue in the new methods and then conduct a follow-up experiment with revised pricing.

## Tools and Libraries

Python 3.12, pandas, numpy, scipy, statsmodels, matplotlib, seaborn

## Course Reference

This project was completed as the capstone assignment of the [Data Analytics course by Karpov Courses](https://karpov.courses/analytics). The dataset was provided as part of that course.
