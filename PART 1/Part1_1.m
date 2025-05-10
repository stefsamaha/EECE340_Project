% Triangular Signal: Effect of n
% Here we look at how the number of Fourier terms (n) affects how well we can
% approximate a triangular signal. The idea is that more harmonics should give us a closer
% fit to the original signal.

t = linspace(-1, 1, 1000);               % Define time vector from -1 to 1
xt = max(1 - abs(t), 0);                 % Define triangular waveform
T = t(end) - t(1);                       % Set the period of the signal

n_values = [2 5 10 20 50 100 200];       % Try out different values of n (number of harmonics)
errors_n = zeros(length(n_values), 1);  % Store approximation error for each n

figure;
plot(t, xt, 'k', 'LineWidth', 2); hold on;   % Plot the original signal
legendStrings = {'Original Signal'};        % Start building the legend

for i = 1:length(n_values)
    n = n_values(i);
    [xhat, ~] = ffs(xt, t, n, T);             % Approximate signal using n harmonics
    plot(t, real(xhat));                     % Plot the reconstructed signal
    legendStrings{end+1} = ['T = ', num2str(T), ', n = ', num2str(n)];
    errors_n(i) = trapz(t, (xt - real(xhat)).^2); % Calculate squared error between original and approximation
end

legend(legendStrings, 'Location', 'SouthOutside');
title('Fourier Series Approximations for Different n (Triangular Signal)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

figure;
plot(n_values, errors_n, '-o');              % Plot how the error changes as n increases
xlabel('Number of Harmonics (n)');
ylabel('Squared Error');
title('Error vs. n with Fixed T (Triangular Signal)');

% --- Triangular Signal: Effect of T ---
% This time we keep n fixed and vary the assumed period T. We'll see how a mismatch
% between T and the signal duration affects the approximation.

n = 100;
T_values = 0.5:0.5:10;                  % Try different periods
errors_T = zeros(length(T_values), 1);

figure;
plot(t, xt, 'k', 'LineWidth', 2); hold on;
legendStrings = {'Original Signal'};

for i = 1:length(T_values)
    T = T_values(i);
    [xhat, ~] = ffs(xt, t, n, T);
    plot(t, real(xhat));
    legendStrings{end+1} = ['T = ', num2str(T)];
    errors_T(i) = trapz(t, (xt - real(xhat)).^2);
end

legend(legendStrings, 'Location', 'SouthOutside');
title('Fourier Series Approximations for Different T (n = 100)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

figure;
plot(T_values, errors_T, '-o');
xlabel('Period T');
ylabel('Squared Error');
title('Error vs. T with Fixed n = 100');

% Gaussian Pulse Test:
% Try the approximation on a smooth, non-periodic signal (Gaussian pulse).
% We’ll see that the series can still fit reasonably well inside the window.

t = linspace(-3, 3, 1000);
xt = exp(-t.^2);
T = t(end) - t(1);
n = 50;

[xhat, ~] = ffs(xt, t, n, T);

figure;
plot(t, xt, 'k', 'LineWidth', 2); hold on;
plot(t, real(xhat), 'r--');
title('Fourier Series Approximation of Gaussian Pulse');
legend('Original Signal', sprintf('Reconstructed (n = %d)', n));
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

% Windowed Sine Signal Test 
% Now test the Fourier approximation on a sine wave that's only active
% in a limited time interval (windowed sine).

t = linspace(-2, 2, 1000);
xt = sin(2*pi*t) .* (abs(t) < 1);     % Sine only between -1 and 1
T = t(end) - t(1);
n = 50;

[xhat, ~] = ffs(xt, t, n, T);

figure;
plot(t, xt, 'k', 'LineWidth', 2); hold on;
plot(t, real(xhat), 'b--');
title('Fourier Series Approximation of Windowed Sine');
legend('Original Signal', sprintf('Reconstructed (n = %d)', n));
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
