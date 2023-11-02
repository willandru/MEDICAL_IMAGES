clc, clear , close all;

G0_A1= im2gray(imread('001.jpg'));
G0_A2= im2gray(imread('002.jpg'));
G0_A3= im2gray(imread('003.jpg'));

G0_A1=G0_A1(780:1291,1530:2041); % 512X512
G0_A2=G0_A2(480:991,480:991); % 512X512
G0_A3=G0_A3(100:511,200:711); % 512X512

%TODAS LAS IMÁGENES ORIGINALES TIENEN UN TAMAÑO DE 512 X 512

%% PRIAMIDE GAUSSIANA

K= (1/256).*[1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4 ; 1 4 6 4 1];

%IMAGEN 1
%filtramos la imagen original, y luego la escalamos
F_G0_A1 = uint8(conv2(G0_A1, K, 'same'));
G1_A1 = F_G0_A1(1:2:end, 1:2:end, :); %256 X 256
%filtramos la imagen esaclada, y luego la reescalamos
F_G1_A1 = uint8(conv2(G1_A1, K, 'same'));
G2_A1 = F_G1_A1(1:2:end, 1:2:end, :); % 128 X 128
%filtramos la imagen esaclada, y luego la reescalamos
F_G2_A1 = uint8(conv2(G2_A1, K, 'same'));
G3_A1 = F_G2_A1(1:2:end, 1:2:end, :);  % 64 X 64
%filtramos la imagen esaclada, y luego la reescalamos
F_G3_A1 = uint8(conv2(G3_A1, K, 'same'));
G4_A1 = F_G3_A1(1:2:end, 1:2:end, :); % 32 X 32

figure()
subplot(2,2,1)
imshow(G0_A1)
subplot(2,2,2)
imshow(G1_A1)
subplot(2,2,3)
imshow(G2_A1)
subplot(2,2,4)
imshow(G3_A1)

%IMAGEN 2
%filtramos la imagen original, y luego la escalamos
F_G0_A2 = uint8(conv2(G0_A2, K, 'same'));
G1_A2 = F_G0_A2(1:2:end, 1:2:end, :); %256 X 256
%filtramos la imagen esaclada, y luego la reescalamos
F_G1_A2 = uint8(conv2(G1_A2, K, 'same'));
G2_A2 = F_G1_A2(1:2:end, 1:2:end, :); % 128 X 128
%filtramos la imagen esaclada, y luego la reescalamos
F_G2_A2 = uint8(conv2(G2_A2, K, 'same'));
G3_A2 = F_G2_A2(1:2:end, 1:2:end, :);  % 64 X 64
%filtramos la imagen esaclada, y luego la reescalamos
F_G3_A2 = uint8(conv2(G3_A2, K, 'same'));
G4_A2 = F_G3_A2(1:2:end, 1:2:end, :); % 32 X 32
figure()
subplot(2,2,1)
imshow(G0_A2)
subplot(2,2,2)
imshow(G1_A2)
subplot(2,2,3)
imshow(G2_A2)
subplot(2,2,4)
imshow(G3_A2)

%IMAGEN 3
%filtramos la imagen original, luego la escalamos.
F_G0_A3 = uint8(conv2(G0_A3, K, 'same'));
G1_A3 = F_G0_A3(1:2:end, 1:2:end, :); %256 X 256
%filtramos la imagen esaclada, y luego la reescalamos
F_G1_A3 = uint8(conv2(G1_A3, K, 'same'));
G2_A3 = F_G1_A3(1:2:end, 1:2:end, :); % 128 X 128
%filtramos la imagen esaclada, y luego la reescalamos
F_G2_A3 = uint8(conv2(G2_A3, K, 'same'));
G3_A3 = F_G2_A3(1:2:end, 1:2:end, :); % 64 X 64
%filtramos la imagen esaclada, y luego la reescalamos
F_G3_A3 = uint8(conv2(G3_A3, K, 'same'));
G4_A3 = F_G3_A3(1:2:end, 1:2:end, :); % 32 X 32
figure()
subplot(2,2,1)
imshow(G0_A3)
subplot(2,2,2)
imshow(G1_A3)
subplot(2,2,3)
imshow(G2_A3)
subplot(2,2,4)
imshow(G3_A3)

%% PIRAMIDE LAPLACIANA

% Calcula la pirámide Laplaciana

L4_A1=G4_A1;  %  32 X 32
L3_A1= G3_A1 -imresize(G4_A1, size(G3_A1)); % 64 X 64
L2_A1=  G2_A1 -imresize(G3_A1, size(G2_A1)); % 128 X 128
L1_A1=  G1_A1 -imresize(G2_A1, size(G1_A1)); % 256 X 256
L0_A1= G0_A1 -imresize(G1_A1, size(G0_A1)); % 521 X 512


L4_A2 = G4_A2; %  32 X 32
L3_A2 = G3_A2 - imresize(G4_A2, size(G3_A2)); % 64 X 64
L2_A2 = G2_A2 - imresize(G3_A2, size(G2_A2)); % 128 X 128
L1_A2 = G1_A2 - imresize(G2_A2, size(G1_A2)); % 256 X 256
L0_A2 = G0_A2 - imresize(G1_A2, size(G0_A2)); % 521 X 512

L4_A3 = G4_A3; %  32 X 32
L3_A3 = G3_A3 - imresize(G4_A3, size(G3_A3)); % 64 X 64
L2_A3 = G2_A3 - imresize(G3_A3, size(G2_A3)); % 128 X 128
L1_A3 = G1_A3 - imresize(G2_A3, size(G1_A3)); %256 X 256
L0_A3 = G0_A3 - imresize(G1_A3, size(G0_A3)); % 521 X 512

% Visualiza las pirámides Laplacianas para A1
figure;
subplot(2,3,1);
imshow(L4_A1);
title('L4 A1');
subplot(2,3,2);
imshow(L3_A1);
title('L3 A1');
subplot(2,3,3);
imshow(L2_A1);
title('L2 A1');
subplot(2,3,4);
imshow(L1_A1);
title('L1 A1');
subplot(2,3,5);
imshow(L0_A1);
title('L0 A1');

% Visualiza las pirámides Laplacianas para A2
figure;
subplot(2,3,1);
imshow(L4_A2);
title('L4 A2');
subplot(2,3,2);
imshow(L3_A2);
title('L3 A2');
subplot(2,3,3);
imshow(L2_A2);
title('L2 A2');
subplot(2,3,4);
imshow(L1_A2);
title('L1 A2');
subplot(2,3,5);
imshow(L0_A2);
title('L0 A2');

% Visualiza las pirámides Laplacianas para A3
figure;
subplot(2,3,1);
imshow(L4_A3);
title('L4 A3');
subplot(2,3,2);
imshow(L3_A3);
title('L3 A3');
subplot(2,3,3);
imshow(L2_A3);
title('L2 A3');
subplot(2,3,4);
imshow(L1_A3);
title('L1 A3');
subplot(2,3,5);
imshow(L0_A3);
title('L0 A3');


%% RECONSTRUCCIÓN DE LA IMÁGEN ORIGINAL


% Reconstruir la imagen original a partir de la pirámide Laplaciana


% Inicialización de la imagen reconstruida para A1
reconstructed_image_A1 = L4_A1;

% Reconstrucción para A1
reconstructed_image_A1 = imresize(reconstructed_image_A1, size(L3_A1)) + L3_A1;
reconstructed_image_A1 = imresize(reconstructed_image_A1, size(L2_A1)) + L2_A1;
reconstructed_image_A1 = imresize(reconstructed_image_A1, size(L1_A1)) + L1_A1;
reconstructed_image_A1 = imresize(reconstructed_image_A1, size(L0_A1)) + L0_A1;

% Inicialización de la imagen reconstruida para A2
reconstructed_image_A2 = L4_A2;

% Reconstrucción para A2
reconstructed_image_A2 = imresize(reconstructed_image_A2, size(L3_A2)) + L3_A2;
reconstructed_image_A2 = imresize(reconstructed_image_A2, size(L2_A2)) + L2_A2;
reconstructed_image_A2 = imresize(reconstructed_image_A2, size(L1_A2)) + L1_A2;
reconstructed_image_A2 = imresize(reconstructed_image_A2, size(L0_A2)) + L0_A2;

% Inicialización de la imagen reconstruida para A3
reconstructed_image_A3 = L4_A3;

% Reconstrucción para A3
reconstructed_image_A3 = imresize(reconstructed_image_A3, size(L3_A3)) + L3_A3;
reconstructed_image_A3 = imresize(reconstructed_image_A3, size(L2_A3)) + L2_A3;
reconstructed_image_A3 = imresize(reconstructed_image_A3, size(L1_A3)) + L1_A3;
reconstructed_image_A3 = imresize(reconstructed_image_A3, size(L0_A3)) + L0_A3;

% Visualiza las imágenes reconstruidas
figure;
subplot(2,3,1);
imshow(uint8(reconstructed_image_A1)); % Convierte la imagen a tipo uint8 si es necesario
title('Imagen Reconstruida A1');

subplot(2,3,2);
imshow(uint8(reconstructed_image_A2)); % Convierte la imagen a tipo uint8 si es necesario
title('Imagen Reconstruida A2');

subplot(2,3,3);
imshow(uint8(reconstructed_image_A3)); % Convierte la imagen a tipo uint8 si es necesario
title('Imagen Reconstruida A3');

subplot(2,3,4);
imshow(uint8(G0_A1)); % Convierte la imagen a tipo uint8 si es necesario
title('Imagen Orignial A1');

subplot(2,3,5);
imshow(uint8(G0_A2)); % Convierte la imagen a tipo uint8 si es necesario
title('Imagen Orignial A2');

subplot(2,3,6);
imshow(uint8(G0_A3)); % Convierte la imagen a tipo uint8 si es necesario
title('Imagen Orignial A3');

%% CANTIDAD DE INFORMACIÓN PERDIDA

% Calcular el MAPE para la imagen A1
non_zero_pixels_A1 = G0_A1(:) ~= 0;
mape_A1 = mean(abs(double(G0_A1(non_zero_pixels_A1)) - double(reconstructed_image_A1(non_zero_pixels_A1))) ./ double(G0_A1(non_zero_pixels_A1))) * 100;

% Calcular el MAPE para la imagen A2
non_zero_pixels_A2 = G0_A2(:) ~= 0;
mape_A2 = mean(abs(double(G0_A2(non_zero_pixels_A2)) - double(reconstructed_image_A2(non_zero_pixels_A2))) ./ double(G0_A2(non_zero_pixels_A2))) * 100;

% Calcular el MAPE para la imagen A3
non_zero_pixels_A3 = G0_A3(:) ~= 0;
mape_A3 = mean(abs(double(G0_A3(non_zero_pixels_A3)) - double(reconstructed_image_A3(non_zero_pixels_A3))) ./ double(G0_A3(non_zero_pixels_A3))) * 100;

% Mostrar los resultados
fprintf('MAPE para A1: %.2f%%\n', mape_A1);
fprintf('MAPE para A2: %.2f%%\n', mape_A2);
fprintf('MAPE para A3: %.2f%%\n', mape_A3);

%% GUARDAR LOS DATOS


% GUARDAR IMAGENES GAUSSIANAS Y LAPLACIANAS DE A1
imwrite(G0_A1, 'piramide_gaussiana_A1_nivel0.jpg');
imwrite(G1_A1, 'piramide_gaussiana_A1_nivel1.jpg');
imwrite(G2_A1, 'piramide_gaussiana_A1_nivel2.jpg');
imwrite(G3_A1, 'piramide_gaussiana_A1_nivel3.jpg');
imwrite(G4_A1, 'piramide_gaussiana_A1_nivel4.jpg');

imwrite(L0_A1, 'piramide_laplaciana_A1_nivel0.jpg');
imwrite(L1_A1, 'piramide_laplaciana_A1_nivel1.jpg');
imwrite(L2_A1, 'piramide_laplaciana_A1_nivel2.jpg');
imwrite(L3_A1, 'piramide_laplaciana_A1_nivel3.jpg');
imwrite(L4_A1, 'piramide_laplaciana_A1_nivel4.jpg');

% GUARDAR IMAGENES GAUSSIANAS Y LAPLACIANAS DE A2
imwrite(G0_A2, 'piramide_gaussiana_A2_nivel0.jpg');
imwrite(G1_A2, 'piramide_gaussiana_A2_nivel1.jpg');
imwrite(G2_A2, 'piramide_gaussiana_A2_nivel2.jpg');
imwrite(G3_A2, 'piramide_gaussiana_A2_nivel3.jpg');
imwrite(G4_A2, 'piramide_gaussiana_A2_nivel4.jpg');

imwrite(L0_A2, 'piramide_laplaciana_A2_nivel0.jpg');
imwrite(L1_A2, 'piramide_laplaciana_A2_nivel1.jpg');
imwrite(L2_A2, 'piramide_laplaciana_A2_nivel2.jpg');
imwrite(L3_A2, 'piramide_laplaciana_A2_nivel3.jpg');
imwrite(L4_A2, 'piramide_laplaciana_A2_nivel4.jpg');

% GUARDAR IMAGENES GAUSSIANAS Y LAPLACIANAS DE A3
imwrite(G0_A3, 'piramide_gaussiana_A3_nivel0.jpg');
imwrite(G1_A3, 'piramide_gaussiana_A3_nivel1.jpg');
imwrite(G2_A3, 'piramide_gaussiana_A3_nivel2.jpg');
imwrite(G3_A3, 'piramide_gaussiana_A3_nivel3.jpg');
imwrite(G4_A3, 'piramide_gaussiana_A3_nivel4.jpg');

imwrite(L0_A3, 'piramide_laplaciana_A3_nivel0.jpg');
imwrite(L1_A3, 'piramide_laplaciana_A3_nivel1.jpg');
imwrite(L2_A3, 'piramide_laplaciana_A3_nivel2.jpg');
imwrite(L3_A3, 'piramide_laplaciana_A3_nivel3.jpg');
imwrite(L4_A3, 'piramide_laplaciana_A3_nivel4.jpg');


% Guardar la imagen reconstruida para A1
imwrite(uint8(reconstructed_image_A1), 'Reconstruida_A1.jpg');

% Guardar la imagen reconstruida para A2
imwrite(uint8(reconstructed_image_A2), 'Reconstruida_A2.jpg');

% Guardar la imagen reconstruida para A3
imwrite(uint8(reconstructed_image_A3), 'Reconstruida_A3.jpg');




