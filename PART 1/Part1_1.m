% In this part, we are trying to check the effect of changing n and T on
% the quality of the reconstructed signal xhat(t). As such, we will take a
% triangular signal as our example, and we will try to reconstruct it using
% different values of n and T while keeping record of the error in each
% case. 

%First, let's define our triangular signal. 
% Define the time vector and triangle signal
t = linspace(-1, 1, 1000);
xt = max(1 - abs(t), 0);

% Plotting the original signal
figure;
plot(t, xt, 'k', 'LineWidth', 2);
hold on;
legendStrings = {'Original Signal'};

%Let's first find the period of this triangular signal. We are assuming T
%to be the total duration of the signal. Typically, the value of T should
%be equal to the period of the signal that is being reconstructed. However,
%in our case, we are having only one instance of the signal x(t). 
T = t(end)-t(1);

%Let's now take different arbitrary values for n starting from 10 up to 200.
n_values = [2 5 10 20 50 100 200];

% Calculate the Fourier series approximation and plot them for varying n
% and fixed T. 
errors_n = zeros(length(n_values), 1);

    for i = 1:length(n_values)
        n = n_values(i);
        [xhat, ~] = ffs(xt, t, n, T);
        plot(t, real(xhat));
        legendStrings{end + 1} = ['T = ', num2str(T), ', n = ', num2str(n)];
        %trapz is a function method used to compute the integral numerically for error
        %computation. An alternative would be to use a for loop to evaluate
        %the integral. 
        errors_n(i) = trapz(t, (xt - real(xhat)).^2);
    end
legend(legendStrings, 'Location', 'SouthOutside');
title('Fourier Series Approximations for Different n and T=2');
hold off;

%Plotting the square of the error vs n 
figure;
plot(n_values, errors_n, '-o');
xlabel('Number of coefficients (n)');
ylabel('Square Error');
title('Error vs. n with Fixed T');

%Now, we will fix a large value for n (n=100), then we will vary the
%period T. Then we will plot xhat for those different values of T.
%Define our n
n = 100;
%Define the T values to be considered (varying the period from 2 to 10
%with a step of 0.5) while having n fixed at 200.
T_values = 0.5:0.5:10;

figure;
plot(t, xt, 'k', 'LineWidth', 2);
hold on;
legendStrings = {'Original Signal'};

% Calculate the Fourier series approximation and plot them
% For varying T with fixed n
errors_T = zeros(length(T_values), 1);
for i = 1:length(T_values)
        T = T_values(i);
        [xhat, ~] = ffs(xt, t, n, T);
        plot(t, real(xhat));
        legendStrings{end + 1} = ['T = ', num2str(T), ', n = ', num2str(n)];
        errors_T(i) = trapz(t, (xt - real(xhat)).^2);
end

legend(legendStrings, 'Location', 'SouthOutside');
title('Fourier Series Approximations for Different T and fixed n = 100');
hold off;

%Plot square error vs T (fixed n = 100)
figure;
plot(T_values, errors_T, '-o');
xlabel('Period (T)');
ylabel('Square Error');
title('Error vs. T with Fixed n=100');


