% ============================
% EECE 340 - Part 2.4: Noise Robustness
% ============================

% --- Signal setup ---
f = 5;                          % Signal frequency (Hz)
T_total = 2;                    % Total duration (s)
t_fine = 0:0.001:T_total;       % Fine time vector for "continuous" signal
xt = cos(2*pi*f*t_fine);        % Original signal

% --- Sampling rates to test ---
fs_values = [10, 30];           % Near Nyquist and Oversampling
noise_std = 0.3;                % Standard deviation of white noise

% --- Loop through each sampling rate ---
for i = 1:length(fs_values)
    fs = fs_values(i);
    Ts = 1/fs;
    t_sample = 0:Ts:T_total;
    x_sample_clean = cos(2*pi*f*t_sample);

    % Add white Gaussian noise to the samples
    x_sample_noisy = x_sample_clean + noise_std * randn(size(x_sample_clean));

    % Reconstruct from noisy samples
    x_recon_noisy = reconstruct(t_fine, x_sample_noisy, t_sample, fs);

    % --- Plotting ---
    figure;
    plot(t_fine, xt, 'k', 'LineWidth', 2); hold on;
    stem(t_sample, x_sample_noisy, 'r', 'filled');
    plot(t_fine, x_recon_noisy, 'b--', 'LineWidth', 1.5);
    title(sprintf('Reconstruction with Noise at f_s = %d Hz', fs));
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Original Signal', 'Noisy Samples', 'Reconstructed Signal');
    grid on;
end

% ---------------------------------------------------------------
% This script demonstrates the impact of additive white Gaussian noise
% on sinc-based signal reconstruction. A 5 Hz cosine wave is sampled 
% at two different rates — 10 Hz (near Nyquist) and 30 Hz (oversampled).
% Gaussian noise (σ = 0.3) is added to each sample before applying 
% sinc interpolation. Results show that higher sampling rates improve 
% reconstruction robustness by reducing interpolation error in noisy 
% conditions. Oversampling thus serves as an effective strategy for 
% noise mitigation in digital signal processing.
% ---------------------------------------------------------------
