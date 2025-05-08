function x_recon = reconstruct(t, x_sample, t_sample, fs)
    % Reconstructs a signal using custom sinc interpolation (toolbox-free)
    x_recon = zeros(size(t));
    Ts = 1/fs;

    for i = 1:length(t)
        x_recon(i) = sum(x_sample .* custom_sinc((t(i) - t_sample) / Ts));
    end
end

function y = custom_sinc(x)
    % Custom normalized sinc: sin(pi*x)/(pi*x), handles x = 0 safely
    y = ones(size(x));
    idx = x ~= 0;
    y(idx) = sin(pi * x(idx)) ./ (pi * x(idx));
end
