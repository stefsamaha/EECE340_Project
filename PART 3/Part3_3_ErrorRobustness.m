% 1. Load a 0.10-second segment and design a low-pass filter
[x, Fs] = audioread('340audio.wav');   x = x(:,1)';    % Use only one channel (mono)
dur = 0.10;                             N  = round(Fs * dur);  % Number of samples
xSeg = x(1:N);                          t  = (0:N-1)/Fs;       % Time vector

fc = 2000;  M = 101;                    % Filter cutoff at 2 kHz, 101 taps
n = -(M-1)/2 : (M-1)/2;                
wc = 2*pi*fc/Fs;                        % Cutoff in radians
h = (wc/pi).*sinc(wc*n/pi) .* hann(M)';% Windowed-sinc low-pass filter
xFilt = conv(xSeg, h, 'same');         % Apply the filter to the segment

% 2. Set noise levels and sampling rate
fs = 4000;                 % Sampling frequency in Hz
sigmaCont = 0.002;         % Standard deviation of noise added before sampling
sigmaADC  = 0.002;         % Noise added after sampling (ADC simulation)
rng default                % For consistent results on every run

% 3. Add continuous-time noise, then sample
xFiltNoisy = xFilt + sigmaCont * randn(size(xFilt));         % Add noise before sampling
[tSamp, xSamp] = sample(t, xFiltNoisy, fs);                  % Sample the noisy signal

% 4. Add ADC noise to the sampled values
xSampNoisy = xSamp + sigmaADC * randn(size(xSamp));          % Simulate quantization or digitization noise

% 5. Reconstruct the signal from the noisy samples
xReconNoisy = reconstruct(t, xSampNoisy, tSamp, fs);         % Use your own sinc interpolator

% 6. Calculate quality metrics
mse_filt_vs_recon = mean((xFilt - xReconNoisy).^2);          % MSE between clean filtered and noisy reconstruction
snr_samples = snr(xSamp, xSampNoisy - xSamp);                % SNR right after sampling
snr_recon   = snr(xFilt, xReconNoisy - xFilt);               % SNR after full reconstruction

fprintf('\nMSE (filtered vs recon-noisy) : %.3e\n', mse_filt_vs_recon);
fprintf('SNR  noisy samples            : %.2f  dB\n', snr_samples);
fprintf('SNR  after reconstruction     : %.2f  dB\n\n', snr_recon);

% 7. Plot the results to see the effect of noise
figure('Name','Noise influence @ 4 kHz','Color','w');

subplot(3,1,1)
plot(t, xSeg, 'k'); grid on
title('Original Audio Segment')
ylabel('Amp')
xlim([0 dur])

subplot(3,1,2)
stem(tSamp, xSampNoisy, 'Marker', 'none'); hold on
plot(t, xFilt, 'r', 'LineWidth', 1); hold off
grid on
title(sprintf('Filtered Truth & Noisy Samples (f_s = %d Hz)', fs))
legend('Noisy samples', 'Filtered clean')
ylabel('Amp')
xlim([0 dur])

subplot(3,1,3)
plot(t, xFilt, 'r', t, xReconNoisy, 'b--'); grid on
title('Reconstruction vs Filtered Ground-Truth')
legend('Filtered clean', 'Reconstructed (noisy)')
xlabel('Time (s)')
ylabel('Amp')
xlim([0 dur])
