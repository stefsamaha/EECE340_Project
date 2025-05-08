% File: mySample.m
function [t_sample, x_sample] = mySample(t, xt, fs)
    dt = 1/fs;
    indices = 1:round(dt/(t(2) - t(1))):length(t);
    t_sample = t(indices);
    x_sample = xt(indices);
end
