clear all;
close all;
clc;

%Definir el DOMINIO

L=2*pi;
N=1024;
dx=2*L/(N-1);
x=-L:dx:L;

%Definir la FUNCIÓN
figure(1)
f=0*x;
f(N*3/8:N*5/8)=1;
plot(x,f)
ylim([-1 2])

%Computar la Serie de Fourier
figure(2)
A0= sum(f.*ones(size(x)))*dx/pi;
fFS= A0/2;

CC=jet(100);
for k=1:100
    A(k)= sum(f.*cos(pi*k*x/L))*dx/pi;
    B(k)= sum(f.*sin(pi*k+x/L))*dx/pi;
    fFS= fFS + A(k)*cos(k*pi*x/L) + B(k)*sin(k*pi*x/L);
    plot(x, fFS, '-', 'Color', CC(k,:))
    pause(.2)
    hold on
end



