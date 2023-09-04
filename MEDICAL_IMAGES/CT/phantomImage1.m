% definicion de los parametros para cada circulo dentro de la imagen
% parametros: centro en x, centro en y, radio, coef. atenuacion (intensidad)
circ = [ 0 0 110 2;
 -65 0 20 1;
 0 0 35 0;
 65 -25 25 4;
 50 50 7 8];
% parametros de la imagen: numero de pixeles, tamano, etc.
nx = 128;
ny = 128;
dx = 2; % resolucion: 2 mm / pixel
x = dx * ([1:nx]'-(nx+1)/2);
y = -dx * ([1:ny]'-(ny+1)/2);
xx = x(:,ones(1,nx));
yy = y(:,ones(1,ny))';
% generar los datos para la imagen sintetica
phantom = zeros(nx,ny);
for ii=1:size(circ,1)
 cx = circ(ii,1);
 cy = circ(ii,2);
 rad = circ(ii,3);
 amp = circ(ii,4);
 t = find( ((xx-cx)/rad).^2 + ((yy-cy)/rad).^2 <= 1 );
 phantom(t) = amp * ones(size(t));
end
% visualizar la imagen sintetica
figure(1)
 imagesc(x, y, phantom') % Se usa la transpuesta (') y los valores x y y
 colormap('gray')
 axis('square')
 title('Imagen sintetica')
 xlabel('Posicion x')
 ylabel('Posicion y')