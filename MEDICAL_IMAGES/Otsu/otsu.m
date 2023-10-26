clc; 
clear; 
close all; 

% Cargar la imagen médica volumétrica en formato NIFTI y pasarla a uint8
% (0-255)
imagen_volumetrica = niftiread('MRBreastCancer.nii.gz');
imagen_volumetrica = uint8(imagen_volumetrica);

%Mostramos imágenes Originales
indices_profundidades = [1, 10, 20, 30];
for i = 1:length(indices_profundidades)
    profundidad = indices_profundidades(i);
    
    % Crear una nueva figura para cada imagen original
    figure;
    imshow(imagen_volumetrica(:,:,profundidad));
    title(['Profundidad ' num2str(profundidad)]);
end



% Obtener las dimensiones de la imagen
[filas, columnas, depth] = size(imagen_volumetrica);

% Inicializar el vector del histograma
HISTOGRAMA = zeros(1, 256, depth);

% Calcular el histograma para cada 'depth' de la imagen
for d = 1:depth
    A = imagen_volumetrica(:,:,d);
    for fila = 1:filas
        for columna = 1:columnas
            intensidad = A(fila, columna) + 1;
            HISTOGRAMA(1, intensidad, d) = HISTOGRAMA(1, intensidad, d) + 1;
        end
    end
end

% Crear un vector para los niveles de intensidad (del 1 al 256)
niveles_intensidad = 1:256;
figure;

% Mostrar el primer histograma
subplot(2,2,1);
bar(niveles_intensidad, HISTOGRAMA(:,:,1));
title('Histograma - Depth 1');
xlabel('Nivel de Intensidad');
ylabel('Frecuencia');

% Mostrar el segundo histograma
subplot(2,2,2);
bar(niveles_intensidad, HISTOGRAMA(:,:,2));
title('Histograma - Depth 2');
xlabel('Nivel de Intensidad');
ylabel('Frecuencia');

% Mostrar el tercer histograma
subplot(2,2,3);
bar(niveles_intensidad, HISTOGRAMA(:,:,3));
title('Histograma - Depth 3');
xlabel('Nivel de Intensidad');
ylabel('Frecuencia');

% Mostrar el cuarto histograma
subplot(2,2,4);
bar(niveles_intensidad, HISTOGRAMA(:,:,4));
title('Histograma - Depth 4');
xlabel('Nivel de Intensidad');
ylabel('Frecuencia');

sgtitle('Hsitogramas para algunas profundidades')
% METODO DE OTSU

% Inicializar matrices para almacenar los resultados
num_umbral = 256;
Wb_matrix = zeros(num_umbral, depth);
Wf_matrix = zeros(num_umbral, depth);
promedio_fondo_matrix = zeros(num_umbral, depth);
promedio_objeto_matrix = zeros(num_umbral, depth);
varianza_fondo_matrix = zeros(num_umbral, depth);
varianza_objeto_matrix = zeros(num_umbral, depth);
varianza_intra_clase_matrix = zeros(num_umbral, depth);

% Calcular promedios y varianzas para cada umbral y profundidad
for d = 1:depth
    histograma_actual = HISTOGRAMA(:,:,d);
    total_pixeles = sum(histograma_actual);

    for umbral = 1:num_umbral
        B = sum(histograma_actual(1:umbral));
        F = total_pixeles - B;

        % Calcular pesos
        Wb = B / total_pixeles;
        Wf = F / total_pixeles;
        Wb_matrix(umbral, d) = Wb;
        Wf_matrix(umbral, d) = Wf;

        % Calcular promedios
        promedio_fondo = sum((1:umbral) .* histograma_actual(1:umbral)) / B;
        promedio_objeto = sum((umbral+1:num_umbral) .* histograma_actual(umbral+1:num_umbral)) / F;
        promedio_fondo_matrix(umbral, d) = promedio_fondo;
        promedio_objeto_matrix(umbral, d) = promedio_objeto;

        % Calcular varianzas
        varianza_fondo = sum(((1:umbral) - promedio_fondo).^2 .* histograma_actual(1:umbral)) / B;
        varianza_objeto = sum(((umbral+1:num_umbral) - promedio_objeto).^2 .* histograma_actual(umbral+1:num_umbral)) / F;
        varianza_fondo_matrix(umbral, d) = varianza_fondo;
        varianza_objeto_matrix(umbral, d) = varianza_objeto;

        % Calcular varianza intra-clase
        varianza_intra_clase = Wb * varianza_fondo + Wf * varianza_objeto;
        varianza_intra_clase_matrix(umbral, d) = varianza_intra_clase;
    end
end

% Encontrar el umbral óptimo que minimiza la varianza intra-clase y generar la imagen binaria
umbral_optimo_matrix = zeros(1, depth);
imagen_binaria = zeros(filas, columnas, depth);

for d = 1:depth
    [~, umbral_optimo] = min(varianza_intra_clase_matrix(:, d));
    umbral_optimo_matrix(d) = umbral_optimo;
    
    % Generar la versión binaria de la imagen
    imagen_binaria(:,:,d) = imagen_volumetrica(:,:,d) > umbral_optimo - 1;
end


% Crear una figura con subplots para mostrar las imágenes binarizadas
figure;
for i = 1:length(indices_profundidades)
    profundidad = indices_profundidades(i);
    umbral_optimo = umbral_optimo_matrix(profundidad);
    subplot(2, 2, i);
    imshow(imagen_binaria(:,:,profundidad), []);
    title(['Profundidad ' num2str(profundidad) ', Umbral: ' num2str(umbral_optimo)]);
end

sgtitle('Imágenes Binarizadas en Profundidades 1, 10, 20 y 30');


% Mostrar imágenes binarizadas en figuras separadas
for i = 1:length(indices_profundidades)
    profundidad = indices_profundidades(i);
    umbral_optimo = umbral_optimo_matrix(profundidad);
    
    % Crear una nueva figura para cada imagen binarizada
    figure;
    imshow(imagen_binaria(:,:,profundidad), []);
    title(['Profundidad ' num2str(profundidad) ', Umbral: ' num2str(umbral_optimo)]);
end
