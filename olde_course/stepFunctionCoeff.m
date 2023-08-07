clc, clear, close all;
t = 0:0.01:10;   % define the time vector with a step of 0.01s
y = zeros(size(t));   % create a zero vector of the same size as t
y(t<=1) = 10;   % set the values of y to 10 for t<=1
figure(1)
plot(t,y);   % plot the step signal
xlabel('Time (s)');
ylabel('Amplitude (V)');
title('Step Signal of 10 Volts Amplitude for 1 Second');



figure(2)
t = 0:0.01:10;   % define the time vector with a step of 0.01s
y = zeros(size(t));   % create a zero vector of the same size as t
y(t<=1) = 10;   % set the values of y to 10 for t<=1
y(t>5) = -y(t>5);   % reflect the positive half of the signal about the x-axis
plot(t,y);   % plot the even step signal
xlabel('Time (s)');
ylabel('Amplitude (V)');
title('Even Step Signal of 10 Volts Amplitude for 1 Second');


figure(3)
t = 0:0.01:10;   % define the time vector with a step of 0.01s
y = zeros(size(t));   % create a zero vector of the same size as t
y(t<=1) = 10;   % set the values of y to 10 for t<=1
T = 10;   % define the period of the signal
fs = 1/0.01;   % define the sample frequency
N = length(y);   % number of samples

% Obtain the Fourier series coefficients
fourier_coeff = (1/N) * fft(y);   % fft of the signal
fourier_coeff = fourier_coeff(1:N/2+1);   % only positive frequencies
fourier_coeff(2:end-1) = 2*fourier_coeff(2:end-1);   % multiply by 2, except the first and last terms

% Define the frequency axis
f = fs*(0:(N/2))/N;

% Plot the magnitude of the Fourier coefficients
stem(f,abs(fourier_coeff));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Fourier Series Coefficients of the Step Signal');
