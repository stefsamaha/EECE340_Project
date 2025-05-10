function [f, xf, W] = ftr(xt, t, T)
    % Custom Fourier Transform function using a defined time window T
    % Inputs:
    %   xt - vector of signal values
    %   t  - vector of time points
    %   T  - total duration of the signal (should match t range)

    % Check that the time vector starts at -T/2 and ends at T/2
    if t(1) ~= -T/2 || t(end) ~= T/2
        error('Time vector t must span from -T/2 to T/2');
    end

    % Compute basic parameters
    dt = t(2) - t(1);       % Time step between samples
    N = length(xt);         % Total number of samples
    df = 1/T;               % Frequency resolution
    W = N * df;             % Total bandwidth
    f = (-W/2):df:(W/2-df); % Frequency axis (centered around 0)

    % Allocate memory for the Fourier transform result
    xf = zeros(1, N);

    % Manually compute the Fourier transform using the definition
    for k = 1:N
        sum = 0;
        for n = 1:N
            sum = sum + xt(n) * exp(-1j * 2 * pi * f(k) * t(n));
        end
        xf(k) = sum * dt;   % Scale result to approximate integral
    end

    % Outputs: frequency vector (f), transformed signal (xf), and bandwidth (W)
end
