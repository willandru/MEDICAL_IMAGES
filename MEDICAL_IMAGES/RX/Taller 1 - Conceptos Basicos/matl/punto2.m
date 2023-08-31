clc, clear, close all;

% definicion de la senal aleatoria
data = rand(1,1000)- 0.5;

% definicion de las senales suaves
curv_rect = 1/61*ones(1,61);
t = 0:60;
curv_ham = -1/(61*2)*cos(1/61*2*pi*t) + 1/(61*2);

%Definicion de una senal INTERMEDIA
radio=30;
circular = sqrt(radio^2 - (t-radio).^2);
circular = circular* (0.0164/30);

% aplicar la convolucion sobre la senal aleatoria
rec_smooth = conv(data,curv_rect,'same');
ham_smooth = conv(data,curv_ham,'same');
cir_smooth = conv(data,circular,'same');

% graficar todas las senales

figure(1)
subplot(2,2,1)
plot(data,'k'), grid on, title('Senal aleatotria')
xlabel('x'), ylabel('y')

subplot(2,2,2)
plot(curv_rect,'b','LineWidth',2), title('Senales suaves'), grid on
hold on
plot(curv_ham,'r','LineWidth',2)
hold on
plot(circular,'g','LineWidth',2)
legend('Rectangular','Campana', 'Semi Circulo'), xlabel('x'), ylabel('y')

subplot(2,2,[3,4])
plot(rec_smooth,'b','LineWidth',2)
hold on
plot(ham_smooth,'r','LineWidth',2)
hold on
plot(cir_smooth,'g','LineWidth',2)
title('Senal simplificada por convolucion'), grid on