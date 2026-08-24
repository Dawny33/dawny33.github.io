---
title: "Notes on keeping feature pipelines honest"
date: 2026-06-12 10:30:00 +0530
tags: [machine-learning, data-engineering, mlops]
description: "Training-serving skew is not a modelling problem. It is a plumbing problem, and it is almost always the same three leaks."
---

Every serious training-serving skew bug I've chased turned out to be one of three
things. None of them were interesting. All of them cost days.

## Leak one: the aggregation window moves

You compute `user_purchases_30d` in a batch job that runs at 02:00 and looks back
thirty days from midnight. At serving time you compute the same feature live, looking
back thirty days from *now*. These are not the same feature. They correlate well
enough that nothing looks broken, and badly enough that your model is quietly
mis-calibrated for anything time-sensitive.

The fix is boring: one definition, one implementation, called from both paths. If
your batch and online code compute the same feature in two places, you have two
features with one name.

## Leak two: nulls mean different things

In the warehouse a missing value is `NULL`, which your training code fills with the
column mean. In production the same missing value arrives as `0` from an upstream
service that helpfully defaults integers. Your model has never seen a genuine zero in
that column and treats it as a strong signal.

Assert on it. A schema check that fails loudly on an unexpected zero rate is worth
more than a dashboard nobody reads.

## Leak three: the join is late

The feature exists. The feature is correct. The feature arrives forty seconds after
the prediction was needed, so serving falls back to a default and nobody notices
because the fallback path doesn't log.

> If the fallback is silent, the fallback is a bug.

Log every default substitution with the feature name. Alert on the rate, not the
event. You want to know that 4% of requests are missing a feature, not to be paged
for each one.

## The pattern

All three are the same failure: the same concept implemented twice, in two systems,
by two people, at two times. The defence isn't better modelling. It's refusing to let
a feature have more than one definition, and instrumenting the boundary hard enough
that the drift shows up in a graph before it shows up in a post-mortem.
