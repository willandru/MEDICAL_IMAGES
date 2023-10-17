clc, clear, close all;

% cargar la imagen
img=imread("12-histogramas-ejercicios-archivos/butterfly.png");
% convertir a escala de grises
grayimg=im2gray(img);
% visualizar la imagen y su histograma
figure(1)
subplot(1,2,1)
imshow(grayimg);
subplot(1,2,2)
imhist(grayimg);



% definir las intensidades en los extremos del rango actual de representacion
% es decir, el rango dentro del cual se quiere normalizar
% (se especifican manualmente)
min=45;
max=100;
% trabajar sobre una copia de la imagen con tipo de dato real
% para utilizar mayor precision en los calculos
realimg=double(grayimg);
% aplicar la ecuacion de normalizacion del histograma
normimg=(realimg-min)./(max-min);
% multiplicar por el valor maximo del rango de representacion
normimg=normimg.*255;
% convertir de nuevo a tipo de dato entero para facilitar la visualizacion
entimg=uint8(normimg);
% visualizar la imagen normalizada y su histograma

figure(2)
subplot(1,2,1)
imshow(entimg);
subplot(1,2,2)
imhist(entimg);
% guardar la imagen normalizada en disco
imwrite(entimg,"butterfly_norm.png");