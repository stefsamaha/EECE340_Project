% Signal parameters
f0 = 2;                 % Fundamental frequency in Hz
T = 1/f0;               % Period of the rectangular function
t = linspace(-T/2, T/2, 1000);  % Time vector over one period
xt = double(abs(t) <= T/4);     % Rectangular pulse of width T/2

% Plot the rectangular function
figure;
plot(t, xt, 'LineWidth', 2);
title('Centered Rectangular Function');
xlabel('Time (s)');
ylabel('Amplitude');

% Fourier Transform using fft
N = length(t);
dt = t(2) - t(1);
f = (-N/2:N/2-1) / (N * dt);     % Frequency vector
X_f = fftshift(fft(xt));        % Centered FFT
W = 2 * pi * f;                 % Angular frequency (optional)

% Plot Fourier Transform magnitude
figure;
plot(f, abs(X_f), 'LineWidth', 2);
title('Fourier Transform of One Period of Rectangular Function');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

% Fourier Series coefficients using ffs 
n = 50;  % Number of harmonics on each side
[xhat, ck] = ffs(xt, t, n, T);  % Custom function you must have already

% Plot Fourier Series coefficients
k = -n:n;              % Harmonic indices
figure;
stem(k, abs(ck), 'filled');
title('Fourier Series Coefficients of Rectangular Function');
xlabel('Harmonic Number k');
ylabel('|c_k|');
xlim([-n-5, n+5]);
grid on;

