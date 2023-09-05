% retroproyeccion simple (laminograma)


nx = 128;
ny = 128;

dx = 2; % resolucion: 2 mm / pixel
x = dx * ([1:nx]'-(nx+1)/2);
y = -dx * ([1:ny]'-(ny+1)/2);



lamin = zeros(nx,ny);
for ia = 1:na
 % extraer angulo actual del sinograma
 projection_ia=sinogram(:,ia);
 % difuminar angulo actual en 128*128
 projection_smear=repmat (projection_ia,1,128);
 % 256 proyecciones corresponden a 180 grados
 % entonces se usa ia*180/256 para el angulo de proyeccion actual
 rot= imrotate(projection_smear', ia*180/256, 'bicubic','crop');
 % lamin necesita ser de 128*128
 % por eso el primer argumento en imrotate debe ser de la misma dimension
 lamin=lamin+rot;
end
% visualizar la imagen reconstruida
figure(3)
 imagesc(x, y, lamin);
 colormap('gray');
 axis('image')
 title('Reconstruccion por retroproyeccion simple')
 xlabel('mm') %x y y en imagesc nos da limites escalares en mm
 ylabel('mm')