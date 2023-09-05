

% Cargar la imagen y definir la geometría
A=imread("eco_gray.png");

A=A(:,1:276)';



%Obtener las dimensiones de la imagen 
[nx ,ny] = size(A)


dx = 2; % resolucion: 2 mm / pixel
x = dx * ([1:nx]'-(nx+1)/2);
y = -dx * ([1:ny]'-(ny+1)/2);

figure(1)
 imagesc(x, y, A') % Se usa la transpuesta (') y los valores x y y
 colormap('gray')
 axis('square')
 title('Imagen sintetica')
 xlabel('Posicion x')
 ylabel('Posicion y')


na=395;

nr=128;
r = dr * ([1:nr]'-(nr+1)/2); % posiciones de las muestras radiales


% obtener el sinograma aplicando la transformada de Radon
theta=0:180; 
[R,rad_angles]=radon(A,theta); 

R=R';

figure(2)
 imagesc(rad_angles,theta,R);
 colormap('gray');
 title('Sinograma generado con la transformada de Radon')
 xlabel('Posicion')
 ylabel('Angulo')


% RETROPROYECCION SIMPLE
lamin = zeros(181, 181);
for ia = 1:na
    projection_ia = R(:, ia);
    projection_smear = repmat(projection_ia, 1, 181);
    rot = imrotate(projection_smear', ia*180/256, 'bicubic', 'crop');
    lamin = lamin + rot;
end

figure(3)
 imagesc(x, y, lamin);
 colormap('gray');
 axis('image')
 title('Reconstruccion por retroproyeccion simple')
 xlabel('mm') %x y y en imagesc nos da limites escalares en mm
 ylabel('mm')


% SINOGRAMA FILTRADO
sinogramfiltered = fftshift(fft(R));
a = length(R);
freqs = linspace(-1, 1,181).';
myFilter = abs(freqs);
myFilter = repmat(myFilter, 1, 395);
sinogramfilt = abs(ifft(ifftshift(sinogramfiltered .* myFilter)));

figure(4)
 imagesc(r, angle/pi*180, sinogramfilt);
 colormap('gray');
 axis('image');
 title('Sinograma filtrado')
 xlabel('Posicion (rayos)')
 ylabel('Angulo (vistas)') 

% RETROPROYECCION FILTRADA
bpf_recon = zeros(181, 181);
for ia = 1:na
    bpf_ia = sinogramfilt(:, ia);
    bpf_smear = repmat(bpf_ia, 1, 181);
    rot1 = imrotate(bpf_smear', ia*180/256, 'bicubic', 'crop');
    bpf_recon = bpf_recon + rot1;
end

figure(5)
 imagesc(x, y, max(bpf_recon,0));
 colormap('gray');
 axis('image')
 title('Reconstruccion por retroproyeccion filtrada')
 xlabel('Posicion x')
 ylabel('Posicion y')



