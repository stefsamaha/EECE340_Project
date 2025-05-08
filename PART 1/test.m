% ==========================
% Fourier Transform Verification Script
% Part 1.2: Using rect-sinc and sine-delta duality
% ==========================

% === RECT ↔ SINC TEST ===
% Objective: Verify that the Fourier Transform of a rectangular pulse 
% produces a sinc-shaped spectrum, and that applying the inverse transform 
% reconstructs the original signal.

% Define parameters for time domain
T = 2;                      % Total duration of the time window [-1, 1]
N = 1000;                   % Number of time samples
t = linspace(-T/2, T/2, N); % Time vector
dt = t(2) - t(1);           % Time step

% Define a rectangular pulse centered at t = 0, width = 1
xt = double(abs(t) <= 0.5); % Logical indexing: 1 inside [-0.5, 0.5], 0 elsewhere

% Plot the original rectangular function
figure;
plot(t, xt, 'k', 'LineWidth', 2);
title('Original rect(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Compute Fourier Transform using custom ftr function
[f, xf, W] = ftr(xt, t, T);

% Plot the magnitude of the Fourier Transform
% The result should resemble a sinc function in frequency domain
figure;
plot(f, abs(xf), 'b', 'LineWidth', 2);
title('Magnitude of Fourier Transform of rect(t)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

% Reconstruct the time-domain signal using custom iftr function
[t_rec, xt_rec, T_check] = iftr(xf, f, W);

% Plot the original vs. reconstructed signal for visual comparison
figure;
plot(t, xt, 'k', 'LineWidth', 2); hold on;
plot(t_rec, real(xt_rec), 'r--', 'LineWidth', 2); % Real part only due to small imaginary errors
legend('Original rect(t)', 'Reconstructed from FT');
title('Reconstruction using Inverse Fourier Transform');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% === SINE ↔ DELTA TEST ===
% Objective: Verify that the Fourier Transform of a sine wave produces two 
% impulses in the frequency domain (at ±f₀), and that the inverse FT 
% reconstructs the original sine.

% Define sine wave parameters
f0 = 5;                           % Frequency of sine wave in Hz
xt_sin = sin(2 * pi * f0 * t);    % Continuous-time sine signal

% Plot the original sine wave
figure;
plot(t, xt_sin, 'k', 'LineWidth', 2);
title('Original sine wave: sin(2πf₀t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Compute the Fourier Transform of the sine wave
[f_sin, xf_sin, W_sin] = ftr(xt_sin, t, T);

% Plot the magnitude spectrum of the sine wave
% Expected result: two symmetric peaks at ±f₀, resembling delta functions
figure;
plot(f_sin, abs(xf_sin), 'b', 'LineWidth', 2);
title('Magnitude of Fourier Transform of sin(2πf₀t)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

% Apply the Inverse Fourier Transform to recover the sine wave
[t_sin_rec, xt_sin_rec, ~] = iftr(xf_sin, f_sin, W_sin);

% Plot the original and reconstructed sine signals
figure;
plot(t, xt_sin, 'k', 'LineWidth', 2); hold on;
plot(t_sin_rec, real(xt_sin_rec), 'r--', 'LineWidth', 2); % Ignore imaginary part
legend('Original sin(2πf₀t)', 'Reconstructed');
title('Reconstruction of sine wave using Inverse FT');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
