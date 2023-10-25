clc, clear, close all;

% cargar la imagen con ruido
img=imread("IM_salpe.png");
% convertir a escala de grises
grayimg=im2gray(img);
% crear un kernel para filtro promedio 3x3
h = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
% filtrar la imagen con filtro promedio
prom_filt = uint8(conv2(grayimg,h,'same'));
% filtrar la imagen con filtro mediana
med_filt = medfilt2(grayimg);
% filtrar la imagen con filtro Gaussiano, sigma = 1
gauss_filt_1 = imgaussfilt(grayimg,1);
% visualizar la imagen con ruido y sus versiones filtradas
figure(1)
subplot(2,2,1)
imshow(grayimg);
title('Imágen original')
subplot(2,2,2)
imshow(prom_filt);
title('Filtro Promedio')
subplot(2,2,3)
imshow(med_filt);
title('Filtro Mediana')
subplot(2,2,4)
imshow(gauss_filt_1);
title('Filtro Gaussiano, sigma=1')
sgtitle('Filtrando la imágen con ruido Saly y Pimienta')

% guardar las imagenes filtradas
imwrite(prom_filt,"IM_gauss_prom.png");
imwrite(med_filt,"IM_gauss_med.png");
imwrite(gauss_filt_1,"IM_gauss_filt_1.png");
% cargar la imagen original
img2=imread("ImagenMedica.jpg");
% convertir a escala de grises
grayimg2=im2gray(img2);
% calcular las diferencias con respecto a la imagen original
diff1 = grayimg2-grayimg;
num_diff1 = sum(diff1(:)==0) / size(diff1(:),1)
diff2 = grayimg2-prom_filt;
num_diff2 = sum(diff2(:)==0) / size(diff2(:),1)
diff3 = grayimg2-med_filt;
num_diff3 = sum(diff3(:)==0) / size(diff3(:),1)
diff4 = grayimg2-gauss_filt_1;
num_diff4 = sum(diff4(:)==0) / size(diff4(:),1)
% visualizar las diferencias con respecto a la imagen original
figure(2)
subplot(2,2,1)
imshow(diff1);
title('Original - Ruido de Sal y Pimienta ')
subplot(2,2,2)
imshow(diff2);
title('Original - Filtro promedio')
subplot(2,2,3)
imshow(diff3);
title('Original - Filtro mediana')
subplot(2,2,4)
imshow(diff4);
title('Original - Filtro gaussiano, sigma=1')
sgtitle('Diferencia entre la imágen original y la filtrada.')