% transformar en Fourier el sinograma,
% luego trasladar para centrar las bajas frecuencias
sinogramfiltered=fftshift(fft(sinogram));
% filtrar el sinograma usando un filtro Ram-Lak
a = length(sinogram);
% pendiente -1 hasta 128, luego +1 hasta 256
freqs=linspace(-1, 1, a/2).';
myFilter = abs(freqs);
% asegurarse que el sinograma y el filtro son de las mismas dimensiones
myFilter = repmat(myFilter,1,256);
% multiplicar en frecuencia, luego trasladar, luego transformada inversa
sinogramfilt=abs(ifft(ifftshift(sinogramfiltered.*myFilter)));
% visualizar el sinograma filtrado en Theta = 45 grados
figure(4)   
 % 45 grados es la proyeccion #64 (256*45/180)
 plot(r, sinogram(:,64)./max(sinogram(:,64)), '-',...
 r, sinogramfilt(:,64)./max(sinogramfilt(:,64)),':');
 title('Sinograma filtrado en 45 grados');
 legend('original', 'filtrado');
 xlabel('Posicion (rayos)');
 ylabel('Amplitud');
% visualizar el sinograma completo filtrado
figure(5)
 imagesc(r, angle/pi*180, sinogramfilt');
 colormap('gray');
 axis('image');
 title('Sinograma filtrado')
 xlabel('Posicion (rayos)')
 ylabel('Angulo (vistas)') 