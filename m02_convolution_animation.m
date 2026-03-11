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
L = Lx + N - 1;
ny = 0:(L-1);
y = zeros(1, L);

% FFT settings
Nfft = L;
w_shift = (-floor(Nfft/2):ceil(Nfft/2)-1) * (2*pi/Nfft);

% Fixed spectra
x_pad = [x zeros(1, Nfft - length(x))];
h_pad = [h zeros(1, Nfft - length(h))];

X = fft(x_pad, Nfft);
H = fft(h_pad, Nfft);

Xsh = fftshift(X);
Hsh = fftshift(H);

% Final frequency-domain result
Y_final = X .* H;
Y_final_sh = fftshift(Y_final);

% Figure
figure;

for n = 1:L

    % Shifted h[n-k]
    h_shifted = zeros(1, length(nx));
    for k = 1:length(nx)
        if (n - k + 1 > 0) && (n - k + 1 <= N)
            h_shifted(k) = h(n - k + 1);
        end
    end

    % Product and partial sum
    product = x .* h_shifted;
    y(n) = sum(product);

    % Partial output
    y_partial = zeros(1, L);
    y_partial(1:n) = y(1:n);

    % Partial spectrum
    Yp = fft(y_partial, Nfft);
    Yp_sh = fftshift(Yp);

    % Plot
    clf;

    subplot(4,2,1)
    stem(nx, x, 'filled');
    grid on;
    title('x[n]');
    ylim([0 1]);

    subplot(4,2,3)
    stem(nx, h_shifted, 'filled');
    grid on;
    title(['Shifted h[n-k], n = ', num2str(n-1)]);
    ylim([0 1.2]);

    subplot(4,2,5)
    stem(nx, product, 'filled');
    grid on;
    title('x[k] * h[n-k]');

    subplot(4,2,7)
    stem(ny(1:n), y(1:n), 'filled');
    grid on;
    title('Partial output y[n]');
    xlim([0 L-1]);

    subplot(4,2,2)
    plot(w_shift, abs(Xsh), 'LineWidth', 1.5);
    grid on;
    title('|X(e^{j\omega})|');
    xlabel('\omega');
    ylabel('Magnitude');

    subplot(4,2,4)
    plot(w_shift, abs(Hsh), 'LineWidth', 1.5);
    grid on;
    title('|H(e^{j\omega})|');
    xlabel('\omega');
    ylabel('Magnitude');

    subplot(4,2,6)
    plot(w_shift, abs(Yp_sh), 'LineWidth', 1.5);
    grid on;
    hold on;
    plot(w_shift, abs(Y_final_sh), 'r--', 'LineWidth', 1.2);
    title('|Y_{partial}(e^{j\omega})| and final reference');
    xlabel('\omega');
    ylabel('Magnitude');
    legend('Partial', 'Final');

    subplot(4,2,8)
    plot(w_shift, angle(Yp_sh), 'LineWidth', 1.5);
    grid on;
    title('Phase of partial output');
    xlabel('\omega');
    ylabel('Phase (rad)');

    pause(0.8);
end

% Verification
y_conv = conv(x, h);
y_fft = real(ifft(Y_final, Nfft));

figure;
stem(0:L-1, y_conv, 'filled');
hold on;
stem(0:L-1, y_fft, 'r--');
grid on;
legend('conv()', 'FFT multiplication + IFFT');
title('Linear convolution verification');
xlabel('n');
ylabel('y[n]');