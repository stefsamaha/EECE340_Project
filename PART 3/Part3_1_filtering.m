% ===========================================================
% EECE 340 - Part 3.1: FIR Filtering and System Design
% ===========================================================

% --- Step 1: Load the audio signal again ---
[x, Fs] = audioread('340audio.wav');
x = x(:, 1)';  % Mono, row vector
clipDur = 0.10;                       % seconds
N       = round(clipDur * Fs);        % samples in 0.10 s
x       = x(1:N);         

% --- Step 2: Define filter parameters ---
fc = 2000;           % Cutoff frequency in Hz
M = 101;             % Filter length (odd number, e.g., 101 taps)
wc = 2 * pi * fc / Fs;     % Normalized angular cutoff
n = -(M-1)/2 : (M-1)/2;    % Symmetric time vector centered at 0

% --- Step 3: Design windowed sinc FIR filter ---
h = (wc/pi) * sinc(wc * n / pi);     % Ideal LPF impulse response
window = hann(M)';                   % Apply Hann window
h = h .* window;                     % Final FIR filter coefficients

% --- Step 4: Plot impulse and frequency response ---
figure;
subplot(2,1,1);
stem(n, h, 'filled');
title('Impulse Response of FIR Low-Pass Filter');
xlabel('n'); ylabel('h[n]');

subplot(2,1,2);
[H, f] = freqz(h, 1, 1024, Fs);
plot(f, abs(H));
title('Magnitude Response of FIR Filter');
xlabel('Frequency (Hz)'); ylabel('|H(f)|');
grid on;

% --- Step 5: Filter the audio signal ---
x_filtered = conv(x, h, 'same');  % Apply FIR filter via convolution

% --- Step 6: Time-domain comparison ---
t = (0:length(x)-1)/Fs;

figure;
subplot(2,1,1);
plot(t, x);
title('Original Audio Signal');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(t, x_filtered);
title('Filtered Audio Signal (Low-pass FIR)');
xlabel('Time (s)'); ylabel('Amplitude');

% --- Step 7: Frequency-domain comparison ---
T  = t(end) - t(1);                               % same duration
N  = length(x);                                   % number of samples
t_shifted = linspace(-T/2, T/2, N);               % force symmetry

[X_orig, f1, ~]  = ftr(x,t_shifted, T);
[X_filt, f2, ~]  = ftr(x_filtered, t_shifted, T);

figure;
plot(f1, abs(X_orig), 'k'); hold on;
plot(f2, abs(X_filt), 'r--');
legend('Original', 'Filtered');
title('Fourier Transform Comparison');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
grid on;

% --- after you finish designing h ---
Nh = (length(h)-1)/2;                % 50 for M = 101
hc = [h(Nh+1:end)  h(1:Nh)];         % causal coefficients  h[0]…h[100]

%if you want to visualize the whole transfer function uncomment the below
%syms z
%Hsym = poly2sym(hc, z);              % polynomial in z
%Hsym = subs(Hsym, z, z^(-1));        % express in z^{-1}
%pretty(Hsym) 
format long g
hc(1:6)          % first six taps (b0 … b5)
hc(end-5:end)    % last six taps (b95 … b100)
                   

