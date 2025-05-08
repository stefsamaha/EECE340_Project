function [t, xt, T] = iftr(xf, f, W)
    % Inverse Fourier Transform Function implemented from scratch using W
    % Inputs:
    %   xf - row vector of the Fourier transform X(f)
    %   f - row vector of frequency samples corresponding to xf
    %   W - scalar, the total bandwidth

    % Frequency step
    df = f(2) - f(1);            % Frequency step size
    N = length(xf);              % Number of samples in frequency domain

    % Time step and range based on bandwidth
    dt = 1/W;                    % Time step size based on the bandwidth
    T = N * dt;                  % Total duration of the signal
    t = (-T/2):dt:(T/2-dt);      % Time vector

    % Initialize the time-domain signal vector
    xt = zeros(1, N);
    
    % Compute the Inverse Fourier Transform from the definition provided
    for n = 1:N
        sum = 0;
        for k = 1:N
            sum = sum + xf(k) * exp(1j * 2 * pi * f(k) * t(n));
        end
        xt(n) = sum * df; % Multiply by df to approximate the integral
    end
    
    % Output time vector, reconstructed data, and duration
end