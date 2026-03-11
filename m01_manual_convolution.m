clc;
clear;
close all;

% Parameters
a = 0.7;
N = 8;
Lx = 15;

% x[n] = a^n u[n]
nx = 0:Lx-1;
x = a.^nx;

% h[n] = u[n] - u[n-N]
nh = 0:N-1;
h = ones(1, N);

% Convolution length
ny = 0:(Lx + N - 2);
y = zeros(1, length(ny));

% Step-by-step convolution
figure;

for n = 1:length(ny)

    h_shifted = zeros(1, length(nx));

    for k = 1:length(nx)
        if (n - k + 1 > 0) && (n - k + 1 <= N)
            h_shifted(k) = h(n - k + 1);
        end
    end

    % Product
    product = x .* h_shifted;

    % Summation
    y(n) = sum(product);

    % Plot
    clf;

    subplot(4,1,1)
    stem(nx, x, 'filled')
    title('x[n]')
    ylim([0 1])

    subplot(4,1,2)
    stem(nx, h_shifted, 'filled')
    title(['Shifted h[n-k], n = ', num2str(n-1)])
    ylim([0 1.2])

    subplot(4,1,3)
    stem(nx, product, 'filled')
    title('Product x[k] * h[n-k]')

    subplot(4,1,4)
    stem(ny(1:n), y(1:n), 'filled')
    title('Output y[n]')

    pause(0.8);
end

% Compare with conv()
y_conv = conv(x, h);

figure;
stem(ny, y, 'filled')
hold on
stem(ny, y_conv, 'r--')
legend('Step-by-step', 'conv()')
title('Manual convolution vs conv()')