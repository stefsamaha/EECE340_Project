% ================================================
% EECE 340 - Part 3: Application and Analysis
% Using a Real Audio Signal
% ================================================

% --- Step 1: Load the audio file ---
[x, Fs] = audioread('my_audio.wav');  % x is a column vector, Fs is original sample rate
x = x(:, 1);                          % In case stereo, keep only one channel
x = x';                               % Make it a row vector

% --- Step 2: Extract a 1-second segment ---
duration = 1;                         % seconds
N = Fs * duration;
x_segment = x(1:N);
t = linspace(0, duration, N);         % time vector

% --- Step 3: Visualize time-domain segment ---
figure;
plot(t, x_segment);
title('Time-Domain Segment of Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% --- Step 4: Frequency content using custom FT ---
% Shift time vector around 0 for FT symmetry
t_shifted = t - mean(t);
[f, X_f, W] = ftr(x_segment, t_shifted, duration);

% Plot magnitude spectrum
figure;
plot(f, abs(X_f));
title('Frequency Content via Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');

% --- Step 5: Sample the signal at a lower rate (test aliasing) ---
fs_test = 4000;                      % Try downsampling to 4 kHz
[t_samp, x_samp] = sample(t, x_segment, fs_test);

% --- Step 6: Reconstruct the signal from samples ---
x_recon = reconstruct(t, x_samp, t_samp, fs_test);

% --- Step 7: Plot original vs sampled vs reconstructed ---
figure;
plot(t, x_segment, 'k', 'LineWidth', 1.5); hold on;
stem(t_samp, x_samp, 'r');              % sampled points
plot(t, x_recon, 'b--', 'LineWidth', 1.5);
legend('Original Signal', 'Sampled Points', 'Reconstructed Signal');
title(sprintf('Sampling & Reconstruction at f_s = %d Hz', fs_test));
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
