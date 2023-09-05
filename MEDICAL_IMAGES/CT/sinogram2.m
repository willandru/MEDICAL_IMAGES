

circ = [ 0 0 110 2;
 -65 0 20 1;
 0 0 35 0;
 65 -25 25 4;
 50 50 7 8];

% parametros de la geometria
nr = 128; % numero de muestras radiales
dr = 2; % espaciado de los rayos
na = nr*2; % numero de muestras angulares
r = dr * ([1:nr]'-(nr+1)/2); % posiciones de las muestras radiales
angle = [0:(na-1)]'/na * pi; % posiciones de las muestras angulares
% calcular el sinograma para la imagen sintetica
rr = r(:,ones(1,na));
sg1 = zeros(nr, na);
for ii=1:size(circ,1)
 cx = circ(ii,1);
 cy = circ(ii,2);
 rad = circ(ii,3);
 amp = circ(ii,4);
 tau = cx * cos(angle) + cy * sin(angle);
 tau = tau(:,ones(1,nr))';
 t = find( (rr-tau).^2 <= rad.^2 );
 if ii > 1, amp = amp - circ(1,4); end % discos pequenos embebidos
 sg1(t) = sg1(t)+amp*2*sqrt(rad^2-(rr(t)-tau(t)).^2);
end
% visualizar el sinograma
figure(2)
 imagesc(r, angle/pi*180, sg1') % se usa la transpuesta (') y el angulo
 colormap('gray') % se muestra en grados
 title('Sinograma: imagen sintetica')
 xlabel('Posicion (rayos)')
 ylabel('Angulo (vistas)')
% definir una variable general para el sinograma, para posterior ejecucion
sinogram = sg1; % sinograma de la imagen sintetica
% visualizar informacion del sinograma
disp(sprintf('numero de rayos = %g', nr))
disp(sprintf('numero de vistas = %g', na))