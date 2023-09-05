% obtener el sinograma aplicando la transformada de Radon
theta=0:180; 
[R,rad_angles]=radon(phantom,theta); 

% reconstruir la imagen con la transformada inversa, aplicando un filtro
SheppLogan_filtered=iradon(R, theta, 'linear','Shepp-Logan', 1.0, size(phantom,1));
SheppLogan_filtered=imrotate(SheppLogan_filtered,90);
Hamming_filtered=iradon(R, theta, 'linear','Hamming', 1.0, size(phantom,1));
Hamming_filtered=imrotate(Hamming_filtered,90);
Hann_filtered=iradon(R, theta, 'linear','Hann', 1.0, size(phantom,1));
Hann_filtered=imrotate(Hann_filtered,90);

% visualizar las imagenes reconstruidas
figure()

subplot(1,3,1)
 imagesc(SheppLogan_filtered);
 colormap('gray'); 
 title('Filtro Shepp-Logan')
 xlabel('Posicion x')
 ylabel('Posicion y')

 subplot(1,3,2)
 imagesc(Hamming_filtered);
 colormap('gray'); 
 title('Filtro Hamming')
 xlabel('Posicion x')
 ylabel('Posicion y')

 subplot(1,3,3)
 imagesc(Hann_filtered);
 colormap('gray'); 
 title('Filtro Hann')
 xlabel('Posicion x')
 ylabel('Posicion y')
