function [f, xf, W] = ftr(xt, t, T)
    % Fourier Transform Function implemented from scratch using T
    % Inputs:
    %   xt - row vector of signal samples x(t)
    %   t - row vector of time samples corresponding to xt
    %   T - scalar, duration of the signal window
    
    % Ensure t spans exactly from -T/2 to T/2
    if t(1) ~= -T/2 || t(end) ~= T/2
        error('Time vector t must span from -T/2 to T/2');
    end
    
    % Determine the frequency resolution and range
    dt = t(2) - t(1);           % Time step
    N = length(xt);             % Number of samples
    df = 1/T;                   % Frequency step based on period T
    W = N * df;                 % Maximum frequency, total bandwidth
    f = (-W/2):df:(W/2-df);     % Frequency vector

    % Initialize the Fourier transform vector
    xf = zeros(1, N);
    
    % Compute the Fourier transform from the definition provided
    for k = 1:N
        sum = 0;
        for n = 1:N
            sum = sum + xt(n) * exp(-1j * 2 * pi * f(k) * t(n));
        end
        xf(k) = sum * dt; % Multiply by dt to approximate the integral
    end
    
    % Output frequency vector, transformed data, and bandwidth
end
