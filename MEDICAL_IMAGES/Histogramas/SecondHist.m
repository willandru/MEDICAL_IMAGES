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

% calcular la frecuencia de cada valor de intensidad
[x,y]=size(grayimg);
Freq=zeros(1,256);
for i=1:x
for j=1:y
Freq(grayimg(i,j)+1)=Freq(grayimg(i,j)+1)+1;
end
end
% calcular la funcion de densidad de probabilidad para cada intensidad
PDF=zeros(1,256);
Total=x*y;
for i=1:256
PDF(i)=Freq(i)/Total;
end
% calcular la funcion de densidad acumulada para cada intensidad

CDF=zeros(1,256);
CDF(1)=PDF(1);
for i=2:256
CDF(i)=CDF(i-1)+PDF(i);
end
% multiplicar por el maximo valor de intensidad del rango
Result=zeros(1,256);
for i=1:256
Result(i)=CDF(i)*(255);
end
% generar la imagen ecualizada
eqimg=uint8(zeros(size(grayimg)));
for i=1:x
for j=1:y
eqimg(i,j)=uint8(Result(grayimg(i,j)+1));
end
end
% visualizar la imagen ecualizada y su histograma
figure(2)
subplot(1,2,1)
imshow(eqimg);
subplot(1,2,2)
imhist(eqimg);

% guardar la imagen ecualizada en disco
imwrite(eqimg,"butterfly_eq.png");