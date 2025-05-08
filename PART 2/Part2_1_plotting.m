% ================================
% EECE 340 Project - Part 2.1: Sampling
% ================================

% --------- Signal Definition ---------

f1 = 3;   % Hz
f2 = 7;   % Hz
fmax = max(f1, f2);  % fmax = 7 Hz

T = 2;                       % total duration
N = 1000;                    % number of points
t = linspace(0, T, N);       % time base
xt = cos(2*pi*f1*t) + 0.5*cos(2*pi*f2*t); % signal

% --------- Sampling Rates ---------

fs_values = [0.5*fmax, fmax, 2*fmax];  % Sampling frequencies
colors = ['r', 'g', 'b'];              % Plot colors

% --------- Plotting Original Signal ---------

figure;
plot(t, xt, 'k', 'LineWidth', 1.5); hold on;
title('Original Signal with Sampled Points at Various Rates');
xlabel('Time (s)');
ylabel('x(t)');
legend_entries = {'Original Signal'};

% --------- Sampling and Plotting ---------

for i = 1:length(fs_values)
    fs = fs_values(i);
    [t_sample, x_sample] = mySample(t, xt, fs);  % Call external function
    plot(t_sample, x_sample, [colors(i) 'o'], 'DisplayName', ...
         sprintf('Samples at f_s = %.1f Hz', fs));
    legend_entries{end+1} = sprintf('f_s = %.1f Hz', fs);
end

legend(legend_entries, 'Location', 'best');
grid on;
