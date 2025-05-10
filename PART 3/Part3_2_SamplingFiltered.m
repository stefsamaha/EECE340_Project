% 1. Load the audio file and extract a short segment
[x, Fs] = audioread('340audio.wav');    % Read the audio file
x = x(:,1)';                            % Convert to mono if stereo, make it a row vector
dur = 0.10;                             % Duration of the segment to analyze (0.1 seconds)
N   = Fs * dur;                         % Number of samples in the segment
x_seg = x(1:N);                         % Extract the segment
t    = (0:N-1)/Fs;                      % Time vector for the segment

% 2. Design a low-pass FIR filter (useful before sampling to reduce aliasing)
% If you already saved the filter coefficients (h), you can skip this part.
fc = 2000;                              % Set cutoff frequency to 2 kHz
M  = 101;                               % Use 101 taps in the filter
n  = -(M-1)/2 : (M-1)/2;                % Define symmetric range around zero
wc = 2*pi*fc/Fs;                        % Convert cutoff to radians
h  = (wc/pi) .* sinc(wc * n / pi);      % Ideal low-pass filter impulse response
h  = h .* hann(M)';                     % Apply a Hann window to smooth it

x_filt = conv(x_seg, h, 'same');        % Apply the filter to the signal

% 3. Sampling rates to test
fs_vec = [2000, 4000, 8000];            % Try sampling at 2 kHz, 4 kHz, and 8 kHz

% 4. Define a helper function for sinc-based reconstruction
reconstruct = @(tt, xs, ts, fs) ...
    arrayfun(@(ti) sum(xs .* sinc((ti - ts)/(1/fs))), tt);

% 5. Loop through each sampling rate, sample the signal, reconstruct, and compute error
err_orig = zeros(size(fs_vec));         % Error for the original (unfiltered) signal
err_filt = zeros(size(fs_vec));         % Error for the filtered signal

for idx = 1:length(fs_vec)
    fs = fs_vec(idx);                   % Current sampling rate
    Ts = 1/fs;                          % Corresponding sampling interval
    t_samp = 0:Ts:(dur - Ts);           % Sample times

    % Sample both the original and filtered signals
    [~, x_samp_o] = sample(t, x_seg, fs);
    [~, x_samp_f] = sample(t, x_filt, fs);

    % Reconstruct the signals using sinc interpolation
    x_rec_o = reconstruct(t, x_samp_o, t_samp, fs);
    x_rec_f = reconstruct(t, x_samp_f, t_samp, fs);

    % Measure reconstruction accuracy using mean-square error
    err_orig(idx) = mean((x_seg  - x_rec_o).^2);
    err_filt(idx) = mean((x_filt - x_rec_f).^2);

    % Plot the results for this sampling rate
    figure('Name', sprintf('fs = %d Hz', fs));
    subplot(2,1,1);
    plot(t, x_seg,  'k', t, x_rec_o, 'r--'); hold on;
    stem(t_samp, x_samp_o, 'g.'); hold off;
    title(sprintf('Original vs Reconstructed  (fs = %d Hz)', fs));
    legend('Original', 'Reconstructed', 'Samples');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;

    subplot(2,1,2);
    plot(t, x_filt, 'k', t, x_rec_f, 'b--'); hold on;
    stem(t_samp, x_samp_f, 'g.'); hold off;
    title(sprintf('Filtered vs Reconstructed  (fs = %d Hz)', fs));
    legend('Filtered', 'Reconstructed', 'Samples');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on;
end

% 6. Bar chart comparing reconstruction errors for each sampling rate
figure;
bar(fs_vec, [err_orig.' err_filt.']);
title('MSE of Reconstruction vs Sampling Rate');
xlabel('Sampling Rate (Hz)'); ylabel('Mean-Square Error');
legend('Original Signal', 'Filtered Signal');
grid on;

