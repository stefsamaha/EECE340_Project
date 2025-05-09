% ===========================================================
% EECE‑340  –  Part 3.3   •   Noise‑robustness experiment
% ===========================================================
% Prerequisites (in the SAME folder or on your MATLAB path):
%   •  reconstruct.m  (your loop‑based sinc interpolator)
%   •  sample.m       (helper from earlier parts)
%   •  340audio.wav   (input audio)
% ===========================================================

%% 1  Load 0.10‑s audio slice & design 2‑kHz LPF
[x,Fs] = audioread('340audio.wav');   x = x(:,1)';    % mono
dur = 0.10;                            N  = round(Fs*dur);
xSeg = x(1:N);                         t  = (0:N-1)/Fs;

fc = 2000;  M = 101;   n = -(M-1)/2:(M-1)/2;
wc = 2*pi*fc/Fs;
h  = (wc/pi).*sinc(wc*n/pi) .* hann(M)';            % 101‑tap FIR
xFilt = conv(xSeg,h,'same');                        % clean, band‑limited

%% 2  Noise parameters  &  sampling rate
fs         = 4000;          % sampling rate  (Hz)
sigmaCont  = 0.002;         % white noise σ added BEFORE sampling
sigmaADC   = 0.002;         % white noise σ added TO samples
rng default                 % reproducible

%% 3  Add continuous‑time noise  ➔  sample
xFiltNoisy = xFilt + sigmaCont*randn(size(xFilt));
[tSamp,xSamp] = sample(t,xFiltNoisy,fs);

%% 4  Add ADC noise to the discrete samples
xSampNoisy = xSamp + sigmaADC*randn(size(xSamp));

%% 5  Reconstruct with YOUR sinc‑interpolator
xReconNoisy = reconstruct(t,xSampNoisy,tSamp,fs);   % ← uses your .m file

%% 6  Metrics
mse_filt_vs_recon = mean((xFilt - xReconNoisy).^2);
snr_samples = snr(xSamp,    xSampNoisy - xSamp);
snr_recon   = snr(xFilt,    xReconNoisy - xFilt);

fprintf('\nMSE (filtered vs recon‑noisy) : %.3e\n',mse_filt_vs_recon);
fprintf('SNR  noisy samples            : %.2f  dB\n',snr_samples);
fprintf('SNR  after reconstruction     : %.2f  dB\n\n',snr_recon);

%% 7  Three‑panel visual comparison
figure('Name','Noise influence @ 4 kHz','Color','w');

subplot(3,1,1)
plot(t,xSeg,'k'); grid on
title('Original Audio Segment'), ylabel('Amp'), xlim([0 dur])

subplot(3,1,2)
stem(tSamp,xSampNoisy,'Marker','none'); hold on
plot(t,xFilt,'r','LineWidth',1); hold off; grid on
title(sprintf('Filtered Truth & Noisy Samples  (f_s = %d Hz)',fs))
legend('Noisy samples','Filtered clean'), ylabel('Amp'), xlim([0 dur])

subplot(3,1,3)
plot(t,xFilt,'r',t,xReconNoisy,'b--'); grid on
title('Reconstruction vs Filtered Ground‑Truth')
legend('Filtered clean','Reconstructed (noisy)')
xlabel('Time (s)'), ylabel('Amp'), xlim([0 dur])
