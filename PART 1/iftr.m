function [t, xt, T] = iftr(xf, f, W)
    % Inverse Fourier Transform computed manually using bandwidth W
    % Inputs:
    %   xf - vector of values in the frequency domain (X(f))
    %   f  - corresponding frequency points
    %   W  - total frequency range (bandwidth)

    % Frequency spacing
    df = f(2) - f(1);        % Difference between consecutive frequency points
    N = length(xf);          % Number of points in the frequency domain

    % Use bandwidth to determine time spacing and duration
    dt = 1 / W;              % Time step
    T = N * dt;              % Total signal length
    t = (-T/2):dt:(T/2 - dt);% Time vector centered around zero

    % Allocate space for the reconstructed time-domain signal
    xt = zeros(1, N);

    % Perform the inverse transform by summing over frequency components
    for n = 1:N
        sum = 0;
        for k = 1:N
            sum = sum + xf(k) * exp(1j * 2 * pi * f(k) * t(n));
        end
        xt(n) = sum * df;    % Scale the result to approximate the inverse integral
    end

    % Returns: time vector t, reconstructed signal xt, and total duration T
end
