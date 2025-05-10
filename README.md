# EECE 340 – Signal Processing Project

**Course**: EECE 340 – Signals and Systems  
**Institution**: American University of Beirut  
**Semester**: Spring 2025  
**Date**: May 10, 2025  
**Contributors**: Reind Ballout, Stefanie Samaha

---

## Overview

This project demonstrates the application of Fourier-based signal processing concepts using MATLAB. It is organized into three parts:

1. **Fourier Signal Representation**
2. **Sampling, Reconstruction, and Aliasing**
3. **Real-World Application: Audio Filtering and Noise Robustness**

---

## Project Structure

### PART 1 – Fourier Series and Transforms

Core functions and testing scripts for representing signals using Fourier analysis.

- `ffs.m` – Finite Fourier Series approximation
- `ftr.m` – Continuous-time Fourier Transform
- `iftr.m` – Inverse Fourier Transform
- `Part1_1.m` – Main script for analyzing effects of harmonics and period
- `Testing_Part1_2.m` – Tests with Gaussian and windowed sine signals

### PART 2 – Sampling and Reconstruction

Explores sampling, interpolation, and aliasing effects.

- `mySample.m` – Custom sampling function (alternative to built-in)
- `Part2_1_and_2_2.m` – Demonstrates basic sampling and aliasing
- `Part2_1_plotting.m` – Plots for sampled and reconstructed signals
- `Part2_3.m`, `Part2_4.m`, `Part2_5.m` – Step-by-step exploration of sampling rate effects
- `reconstruct.m` – Sinc-based reconstruction function
- `sample.m` – Signal sampling helper used across scripts

### PART 3 – Audio Application and Noise Analysis

Applies the tools to a real audio file and analyzes noise robustness.

- `340audio.wav` – Input audio file (10-second clip)
- `Part3_1_filtering.m` – FIR low-pass filter design and application
- `Part3_2_SamplingFiltered.m` – Sampling and reconstruction of filtered audio
- `Part3_3_ErrorRobustness.m` – Noise injection, SNR computation, and visual comparison

---

## How to Run

1. **Requirements**: MATLAB R2020b or later
2. Clone or download the repository. Place all files in the same folder.
3. Start by running scripts in this order:
   - `PART 1`: `Part1_1.m` and `Testing_Part1_2.m`
   - `PART 2`: `Part2_1_and_2_2.m`, `Part2_1_plotting.m`, etc.
   - `PART 3`: `Part3_1_filtering.m`, then proceed to `Part3_2_SamplingFiltered.m`, and `Part3_3_ErrorRobustness.m`

Each script will open relevant figures and print metrics (like MSE and SNR) to the command window.

---

## Test Cases

Functions are tested on:
- Gaussian pulse: \( x(t) = e^{-t^2} \)
- Windowed sine: \( x(t) = \sin(2\pi t) \) within \(|t| < 1\)
- Composite cosine: \( x(t) = \cos(2\pi \cdot 3t) + 0.5 \cos(2\pi \cdot 7t) \)

---

## Results Summary

- Fourier Series approximation improves with higher `n` and proper `T`.
- Aliasing appears clearly at sub-Nyquist rates and is mitigated with pre-filtering.
- Noise robustness improves significantly after low-pass filtering, as shown by MSE and SNR analysis.
- Pre-filtered signals maintain fidelity better at low sampling rates and under noisy conditions.

---

## Contribution Statement

- **Stefanie Samaha**: Implemented Fourier and sampling functions, wrote Part 1 and Part 2 scripts.
- **Reind Ballout**: Developed Part 3 (filtering and noise analysis), contributed to plotting and debugging.

Both contributors collaborated on the report, demo video, and presentation.

---

## Included Files

```
EECE340_Project/
│
├── PART 1/
│   ├── ffs.m
│   ├── ftr.m
│   ├── iftr.m
│   ├── Part1_1.m
│   └── Testing_Part1_2.m
│
├── PART 2/
│   ├── mySample.m
│   ├── Part2_1_and_2_2.m
│   ├── Part2_1_plotting.m
│   ├── Part2_3.m
│   ├── Part2_4.m
│   ├── Part2_5.m
│   ├── reconstruct.m
│   └── sample.m
│
├── PART 3/
│   ├── 340audio.wav
│   ├── Part3_1_filtering.m
│   ├── Part3_2_SamplingFiltered.m
│   └── Part3_3_ErrorRobustness.m
│
├── 340_project.pdf         # Final report
├── presentation.mp4        # Demo video presentation
└── README.md               # This file
```


