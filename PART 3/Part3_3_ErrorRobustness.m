% ===========================================================
% EECE 340 - Part 3.3: Error & Robustness Analysis
% ===========================================================

% ---------- 1.  Load audio & build filtered version ----------
[x, Fs] = audioread('my_audio.wav');  x = x(:,1)';   % mono row vector
dur = 1;  N = Fs*dur;                               % 1‑s segment
x_seg = x(1:N);  t = (0:N-1)/Fs;

% Re‑create the low‑pass FIR filter (same as Part 3.1)
fc = 2000;  M = 101;   n = -(M-1)/2:(M-1)/2;
wc = 2*pi*fc/Fs;   h = (wc/pi).*sinc(wc*n/pi) .* hann(M)';
x_filt = conv(x_seg, h, 'same');

% ---------- 2.  Choose sampling rate & noise level ----------
fs = 4000;                     % 4 kHz sampling (just above cutoff)
noise_std = 0.1;               % Std‑dev of additive white noise

% ---------- 3.  Sample the filtered signal ----------
[t_samp, x_samp] = sample(t, x_filt, fs);

% ---------- 4.  Add white Gaussian noise ----------
rng default                % for reproducibility
noise = noise_std * randn(size(x_samp));
x_samp_noisy = x_samp + noise;

% ---------- 5.  Reconstruct from noisy samples ----------
reconstruct = @(tt, xs, ts, fs) ...
    arrayfun(@(ti) sum(xs .* sinc((ti-ts)/(1/fs))), tt);
x_recon_noisy = reconstruct(t, x_samp_noisy, t_samp, fs);

% ---------- 6.  Metrics: MSE & SNR ----------
mse_clean_vs_filt = mean((x_seg - x_filt).^2);
mse_filt_vs_recon = mean((x_filt - x_recon_noisy).^2);
snr_samples = snr(x_samp, noise);           % SNR of noisy samples
snr_recon   = snr(x_filt, x_recon_noisy - x_filt); % SNR after recon

fprintf('MSE (clean vs filtered)          : %.4e\n', mse_clean_vs_filt);
fprintf('MSE (filtered vs recon‑noisy)     : %.4e\n', mse_filt_vs_recon);
fprintf('SNR of noisy samples (dB)         : %.2f dB\n', snr_samples);
fprintf('SNR after reconstruction (dB)     : %.2f dB\n', snr_recon);

% ---------- 7.  Plot results ----------
figure;
subplot(3,1,1);
plot(t, x_seg, 'k'); title('Original Audio Segment'); xlabel('Time'); ylabel('Amp');

subplot(3,1,2);
stem(t_samp, x_samp_noisy, 'Marker', 'none'); hold on;
plot(t, x_filt, 'r'); hold off;
title(sprintf('Filtered Signal & Noisy Samples (fs = %d Hz)', fs));
legend('Noisy samples','Filtered clean'); xlabel('Time'); ylabel('Amp');

subplot(3,1,3);
plot(t, x_filt, 'r', t, x_recon_noisy, 'b--');
title('Reconstructed Signal vs Filtered Ground‑Truth');
legend('Filtered clean','Reconstructed (noisy)'); xlabel('Time'); ylabel('Amp');

% -------- Comment block summarising what this script does --------
% This script evaluates robustness to white Gaussian noise:
% 1.  A 1‑second audio segment is low‑pass filtered (2 kHz cutoff).
% 2.  The filtered signal is uniformly sampled at 4 kHz (just above cutoff),
%     then additive white noise (σ = 0.1) is injected into those samples.
% 3.  Sinc interpolation reconstructs the time‑continuous signal.
% 4.  MSE and SNR are computed to quantify degradation:
%       - 'snr_samples' shows noise power at the sample level.
%       - 'snr_recon' shows how reconstruction smooths noise.
%    Generally, the low‑pass filter limits bandwidth, so aliasing is avoided;
%    however, noise still reduces fidelity.  Oversampling further would
%    improve SNR of the reconstruction.  These results can be discussed in
%    the report as evidence of the trade‑off between sampling rate, filtering,
%    and noise robustness in real‑world system design.
% ===========================================================
