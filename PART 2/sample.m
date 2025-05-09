function [t_sample, x_sample] = sample(t, xt, fs)
% ================================
% EECE 340 Project - Part 2.1: Sampling
% ================================

% --------- Sampling Function ---------
    % Samples a given signal xt at time vector t with a sampling frequency fs

    % Calculate the sampling interval
    dt = 1/fs;

    % Find sampling indices based on ratio of dt to native time resolution
    indices = 1:round(dt/(t(2) - t(1))):length(t);

    % Extract sampled time and values
    t_sample = t(indices);
    x_sample = xt(indices);
end