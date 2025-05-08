% ==============================
% EECE 340 - Part 1.1: Fourier Series Approximation
% ==============================

%% --- Triangular Signal: Effect of n ---
t = linspace(-1, 1, 1000);
xt = max(1 - abs(t), 0);
T = t(end) - t(1);  % Period

n_values = [2 5 10 20 50 100 200];
errors_n = zeros(length(n_values), 1);

figure;
plot(t, xt, 'k', 'LineWidth', 2); hold on;
legendStrings = {'Original Signal'};

for i = 1:length(n_values)
    n = n_values(i);
    [xhat, ~] = ffs(xt, t, n, T);
    plot(t, real(xhat));
    legendStrings{end+1} = ['T = ', num2str(T), ', n = ', num2str(n)];
    errors_n(i) = trapz(t, (xt - real(xhat)).^2);
end

legend(legendStrings, 'Location', 'SouthOutside');
title('Fourier Series Approximations for Different n (Triangular Signal)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

figure;
plot(n_values, errors_n, '-o');
xlabel('Number of Harmonics (n)');
ylabel('Squared Error');
title('Error vs. n with Fixed T (Triangular Signal)');

%% --- Triangular Signal: Effect of T ---
n = 100;
T_values = 0.5:0.5:10;
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

%% --- Gaussian Pulse Test ---
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

%% --- Windowed Sine Signal Test ---
t = linspace(-2, 2, 1000);
xt = sin(2*pi*t) .* (abs(t) < 1);
T = t(end) - t(1);
n = 50;

[xhat, ~] = ffs(xt, t, n, T);

figure;
plot(t, xt, 'k', 'LineWidth', 2); hold on;
plot(t, real(xhat), 'b--');
title('Fourier Series Approximation of Windowed Sine');
legend('Original Signal', sprintf('Reconstructed (n = %d)', n));
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
