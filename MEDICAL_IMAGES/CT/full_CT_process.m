clc, clear, close all;

% PARAMETROS CIRCULOS
circles = [0 0 80 3;
           -40 40 15 1.5;
           30 -20 10 2;
           -60 -60 20 1;
           70 30 8 4;
           -20 -80 12 2.5;
           60 -10 18 1.8];

% PARAMETROS IMAGEN SINTETICA NUEVA
nx = 128;
ny = 128;
dx = 2; % Resolución: 2 mm / pixel
x = dx * ([1:nx]' - (nx+1)/2);
y = -dx * ([1:ny]' - (ny+1)/2);
xx = x(:, ones(1, nx));
yy = y(:, ones(1, ny))';

% IMAGEN SINTETICA NUEVA
new_phantom = zeros(nx, ny);
for ii = 1:size(circles, 1)
    cx = circles(ii, 1);
    cy = circles(ii, 2);
    rad = circles(ii, 3);
    amp = circles(ii, 4);
    t = find(((xx - cx) / rad).^2 + ((yy - cy) / rad).^2 <= 1);
    new_phantom(t) = amp * ones(size(t));
end

% SINOGRAMA
nr = 128; % Número de muestras radiales
dr = 2; % Espaciado de los rayos
na = nr * 2; % Número de muestras angulares
r = dr * ([1:nr]' - (nr+1)/2); % Posiciones de las muestras radiales
angle = [0:(na-1)]' / na * pi; % Posiciones de las muestras angulares

rr = r(:, ones(1, na));
sinogram = zeros(nr, na);
for ii = 1:size(circles, 1)
    cx = circles(ii, 1);
    cy = circles(ii, 2);
    rad = circles(ii, 3);
    amp = circles(ii, 4);
    tau = cx * cos(angle) + cy * sin(angle);
    tau = tau(:, ones(1, nr))';
    t = find((rr - tau).^2 <= rad.^2);
    if ii > 1
        amp = amp - circles(1, 4);
    end
    sinogram(t) = sinogram(t) + amp * 2 * sqrt(rad^2 - (rr(t) - tau(t)).^2);
end

% RETROPROYECCION SIMPLE
lamin = zeros(nx, ny);
for ia = 1:na
    projection_ia = sinogram(:, ia);
    projection_smear = repmat(projection_ia, 1, 128);
    rot = imrotate(projection_smear', ia*180/256, 'bicubic', 'crop');
    lamin = lamin + rot;
end

% SINOGRAMA FILTRADO
sinogramfiltered = fftshift(fft(sinogram));
a = length(sinogram);
freqs = linspace(-1, 1, a/2).';
myFilter = abs(freqs);
myFilter = repmat(myFilter, 1, 256);
sinogramfilt = abs(ifft(ifftshift(sinogramfiltered .* myFilter)));

% RETROPROYECCION FILTRADA
bpf_recon = zeros(nx, ny);
for ia = 1:na
    bpf_ia = sinogramfilt(:, ia);
    bpf_smear = repmat(bpf_ia, 1, 128);
    rot1 = imrotate(bpf_smear', ia*180/256, 'bicubic', 'crop');
    bpf_recon = bpf_recon + rot1;
end

% RECONSTRUCCION CON TRANSFORMADA DE RADON
theta = 0:180;
[R, rad_angles] = radon(new_phantom, theta);

% RECONSTRUCCION CON TRANSFORMADA INVERSA DE RADON Y FILTRO RAM-LAK 
RamLak_filtered = iradon(R, theta, 'linear', 'Ram-Lak', 1.0, size(new_phantom, 1));
RamLak_filtered = imrotate(RamLak_filtered, 90);


% Visualizar la nueva imagen sintética
figure(1)

subplot(1,2,1)
imagesc(x, y, new_phantom')
colormap('gray')
axis('square')
title('Nueva Imagen Sintética')
xlabel('Posición x')
ylabel('Posición y')

subplot(1,2,2)
% Visualizar la imagen reconstruida con filtro Ram-Lak
imagesc(RamLak_filtered)
colormap('gray')
axis('square')
title('Reconstruccion con Radon y filtrado Pam-Lak')


figure(2)
subplot(1,2,1)
% Visualizar el sinograma de la nueva imagen sintética
imagesc(r, angle/pi*180, sinogram')
colormap('gray')
title('Sinograma de la Nueva Imagen Sintética')
xlabel('Posición (rayos)')
ylabel('Ángulo (vistas)')

subplot(1,2,2)
% Visualizar el sinograma obtenido
imagesc(rad_angles, theta, R')
colormap('gray')
title('Sinograma generado con la Transformada de Radon')
xlabel('Posicion')
ylabel('Angulo')

figure(3)
subplot(1,2,1)
% Visualizar la imagen reconstruida mediante retroproyección simple
imagesc(x, y, lamin')
colormap('gray')
axis('square')
title('Reconstrucción por Retroproyección Simple')
xlabel('Posición x')
ylabel('Posición y')

subplot(1,2,2)
% Visualizar la imagen reconstruida mediante retroproyeccion filtrada
imagesc(x, y, max(bpf_recon, 0));
colormap('gray')
axis('square')
title('Reconstruccion por Retroproyeccion Filtrada')
xlabel('Posicion x')
ylabel('Posicion y')


figure(4)
subplot(1,2,1)
% Visualizar el sinograma filtrado en Theta = 45 grados
plot(r, sinogram(:, 64) ./ max(sinogram(:, 64)), '-',...
     r, sinogramfilt(:, 64) ./ max(sinogramfilt(:, 64)), ':');
title('Sinograma Filtrado en 45 Grados')
legend('Original', 'Filtrado')
xlabel('Posicion (rayos)')
ylabel('Amplitud')

subplot(1,2,2)
% Visualizar el sinograma completo filtrado
imagesc(r, angle/pi*180, sinogramfilt')
colormap('gray')
axis('image')
title('Sinograma Filtrado')
xlabel('Posicion (rayos)')
ylabel('Angulo (vistas)')






