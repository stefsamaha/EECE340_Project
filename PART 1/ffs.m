function [xhat, ck] = ffs(xt, t, n, T)
    % Inputs:
    % xt - sampled values of the signal x(t)
    % t  - corresponding time points
    % n  - number of Fourier terms (positive and negative)
    % T  - period of the signal

    % Preallocate coefficient vector and reconstructed signal
    ck = zeros(1, 2*n+1);       % stores Fourier coefficients for k = -n to n
    xhat = zeros(size(t));      % will hold the reconstructed signal
    
    % Time step (assuming uniform sampling)
    dt = t(2) - t(1);           

    % Calculate Fourier coefficients
    for k = -n:n
        k_index = k + n + 1;    % MATLAB arrays start at 1, shift index accordingly
        for j = 1:length(t)
            ck(k_index) = ck(k_index) + xt(j) * exp(-1i * 2 * pi * k * t(j) / T) * dt;
        end
        ck(k_index) = ck(k_index) / T;  % scale to get final coefficient
    end

    % Reconstruct signal using the Fourier series
    for j = 1:length(t)
        for k = -n:n
            k_index = k + n + 1;
            xhat(j) = xhat(j) + ck(k_index) * exp(1i * 2 * pi * k * t(j) / T);
        end
    end
end
