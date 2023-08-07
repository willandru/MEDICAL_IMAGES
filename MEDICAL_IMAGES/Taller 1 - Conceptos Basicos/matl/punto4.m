clc, clear, close all

% cargar una imagen de ejemplo de MATLAB
imdata = imread('street2.jpg');
% obtener la version en escala de grises de la imagen
g_imdata = rgb2gray(imdata);
% obtener la transformada de Fourier de la imagen
F = fft2(g_imdata);
% obtener el espectro centrado de frecuencias y orientaciones
Fsh = fftshift(F);
% aplicar una transformacion logaritmica para facilitar la visualizacion
S2 = log(1+abs(Fsh));
% finalmente, reconstruir la imagen original
F2 = ifftshift(Fsh);
f = ifft2(F2);


% visualizar las imagenes y el espectro de la transformada
figure(1)
subplot(2,2,1)
imshow(g_imdata), title('Imagen original (en escala de grises)')
subplot(2,2,3)
imshow(S2,[]), title('Espectro de la transformada de Fourier')
subplot(2,2,4)
imshow(f,[]), title('Imagen reconstruida')

%% 

% cargar una imagen de ejemplo de MATLAB
imdata_circle = imread('circulo.jpg');
% obtener la version en escala de grises de la imagen
g_imdata_circle = rgb2gray(imdata_circle);
% obtener la transformada de Fourier de la imagen
F_circle = fft2(g_imdata_circle);
% obtener el espectro centrado de frecuencias y orientaciones
Fsh_circle = fftshift(F_circle);
% aplicar una transformacion logaritmica para facilitar la visualizacion
S2_circle = log(1+abs(Fsh_circle));
% finalmente, reconstruir la imagen original
F2_circle = ifftshift(Fsh_circle);
f_circle = ifft2(F2_circle);

% cargar una imagen de ejemplo de MATLAB
imdata_v = imread('voronoi.png');
% obtener la version en escala de grises de la imagen
g_imdata_v = rgb2gray(imdata_v);
% obtener la transformada de Fourier de la imagen
F_v = fft2(g_imdata_v);
% obtener el espectro centrado de frecuencias y orientaciones
Fsh_v = fftshift(F_v);
% aplicar una transformacion logaritmica para facilitar la visualizacion
S2_v = log(1+abs(Fsh_v));
% finalmente, reconstruir la imagen original
F2_v = ifftshift(Fsh_v);
f_v = ifft2(F2_v);

% visualizar las imagenes y el espectro de la transformada
figure(2)
subplot(2,2,1)
imshow(g_imdata_circle), title('Imagen original CIRCULO (en escala de grises)')
subplot(2,2,3)
imshow(S2_circle,[]), title('Espectro de Fourier')
subplot(2,2,4)
imshow(f_circle,[]), title('Imagen reconstruida')
sgtitle('Imagen de un Circulo representando Baja Frecuencia')


figure(3)
subplot(2,2,1)
imshow(g_imdata_v), title('Imagen original VORONOI (en escala de grises)')
subplot(2,2,3)
imshow(S2_v,[]), title('Espectro de Fourier ')
subplot(2,2,4)
imshow(f_v,[]), title('Imagen reconstruida')
sgtitle('Imagen de Voronoi representando Alta Frecuencia')
