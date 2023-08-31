% definir el tamano del paso
dt = 0.1;

% definir la senal TRIANGULO f(t)
t1=-2:dt:2;
Ft=-abs(t1)+2;

% definir la segunda senal g(t), entrada del sistema
t2 = -2:dt:2;
Gt = 3*ones(1,length(t2));

% generar la respuesta del sistema a la entrada con la convolucion
yt = dt*conv(Ft,Gt);
yt_x = (1:length(yt))*dt + t2(1) + t1(1);


%% graficar todas las senales
figure(1)

subplot(2,2,1)
plot(tF,Ft,'r'),title('f(t) entrada del sistema')
grid on, xlim([-2 2])
xlabel('t'), ylabel('amplitud')

subplot(2,2,3)
plot(t2,Gt,'b'), title('g(t)  respuesta al impulso')
grid on , ylim([0 3.5])
xlabel('t'), ylabel('amplitud')

subplot(2,2,[2;4])
plot(yt_x,yt,'k'),title('f(t)*g(t) respuesta del sistema')

grid on, xlabel('t'), ylabel('amplitud')

sgtitle('Convolución de Señales')