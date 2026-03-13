# Bilinear Matrix Periodic Systems — Controllability (MATLAB Codes)

This repository contains the MATLAB scripts used to reproduce the numerical experiments reported in the research paper:

**“Equivalence of Hewer and Kalman Controllability for Generalised Bilinear Matrix Periodic Systems.”**

**Authors**
Sri Venkata Durga Sudarsan Madhyannapu
Sravanam Pradheep Kumar

---

## Overview

The purpose of this repository is to provide a transparent and reproducible implementation of the numerical procedures used in the controllability study of generalised bilinear matrix periodic systems.

The scripts implement the lifted vector representation of the matrix system and compute the associated periodic controllability Gramian. Numerical experiments verify the equivalence between **Kalman controllability** and **Hewer controllability** for the considered class of periodic systems.

The repository also contains scripts used to generate the figures presented in the paper.

---

## Numerical Components

The MATLAB implementation includes:

* computation of the **monodromy matrix** of the lifted periodic system
* evaluation of the **periodic controllability Gramian** using numerical quadrature
* verification of the **Gramian recursion relation**
* numerical confirmation of the **K–H controllability equivalence**
* step–size sensitivity analysis for the monodromy computation
* Gramian conditioning analysis across multiple system dimensions
* minimum-energy control computation
* verification of the **H-controllability condition**

The figures included in the paper are generated directly from these simulations.

---

## Repository Structure

```
Bilinear-Matrix-Periodic-Controllability
│
├── Supp_Paper1_Controllability_v3.m
│   Main MATLAB script performing the numerical verification
│
├── Generate_Figures_Paper1.m
│   Script used to generate the figures appearing in the paper
│
├── figures/
│   PDF figures used in the manuscript
│
├── LICENSE
└── README.md
```

---

## MATLAB Environment

The scripts were tested using:

MATLAB R2024b

Numerical integration of the state-transition equations is performed using the `ode45` solver with tolerances

RelTol = 1e-8
AbsTol = 1e-10

These settings match those used for the numerical experiments reported in the paper.

---

## Reproducing the Numerical Results

To reproduce the numerical verification reported in the manuscript:

1. Run

```
Supp_Paper1_Controllability_v3.m
```

This script computes the monodromy matrix, evaluates the controllability Gramian, and performs the verification tests.

2. To regenerate the figures used in the paper, run

```
Generate_Figures_Paper1.m
```

---

## Verification

All numerical values reported in the manuscript (including eigenvalues, Gramian statistics, recursion residuals, and figure data) were independently verified using an additional computational implementation based on the RK45 integration scheme. The results confirm the correctness and internal consistency of the MATLAB computations.

---

## Repository Link

https://github.com/msvdsudarsan/Bilinear-Matrix-Periodic-Controllability

---

## License

This repository is distributed under the **MIT License**.
