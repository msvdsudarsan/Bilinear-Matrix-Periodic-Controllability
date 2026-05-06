# Bilinear-Matrix-Periodic-Controllability

## Kalman–Hewer Controllability Equivalence for Generalized Bilinear Matrix Periodic Systems with Non-Factorizable Monodromy

**Authors:** Sri Venkata Durga Sudarsan Madhyannapu¹ and Sravanam Pradheep Kumar²

¹ Department of Mathematics, School of Sciences, Humanities, and Management, Dr. RVR NRI Institute of Technology (Deemed to be University), Pothavarappadu Village, Agiripalli Mandal 521212, Andhra Pradesh, India. Email: msvdsudarsan@gmail.com · ORCID: 0009-0001-2126-6428

² School of Basic Sciences, SRM University AP, Neerukonda, Mangalagiri, Guntur 522240, Andhra Pradesh, India. Email: sravanampradheepkumar@gmail.com

**Target Journal:** Mathematics of Control, Signals, and Systems (MCSS, Springer) · Q1 · SCI/SCIE · Hybrid (no mandatory APC)

**Status:** Submitted, May 2026

---

## Abstract

We introduce the **Generalized Bilinear Matrix Periodic System (GBMS)**:

```
Ẋ(t) = A(t)X(t) + X(t)B(t) + F(t)X(t)G(t) + K(t)U(t)
```

and develop a complete Kalman–Hewer controllability theory for this class. The central obstacle is that the composite monodromy M = Φ_A(T,0) of the n²-dimensional lifted system is **generically non-factorizable**: unlike Lyapunov and Sylvester subclasses, M cannot be written as a Kronecker product Φ_B* ⊗ Φ_A, so classical proof strategies fail.

Replacing spectral decomposition with the **minimal polynomial p_min(M)** yields four results:

1. A Gramian-rank Kalman controllability criterion
2. A Kalman–Hewer equivalence theorem proved without any Kronecker structure
3. A sharp controllability horizon **k ≤ n²** periods, where k = deg p_min(M)
4. A period-by-period Gramian recursion at **O(n³) per step**, replacing O(n⁴) integration

Numerical verification for n=3 confirms: Gramian positivity, minimum-energy synthesis (J* ≈ 0.2925), Hewer controllability, and non-factorizability (‖M − Φ_B* ⊗ Φ_A‖_F = **468.7 ≫ 0**), completing the hierarchy: **Lyapunov ⊂ Sylvester ⊂ Generalized Bilinear**.

---

## Repository Structure

```
Bilinear-Matrix-Periodic-Controllability/
│
├── README.md                              ← This file
│
├── MATLAB_Codes/
│   ├── Paper1_Controllability_Verification.m   ← Main script: all theorems verified
│   └── Paper1_Figure_Generation.m              ← All four figures generated
│
├── MATLAB_Outputs/
│   └── MATLAB_OUTPUTS_BILINEAR_CTRL.txt        ← Verified numerical output
│
├── Figures/
│   ├── Fig1_Ctrl_EigModuli.pdf            ← Eigenvalue moduli of M (3 distinct)
│   ├── Fig2_Ctrl_GramianSpectrum.pdf      ← Gramian eigenvalue spectrum (3 periods)
│   ├── Fig3_Ctrl_ScalingStudy.pdf         ← Scaling study n=2,3
│   └── Fig4_Ctrl_StepSizeSensitivity.pdf  ← Step-size convergence of monodromy
│
├── CITATION.cff                           ← Citation metadata
└── LICENSE                               ← MIT License
```

---

## Numerical Results Summary

### Table 1 — MATLAB-Verified Gramian Statistics (n=3, k=1,2,3 periods)

| Period k | λ_min(W̃_k) | λ_max(W̃_k) | κ(W̃_k) | Positive Definite? |
|---|---|---|---|---|
| 1 | 0.5211 | 4.084 × 10⁵ | 7.837 × 10⁵ | ✅ True |
| 2 | 0.5681 | 8.759 × 10⁶ | 1.542 × 10⁷ | ✅ True |
| 3 | 0.5705 | 1.516 × 10⁸ | 2.657 × 10⁸ | ✅ True |

Gramian recursion residual = 0.0000 × 10⁰ (machine precision)

### Table 2 — Monodromy Non-Factorizability (n=3)

| Quantity | Value |
|---|---|
| ‖M − Φ_B* ⊗ Φ_A‖_F | **468.7** (far from zero) |
| Number of distinct |λ(M)| | **3** (gives k=3) |
| Controllability horizon | k=3 periods = 6π ≈ 18.85 |
| Worst-case bound | k ≤ n² = 9 periods |
| Bound tightness | k=3 ≪ 9 (tight in practice) |

### Table 3 — Minimum-Energy Control and H-Controllability

| Result | Value |
|---|---|
| J* = x₀ᵀ W̃₃⁻¹ x₀ | **0.292468** |
| λ_min(W̃₃) | 0.5705 > 0 (control exists) |
| min_j integral (H-ctrl) | **1.8270 > 0** (confirmed) |

### Table 4 — Step-Size Convergence of Monodromy

| Steps h | ‖ΔM‖_F vs finer grid |
|---|---|
| 10⁻³ vs 10⁻⁴ | 9.659 × 10⁻² |
| 10⁻⁴ vs 10⁻⁵ | 8.372 × 10⁻³ |

Convergence rate ≈ O(h) consistent with RK4 accuracy for this ODE.

### Table 5 — Scaling Study

| n | n² | κ(W̃_k) (mean ± std) |
|---|---|---|
| 2 | 4 | (2.128 ± 6.648) × 10¹⁰ |
| 3 | 9 | (4.953 ± 1.357) × 10¹¹ |

Note: n=4 (lifted dimension 16) requires >5 GB RAM for classical Kronecker approach — excluded from direct comparison, confirming necessity of the Kronecker-free recursion.

---

## How to Reproduce All Results

### Requirements
- MATLAB R2021b or later (R2024b recommended)
- No additional toolboxes required

### Steps

**Step 1: Run main verification script**
```matlab
run('Controllability_Verification.m')
```
Prints: eigenvalues of M, non-factorizability norm, minimal polynomial degree k, Gramian statistics (Tables 1–3), minimum-energy J*, and H-controllability confirmation.

**Step 2: Generate all four figures**
```matlab
run('Figure_Generation.m')
```
Produces: `Fig1_Ctrl_EigModuli.pdf`, `Fig2_Ctrl_GramianSpectrum.pdf`, `Fig3_Ctrl_ScalingStudy.pdf`, `Fig4_Ctrl_StepSizeSensitivity.pdf`

---

## System Definition

**Generalized Bilinear Matrix Periodic System:**

```
Ẋ(t) = A(t)X(t) + X(t)B(t) + F(t)X(t)G(t) + K(t)U(t),   X, A, B, F, G, K ∈ ℝⁿˣⁿ
```

with T-periodic coefficients: A(t+T) = A(t), etc.

**Parameters for n=3 example (T = 2π):**
```matlab
A(t) = [sin(2t), 1, 0;   0, cos(2t), 1;   0, 0, sin(t)]
B(t) = [sin(t)+cos(t), 0, 0;   0, sin(t)-cos(t), 0;   0, 0, -sin(t)]
F(t) = [cos(t), 0, 0;   0, sin(t), 0;   0, 0, cos(2t)]
G(t) = [0, sin(t), 0;   cos(t), 0, 0;   0, 0, sin(2t)]
K(t) = [sin(3t), 1, 0;   1, 0, sin(t);   0, cos(t), 1]
```

**Lifted generator (n²=9 dimensional):**
```matlab
A_lift(t) = kron(eye(n), A(t)) + kron(B(t)', eye(n)) + kron(G(t)', F(t))
K_lift(t) = kron(eye(n), K(t))
```

**Why non-factorizable:** The three terms in A_lift(t) do not commute, so Φ_A_lift(T,0) ≠ Φ_B* ⊗ Φ_A in general. The Frobenius norm ‖M − Φ_B* ⊗ Φ_A‖_F = 468.7 confirms this numerically.

---

## Key Theoretical Results

### Proposition — Non-Factorizability of M
The composite monodromy M = Φ_{A_lift}(T,0) is generically non-factorizable whenever the three summands of A_lift(t) fail to commute. This is the central algebraic obstruction that invalidates all classical Kronecker-based proof strategies.

### Theorem 1 — Kalman Controllability Criterion
The GBMS is Kalman controllable after k periods if and only if rank(W̃_k) = n², where:
```
W̃_{i+1} = W̃_i + M^{-i} · W̃_1 · (M^{-i})ᵀ
```
Each step costs O(n³) — replacing O(n⁴) numerical ODE integration.

### Theorem 2 — Kalman–Hewer Equivalence
For GBMS, Kalman controllability ⟺ Hewer controllability, proved entirely via the minimal polynomial of M, without any Kronecker factorisation assumption.

**Why minimal polynomial replaces Kronecker:**
In the classical BCG framework, eigenvectors of Mᵀ are tensor products, enabling reduction to lower-dimensional subproblems. When M is non-factorizable, this fails. The minimal polynomial p_min(M) replaces it: it provides an annihilating polynomial for the Gramian recursion, showing that k = deg p_min(M) periods are both necessary and sufficient.

### Theorem 3 — Sharp Controllability Horizon
```
k = deg p_min(M) ≤ n²
```
The bound n² is the worst-case; in practice k equals the number of distinct eigenvalue moduli of M. For the n=3 example: k=3 ≪ n²=9.

### Theorem 4 — Minimum-Energy Control Law
```
u*(t) = -K(t)ᵀ Φ_{K_lift}(t,T)ᵀ vec(W̃_k⁻¹ (X_target − M^k X_0))
J* = x₀ᵀ W̃_k⁻¹ x₀ ≤ σ_min(W̃_k)⁻¹ · ‖X_target − Φ X_0‖²
```

---

## Position in the Controllability Hierarchy

```
Lyapunov (Bittanti 1984)
    ⊂
Sylvester (Deekshitulu & Jaya Lakshmi 2009)
    ⊂
Generalized Bilinear ← THIS PAPER (Madhyannapu & Kumar 2026)
```

Each level adds structural complexity:
- **Lyapunov:** M factorises as Φ_A ⊗ Φ_A, minimal polynomial degree ≤ n
- **Sylvester:** M = Φ_B* ⊗ Φ_A, minimal polynomial degree ≤ n
- **Generalized Bilinear:** M non-factorizable, minimal polynomial degree ≤ n²

---

## Companion Papers

| Paper | System Class | Journal | Repository |
|---|---|---|---|
| [SBLIPMS-Controllability](https://github.com/msvdsudarsan/SBLIPMS-Controllability) | Singular bilinear + impulses | Nonlinear Dynamics | ✅ |
| **This paper** | Generalized bilinear periodic | MCSS | — |
| [SBMPMS-observability](https://github.com/msvdsudarsan/SBMPMS-observability) | Melnikov observability breakdown | Chaos, Solitons & Fractals | ✅ |

---

## Citation

```bibtex
@article{Madhyannapu2026bilinear_mcss,
  author  = {Madhyannapu, Sri Venkata Durga Sudarsan and
             {Pradheep Kumar}, Sravanam},
  title   = {{Kalman--Hewer} Controllability Equivalence for
             Generalized Bilinear Matrix Periodic Systems with Non-Factorizable Monodromy},
  journal = {Mathematics of Control, Signals, and Systems},
  year    = {2026},
  publisher = {Springer},
  note    = {Submitted May 2026}
}
```

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## Contact

**Sri Venkata Durga Sudarsan Madhyannapu**  
Email: msvdsudarsan@gmail.com  
ORCID: [0009-0001-2126-6428](https://orcid.org/0009-0001-2126-6428)  
Institution: Dr. RVR NRI Institute of Technology (Deemed to be University), Andhra Pradesh, India
