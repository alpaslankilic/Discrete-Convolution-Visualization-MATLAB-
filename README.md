# Discrete Convolution Visualization (MATLAB)

This project demonstrates **discrete-time convolution** using several approaches implemented in **MATLAB**.  
The goal of the project is to build an intuitive understanding of convolution in the **time domain** and its relationship with **multiplication in the frequency domain**.

The repository contains scripts that visualize the convolution process step-by-step, animate signal interaction, and verify the convolution theorem using the **Fast Fourier Transform (FFT)**.

---

# System Description

In discrete-time signal processing, convolution describes how an input signal interacts with a system's impulse response to produce an output signal.

Given

- input signal **x[n]**
- impulse response **h[n]**

the output signal **y[n]** is obtained through convolution.

---

# Convolution Equation

The discrete-time convolution operation is defined as

$$
y[n] = (x * h)[n] = \sum_{k=-\infty}^{\infty} x[k]\,h[n-k]
$$

This equation represents the following process:

1. The impulse response \(h[n]\) is shifted.
2. The shifted signal \(h[n-k]\) is multiplied with \(x[k]\).
3. The products are summed to produce the output \(y[n]\).

---

# Convolution Theorem

Convolution in the **time domain** corresponds to multiplication in the **frequency domain**.

$$
Y(e^{j\omega}) = X(e^{j\omega}) \cdot H(e^{j\omega})
$$

where

- \(X(e^{j\omega})\) is the Fourier transform of \(x[n]\)
- \(H(e^{j\omega})\) is the Fourier transform of \(h[n]\)
- \(Y(e^{j\omega})\) is the Fourier transform of the output signal

Therefore the output signal can also be computed using

$$
y[n] = \mathcal{F}^{-1}\{X(e^{j\omega})H(e^{j\omega})\}
$$

In numerical implementations this becomes

$$
y[n] = \mathrm{IFFT}(\mathrm{FFT}(x[n]) \cdot \mathrm{FFT}(h[n]))
$$

---

# Signals Used in the Simulation

The input signal used in the scripts is

$$
x[n] = a^n u[n]
$$

where

$$
0 < a < 1
$$

and \(u[n]\) is the **unit step function**.

The impulse response is defined as

$$
h[n] = u[n] - u[n-N]
$$

This corresponds to a finite rectangular pulse of length \(N\).

---

# Repository Structure

```
main.m
m01_manual_convolution.m
m02_convolution_animation.m
m03_fft_convolution.m
```

---

# Running the Project

Run the main script in MATLAB:

```matlab
main
```

This opens an interactive menu where you can select which demonstration to run.

The available options are:

1. Manual convolution
2. Convolution animation
3. FFT-based convolution
4. Run all scripts
5. Exit

---

# File Descriptions

## main.m

This script provides an **interactive menu interface** for running the project scripts.

The program repeatedly displays a menu using MATLAB's `menu()` function, allowing the user to choose which demonstration to execute.

Example structure of the menu loop:

```matlab
while true
    choice = menu('Discrete Convolution Project', ...);
```

Depending on the user's selection, the script runs one of the following files:

```matlab
run('m01_manual_convolution.m')
run('m02_convolution_animation.m')
run('m03_fft_convolution.m')
```

An option is also provided to run **all demonstrations sequentially**.

---

## m01_manual_convolution.m

### Manual Convolution Demonstration

This script demonstrates **discrete-time convolution step-by-step in the time domain**.

The convolution output is computed using the definition

$$
y[n] = \sum_{k=-\infty}^{\infty} x[k]h[n-k]
$$

The script explicitly performs the convolution process by:

1. Shifting the impulse response \(h[n]\) to form \(h[n-k]\)
2. Multiplying it with \(x[k]\)
3. Summing the products to obtain \(y[n]\)

At every iteration the following signals are visualized:

- input signal \(x[n]\)
- shifted impulse response \(h[n-k]\)
- pointwise product \(x[k]h[n-k]\)
- accumulated output signal \(y[n]\)

This visualization illustrates the **sliding and summation interpretation of convolution**.

Finally the result is compared with MATLAB's built-in function

```
conv(x,h)
```

to verify correctness.

---

## m02_convolution_animation.m

### Convolution Animation with Frequency-Domain Interpretation

This script provides an **animated visualization of the convolution process** while also showing its **frequency-domain representation**.

The animation updates both time-domain and frequency-domain plots during each step of the convolution process.

### Time-Domain Visualization

The animation displays

- the input signal \(x[n]\)
- the shifted impulse response \(h[n-k]\)
- the pointwise multiplication \(x[k]h[n-k]\)
- the partial convolution output \(y[n]\)

This shows how the convolution result gradually builds over time.

### Frequency-Domain Visualization

The spectra of the signals are computed using the discrete Fourier transform

$$
X(e^{j\omega}) = \mathrm{FFT}(x[n])
$$

$$
H(e^{j\omega}) = \mathrm{FFT}(h[n])
$$

According to the convolution theorem

$$
Y(e^{j\omega}) = X(e^{j\omega})H(e^{j\omega})
$$

During the animation the script computes the spectrum of the **partial convolution output** and compares it with the **final spectrum obtained from frequency-domain multiplication**.

This visualization helps demonstrate how convolution in the time domain corresponds to multiplication in the frequency domain.

---

## m03_fft_convolution.m

### FFT-Based Convolution

This script computes convolution using the **Fast Fourier Transform (FFT)**.

Instead of directly computing

$$
y[n] = \sum_{k=-\infty}^{\infty} x[k]h[n-k]
$$

the convolution theorem is used

$$
Y(e^{j\omega}) = X(e^{j\omega})H(e^{j\omega})
$$

The algorithm implemented in the script is

1. Zero-pad both signals to length \(L\)
2. Compute the FFT of each signal

$$
X = \mathrm{FFT}(x)
$$

$$
H = \mathrm{FFT}(h)
$$

3. Multiply the spectra

$$
Y = X \cdot H
$$

4. Transform the result back to the time domain

$$
y[n] = \mathrm{IFFT}(Y)
$$

The result is compared with MATLAB’s built-in function

```
conv(x,h)
```

to confirm that the FFT-based method produces the same linear convolution result.

The script also visualizes

- magnitude spectra \( |X(e^{j\omega})| \)
- magnitude spectra \( |H(e^{j\omega})| \)
- magnitude spectra \( |Y(e^{j\omega})| \)

and the corresponding phase spectra.

---

# Concepts Demonstrated

This project illustrates several important concepts in **Digital Signal Processing (DSP)**:

- discrete-time convolution
- signal shifting and multiplication
- convolution accumulation
- frequency-domain multiplication
- FFT-based convolution
- magnitude and phase spectra

---

# Verification

Three different convolution methods are compared:

1. Manual convolution
2. MATLAB `conv()` function
3. FFT-based convolution

All approaches produce the **same output signal**, confirming the convolution theorem.

---

# Requirements

MATLAB

No additional toolboxes are required.

---

# Educational Purpose

This project was created as an educational demonstration for understanding convolution in **Digital Signal Processing**.

It can be used as a teaching tool for courses in

- Digital Signal Processing
- Signals and Systems
- Linear Time-Invariant Systems
