clc, clear, close all;

% definicion de la longitud de las senales
length=linspace(-2*pi,2*pi);

% definicion de la senal
signal1=sin(length);

% definicion del ruido
noise1=0.5*rand(size(signal1));
% definicion del ruido 2
noise2=0.1*rand(size(signal1));
% definicion del ruido 3
noise3=1*rand(size(signal1));

% calculo de la relacion senal a ruido
snr1=snr(signal1,noise1)
% calculo de la relacion senal a ruido
snr2=snr(signal1,noise2)
% calculo de la relacion senal a ruido
snr3=snr(signal1,noise3)


% graficar la senal y el ruido estimado
figure(1)
subplot(2,1,1)
plot(signal1), title('Señal')
subplot(2,1,2)
plot(noise1)
hold on
plot(noise2)
hold on
plot(noise3), title('Ruidos')
legend('Noise 1','Noise 2', 'Noise 3')
