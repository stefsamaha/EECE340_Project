% EECE 340 - Part 2.3: Aliasing and Ambiguity

% Time vector for visualization (high resolution)
t = 0:0.001:1;  % 1 second duration

% Original signal: cos(2π·5*t)
xt = cos(2*pi*5*t);

% Sampling frequency
fs = 8;  
Ts = 1/fs;
t_sample = 0:Ts:1;  % Sample times

% Sampled version of original signal
x_sample = cos(2*pi*5*t_sample);

% Plot original signal and its samples
figure;
plot(t, xt, 'k', 'LineWidth', 1.5); hold on;
stem(t_sample, x_sample, 'r', 'filled');
title('Original Signal cos(2π·5t) and Its Samples at f_s = 8 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Signal', 'Sampled Points');
grid on;

% Now try another signal: cos(2π·(5 ± 8)t) → Try 13 Hz
x_alias = cos(2*pi*13*t_sample);

% Compare the sampled values
disp("Original samples (5 Hz):");
disp(x_sample);
disp("Aliased samples (13 Hz):");
disp(x_alias);

% Check equality
disp("Difference between samples:");
disp(x_sample - x_alias);  % Should be near-zero

% Optional: overlay both sampled signals
figure;
stem(t_sample, x_sample, 'r', 'filled'); hold on;
stem(t_sample, x_alias, 'b');
legend('Samples from cos(2π·5t)', 'Samples from cos(2π·13t)');
title('Aliased Signal Comparison at f_s = 8 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% ---------------------------------------------------------------
% This script demonstrates the concept of aliasing by sampling 
% x(t) = cos(2π·5t) at a rate of fs = 8 Hz. It shows that another 
% signal, x(t) = cos(2π·13t), produces the exact same sampled 
% values when sampled at this rate due to aliasing. This occurs 
% because 13 Hz and 5 Hz differ by a multiple of the sampling 
% frequency (fs), so they are aliases: 
%     |13 - 8| = 5 Hz.
%
% By comparing the samples of both signals, we observe that 
% they overlap perfectly, creating ambiguity in signal identity 
% based on samples alone. 
% This ambiguity can be resolved only if we assume prior 
% knowledge, such as that the original signal is bandlimited 
% (e.g., to below Nyquist frequency fs/2), which would rule out 
% the higher-frequency alternative.
% ---------------------------------------------------------------
