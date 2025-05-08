% Define parameters
t = -5:0.01:5; % Define t-axis values
xt = zeros(size(t)); % Initialize xt values

% Set the range where the rectangle is 1
idx = (t >= -0.5) & (t <= 0.5);
xt(idx) = 1;

% Plot the rectangular function
plot(t, xt, 'LineWidth', 2);
xlabel('t');
ylabel('Rectangular Function');
title('Rectangular Function with Width 1');
axis([-5 5 -0.2 1.2]);
grid on;

% Define the period T of the signal
T = t(end)-t(1);  % Total duration where the function is considered (the rect spans less than this)

% Apply the Fourier Transform
[f, xf, W] = ftr(xt, t, T);

% Plot the magnitude of the Fourier transform
figure;
plot(f, abs(xf));
title('Magnitude of the Fourier Transform of the Rectangular Function');
xlabel('Frequency (f)');
ylabel('|X(f)|');
grid on;


% Reconstruct the signal
[t_rec, xt_rec, T_rec] = iftr(xf, f, W);

% Plot the reconstructed signal
figure;
plot(t_rec, xt_rec, 'LineWidth', 2);
xlabel('Time (t)');
ylabel('Reconstructed Rectangular Function');
title('Reconstructed Signal from its Fourier Transform');
axis([-5 5 -0.2 1.2]);
grid on;