% Define the frequency of the signal
f0 = 1; % Frequency of the cosine wave

% Create a time vector (over-sampled)
t = 0:0.001:2; % 2 seconds duration
xt = cos(2*pi*f0*t); % Signal x(t)

% Define sampling frequencies
fs1 = 0.5 * 2 * f0; % 0.5 times the Nyquist rate
fs2 = 2 * 2 * f0;   % 2 times the Nyquist rate

% Sample the signal at fs1 and fs2
[t_sample1, x_sample1] = sample(t, xt, fs1);
[t_sample2, x_sample2] = sample(t, xt, fs2);

% Plotting
figure;
subplot(2, 1, 1);
stem(t_sample1, x_sample1, 'filled');
title(['Sampled Signal at 0.5f_N (f_s = ', num2str(fs1), ' Hz)']);
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
stem(t_sample2, x_sample2, 'filled');
title(['Sampled Signal at 2f_N (f_s = ', num2str(fs2), ' Hz)']);
xlabel('Time (s)');
ylabel('Amplitude');


% Define a reconstruction time vector
t_rec = 0:0.0005:2; % Time vector for reconstruction
%Note that we can reconstruct using the same time vector or any other time
%vector. The time vector will implicate the distance between two points in
%the reconstructed time signal. 

% Reconstruct the signals using the previously sampled points
x_recon1 = reconstruct(t_rec, x_sample1, t_sample1, fs1);
x_recon2 = reconstruct(t_rec, x_sample2, t_sample2, fs2);

% Plotting the reconstructed signals
figure;
subplot(2, 1, 1);
plot(t_rec, x_recon1, 'LineWidth', 2);
hold on;
stem(t_sample1, x_sample1, 'filled');
title(['Reconstruction at 0.5f_N (f_s = ', num2str(fs1), ' Hz)']);
xlabel('Time (s)');
ylabel('Amplitude');
legend('Reconstructed', 'Sampled Points');

subplot(2, 1, 2);
plot(t_rec, x_recon2, 'LineWidth', 2);
hold on;
stem(t_sample2, x_sample2, 'filled');
title(['Reconstruction at 2f_N (f_s = ', num2str(fs2), ' Hz)']);
xlabel('Time (s)');
ylabel('Amplitude');
legend('Reconstructed', 'Sampled Points');