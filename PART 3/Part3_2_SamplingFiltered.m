% ===========================================================
% EECE 340 - Part 3.2: Sampling & Reconstruction of Filtered Signal
% ===========================================================

% ---------- 1.  Load audio and extract 1‑s segment ----------
[x, Fs] = audioread('my_audio.wav');
x = x(:,1)';                         % mono → row vector
dur = 1;                             % 1‑second segment
N   = Fs*dur;
x_seg = x(1:N);
t    = (0:N-1)/Fs;

% ---------- 2.  Low‑pass FIR filter (reuse coeffs from Part 3.1) ----------
% ---- If you saved h in workspace, comment out the next 15 lines ----
fc = 2000;                           % 2‑kHz cutoff
M  = 101;                            % 101‑tap windowed‑sinc
n  = -(M-1)/2:(M-1)/2;
wc = 2*pi*fc/Fs;
h  = (wc/pi) .* sinc(wc*n/pi);       % ideal LPF impulse resp.
h  = h .* hann(M)';                  % windowed
% ---------------------------------------------------------------------

x_filt = conv(x_seg, h, 'same');     % filtered version

% ---------- 3.  Sampling rates to test ----------
fs_vec = [2000, 4000, 8000];         % Hz – below, ≈, and >> cutoff

% ---------- 4.  Utility: sinc‑reconstruction ----------
reconstruct = @(tt, xs, ts, fs) ...
    arrayfun(@(ti) sum(xs .* sinc((ti-ts)/(1/fs))), tt);

% ---------- 5.  Loop over each fs, sample & reconstruct ----------
err_orig = zeros(size(fs_vec));
err_filt = zeros(size(fs_vec));

for idx = 1:length(fs_vec)
    fs = fs_vec(idx);
    Ts = 1/fs;
    t_samp = 0:Ts:(dur-Ts);
    
    % --- Sample both signals ---
    [~, x_samp_o] = sample(t, x_seg, fs);
    [~, x_samp_f] = sample(t, x_filt, fs);
    
    % --- Reconstruct ---
    x_rec_o = reconstruct(t, x_samp_o, t_samp, fs);
    x_rec_f = reconstruct(t, x_samp_f, t_samp, fs);
    
    % --- Compute MSE errors ---
    err_orig(idx) = mean((x_seg  - x_rec_o).^2);
    err_filt(idx) = mean((x_filt - x_rec_f).^2);
    
    % --- Plot comparison for this fs ---
    figure('Name',sprintf('fs = %d Hz',fs));
    subplot(2,1,1);
    plot(t, x_seg,  'k', t, x_rec_o, 'r--'); hold on;
    stem(t_samp, x_samp_o, 'g.'); hold off;
    title(sprintf('Original vs Reconstructed  (fs = %d Hz)',fs));
    legend('Original', 'Reconstructed', 'Samples');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;
    
    subplot(2,1,2);
    plot(t, x_filt, 'k', t, x_rec_f, 'b--'); hold on;
    stem(t_samp, x_samp_f, 'g.'); hold off;
    title(sprintf('Filtered vs Reconstructed  (fs = %d Hz)',fs));
    legend('Filtered', 'Reconstructed', 'Samples');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;
end

% ---------- 6.  Error bar‑plot ----------
figure;
bar(fs_vec, [err_orig.' err_filt.']);
title('MSE of Reconstruction vs Sampling Rate');
xlabel('Sampling Rate (Hz)'); ylabel('Mean‑Square Error');
legend('Original Signal', 'Filtered Signal');
grid on;

% =====================  Comment Summary  =====================
% This script samples both the raw and low‑pass‑filtered audio segment
% at three different rates (2 kHz, 4 kHz, 8 kHz).  After sinc‑based
% reconstruction, it quantifies mean‑square error (MSE).  Filtering the
% signal removes components above the 2‑kHz cutoff, so the filtered
% version better survives aggressive undersampling (e.g., 2 kHz) with
% dramatically lower reconstruction error, demonstrating how pre‑filtering
% mitigates aliasing and improves fidelity at reduced sampling rates.
% =============================================================
