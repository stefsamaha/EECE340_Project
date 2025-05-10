% Signal Definition 

% Frequency parameters
f1 = 3;   % Hz
f2 = 7;   % Hz
fmax = max(f1, f2);  % fmax = 7 Hz

% Time vector for the original "continuous" signal
T = 2;                       % total duration
N = 1000;                    % number of points
t = linspace(0, T, N);       % time base
xt = cos(2*pi*f1*t) + 0.5*cos(2*pi*f2*t); % signal

% Sampling Rates 
fs_values = [0.5*fmax, fmax, 2*fmax];  % Sampling frequencies: under, critical, over
colors = ['r', 'g', 'b'];              % Colors for plotting

%  Plotting Original Signal 
figure;
plot(t, xt, 'k', 'LineWidth', 1.5); hold on;
title('Original Signal with Sampled Points at Various Rates');
xlabel('Time (s)');
ylabel('x(t)');
legend_entries = {'Original Signal'};

% Sampling and Plotting 
for i = 1:length(fs_values)
    fs = fs_values(i);
    [t_sample, x_sample] = sample(t, xt, fs);
    
    % Plot sampled points on top of original
    plot(t_sample, x_sample, [colors(i) 'o'], 'DisplayName', ...
         sprintf('Samples at f_s = %.1f Hz', fs));
    legend_entries{end+1} = sprintf('f_s = %.1f Hz', fs);
end

legend(legend_entries, 'Location', 'best');
grid on;

