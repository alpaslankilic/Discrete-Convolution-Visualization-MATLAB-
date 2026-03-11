clc;
clear;
close all;

while true
    choice = menu('Discrete Convolution Project', ...
        '1 - Manual Convolution', ...
        '2 - Convolution Animation', ...
        '3 - FFT Convolution', ...
        '4 - Run All', ...
        '5 - Exit');

    switch choice
        case 1
            clc;
            close all;
            run('m01_manual_convolution.m');

        case 2
            clc;
            close all;
            run('m02_convolution_animation.m');

        case 3
            clc;
            close all;
            run('m03_fft_convolution.m');

        case 4
            clc;
            close all;
            disp('Running 01_manual_convolution.m ...');
            run('m01_manual_convolution.m');

            disp('Running 02_convolution_animation.m ...');
            run('m02_convolution_animation.m');

            disp('Running 03_fft_convolution.m ...');
            run('m03_fft_convolution.m');

        case 5
            disp('Exiting project...');
            break;

        otherwise
            disp('Invalid selection.');
    end
end