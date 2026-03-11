% FFT-based convolution

L = Lx + N - 1;
x_pad = [x zeros(1, L - length(x))];
h_pad = [h zeros(1, L - length(h))];

% FFT
X = fft(x_pad, L);
H = fft(h_pad, L);

% Multiplication in frequency domain
Y = X .* H;

% Back to time domain
y_ifft = ifft(Y, L);
y_ifft = real(y_ifft);

% Compare with conv()
y_conv2 = conv(x, h);

% Frequency axis
w = (0:L-1) * (2*pi/L);
w_shift = (-floor(L/2):ceil(L/2)-1) * (2*pi/L);

% Shifted spectra
Xsh = fftshift(X);
Hsh = fftshift(H);
Ysh = fftshift(Y);

% Magnitude spectra
figure;
subplot(3,1,1)
plot(w_shift, abs(Xsh), 'LineWidth', 1.5);
grid on;
title('|X(e^{j\omega})|');
xlabel('\omega (rad/sample)');
ylabel('Magnitude');

subplot(3,1,2)
plot(w_shift, abs(Hsh), 'LineWidth', 1.5);
grid on;
title('|H(e^{j\omega})|');
xlabel('\omega (rad/sample)');
ylabel('Magnitude');

subplot(3,1,3)
plot(w_shift, abs(Ysh), 'LineWidth', 1.5);
grid on;
title('|Y(e^{j\omega})| = |X| * |H|');
xlabel('\omega (rad/sample)');
ylabel('Magnitude');

% Phase spectra
figure;
subplot(3,1,1)
plot(w_shift, angle(Xsh), 'LineWidth', 1.5);
grid on;
title('Phase of X(e^{j\omega})');
xlabel('\omega');
ylabel('Phase (rad)');

subplot(3,1,2)
plot(w_shift, angle(Hsh), 'LineWidth', 1.5);
grid on;
title('Phase of H(e^{j\omega})');
xlabel('\omega');
ylabel('Phase (rad)');

subplot(3,1,3)
plot(w_shift, angle(Ysh), 'LineWidth', 1.5);
grid on;
title('Phase of Y(e^{j\omega})');
xlabel('\omega');
ylabel('Phase (rad)');

% Time-domain comparison
figure;
stem(ny, y, 'filled');
hold on;
stem(0:L-1, y_conv2, 'r--');
stem(0:L-1, y_ifft, 'g:', 'LineWidth', 1.5);
grid on;
legend('Manual', 'conv()', 'FFT + IFFT');
title('Time-domain comparison');
xlabel('n');
ylabel('y[n]');