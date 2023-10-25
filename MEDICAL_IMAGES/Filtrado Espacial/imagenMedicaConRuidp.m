clc, clear, close all;

% cargar la imagen
img=imread("ImagenMedica.jpg");
% convertir a escala de grises
grayimg=im2gray(img);
% agregar ruido Gaussiano a la imagen
gauss_img=imnoise(grayimg,'gaussian',0,0.02);
% agregar ruido de Poisson a la imagen
poiss_img=imnoise(grayimg,'poisson');
% agregar ruido de sal y pimienta a la imagen
salpe_img=imnoise(grayimg,'salt & pepper', 0.05);
% visualizar la imagen original y sus versiones con ruido
figure(1)
subplot(2,2,1)
imshow(grayimg);
title('Original')
subplot(2,2,2)
imshow(gauss_img);
title("Ruido Gaussiano, sigma=0.02")
subplot(2,2,3)
imshow(poiss_img);
title("Ruido de Poisson")
subplot(2,2,4)
imshow(salpe_img);
title("Ruido Sal y Pimienta, p=0.05")
sgtitle('Crear imágenes con ruido')
% guardar las imagenes con ruido
imwrite(gauss_img,"IM_gauss.png");
imwrite(poiss_img,"IM_poiss.png");
imwrite(salpe_img,"IM_salpe.png");