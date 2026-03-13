# Bilinear Matrix Periodic Systems — Controllability (MATLAB Codes)

This repository contains the MATLAB scripts used to reproduce the numerical experiments reported in the research paper

**“Equivalence of Hewer and Kalman Controllability for Generalised Bilinear Matrix Periodic Systems.”**

**Authors**

Sri Venkata Durga Sudarsan Madhyannapu
Sravanam Pradheep Kumar

---

# Overview

This repository provides a reproducible MATLAB implementation of the numerical experiments used to verify theoretical results on controllability of **generalised bilinear matrix periodic systems**.

The MATLAB scripts compute the lifted vector representation of the matrix system and evaluate the **periodic controllability Gramian**, verifying the theoretical equivalence between **Kalman controllability** and **Hewer controllability**.

The repository also contains the scripts used to generate the figures included in the manuscript.

---

# Mathematical Model

The system studied in the paper is

dX/dt = A(t)X(t) + X(t)B(t) + F(t)X(t)G(t) + K(t)U(t)

Using the vectorisation identity

Vec(FXG) = (Gᵀ ⊗ F) Vec(X)

the matrix system is transformed into a lifted vector system of dimension (n^2).

Controllability is analysed using the **periodic controllability Gramian** and the spectral properties of the **monodromy matrix**.

---

# Key Numerical Results

The numerical verification uses a representative example with

n = 3
lifted dimension = 9
period T = 2π

---

## Monodromy Matrix Eigenvalues

The computed eigenvalues of the monodromy matrix M are

0.7877 ± 0.6160i
0.9597 ± 0.2812i
−1.5883
−0.6296
1.0000 (multiplicity 3)

The corresponding eigenvalue moduli are

1.5883, 1.0000 × 7, 0.6296

These values confirm that the monodromy matrix is **not Kronecker factorisable**, which is a key structural property analysed in the paper.

---

## Controllability Gramian Statistics

The periodic controllability Gramian values obtained in MATLAB are

Period i = 1
λ_min(W₁) = 0.5211
λ_max(W₁) = 4.084 × 10⁵
κ(W₁) = 7.837 × 10⁵

Period i = 2
λ_min(W₂) = 0.5681
λ_max(W₂) = 8.758 × 10⁶
κ(W₂) = 1.542 × 10⁷

Period i = 3
λ_min(W₃) = 0.5705
λ_max(W₃) = 1.516 × 10⁸
κ(W₃) = 2.657 × 10⁸

All computed Gramians are **positive definite**, confirming K-controllability.

---

## Additional Numerical Verification

Further verification experiments include:

Step-size sensitivity of the monodromy computation

||ΔM||₍F₎ values

9.6591 × 10⁻²
8.3716 × 10⁻³

Minimum-energy control synthesis

J* = 0.2925

Verification of the H-controllability condition

Minimum integral value

1.8270 > 0

This confirms the equivalence between **Kalman controllability and Hewer controllability**.

---

## Scaling Study

Condition numbers of the Gramian across different system dimensions:

n = 2
κ(W₁) ≈ 2.128 × 10¹⁰ ± 6.648 × 10¹⁰

n = 3
κ(W₁) ≈ 4.953 × 10¹¹ ± 1.357 × 10¹²

Large condition numbers arise due to unstable monodromy directions and are expected in such periodic systems.

---

# Repository Structure

Bilinear-Matrix-Periodic-Controllability

│
├── Supp_Paper1_Controllability_v3.m
Main MATLAB script performing the numerical verification

├── Generate_Figures_Paper1.m
Script used to generate the figures appearing in the paper

├── figures/
PDF figures used in the manuscript

├── LICENSE
└── README.md

---

# MATLAB Environment

The numerical experiments were performed using

MATLAB R2024b

Numerical integration of the lifted system uses

ode45

with solver tolerances

RelTol = 1e-8
AbsTol = 1e-10

---

# Reproducing the Numerical Results

To reproduce the numerical verification reported in the manuscript run

Supp_Paper1_Controllability_v3.m

To regenerate the figures used in the paper run

Generate_Figures_Paper1.m

---

# Research Reproducibility

This repository provides an open implementation of the numerical procedures used in the paper. The scripts allow independent verification of the theoretical results and provide a reference implementation for researchers working on periodic matrix differential systems and bilinear control theory.

---

# Repository Link

https://github.com/msvdsudarsan/Bilinear-Matrix-Periodic-Controllability

---

# License

This repository is distributed under the MIT License.
