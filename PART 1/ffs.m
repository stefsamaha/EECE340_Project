function [xhat, ck] = ffs(xt, t, n, T)
    % Input:
    % xt - vector of signal values x(t)
    % t - vector of time samples corresponding to xt
    % n - number of terms in the Fourier series (from -n to n)
    % T - period of the signal

    % Initialize the vectors for coefficients and the reconstructed signal
    ck = zeros(1, 2*n+1); % to hold coefficients from -n to n
    xhat = zeros(size(t)); % to hold the reconstructed signal values
    
    % assuming we have uniform spacing in our time vector t
    dt = t(2) - t(1); 

    % Compute Fourier coefficients ck
    for k = -n:n
        k_index = k + n + 1; % index shift to accommodate MATLAB indexing
        %Getting the value of the integral
        for j = 1:length(t)
            ck(k_index) = ck(k_index) + (xt(j) * exp(-1i*2*pi*k*t(j)/T) * dt);
        end
        %Multiplying by 1/T to get ck
        ck(k_index) = ck(k_index) / T;
    end

    % Compute the Fourier series approximation xhat from xkc
    for j = 1:length(t)
        for k = -n:n
            k_index = k + n + 1; % index shift for MATLAB indexing
            xhat(j) = xhat(j) + ck(k_index) * exp(1i*2*pi*k*t(j)/T);
        end
    end
end
