% angulos para la proyeccion
theta=0:180;
% obtener el sinograma aplicando la transformada de Radon
[R,rad_angles]=radon(phantom,theta);
% visualizar el sinograma obtenido
figure(7)
 imagesc(rad_angles,theta,R');
 colormap('gray');
 title('Sinograma generado con la transformada de Radon')
 xlabel('Posicion')
 ylabel('Angulo')

 
% reconstruir la imagen con la transformada inversa, aplicando un filtro
RamLak_filtered=iradon(R, theta, 'linear','Ram-Lak', 1.0, size(phantom,1));
RamLak_filtered=imrotate(RamLak_filtered,90);
% visualizar la imagen reconstruida
figure(8)
 imagesc(RamLak_filtered);
 colormap('gray');
 title('Reconstruccion con la trans. inversa de Radon y el filtro Ram-Lak')
 xlabel('Posicion x')
 ylabel('Posicion y')