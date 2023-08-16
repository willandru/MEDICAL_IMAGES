A = imread('eco_gray.png');
B=imread('descarga.jpg');

disp(['El valor máximo de esta imagen es: ', num2str(max(A(:)))]);
disp(['El valor minimo de esta imagen es: ', num2str(min(A(:)))]);

m_anchoBanda=1;
b_nivelVentana=100;

I= m_anchoBanda.*A + b_nivelVentana;

figure(1)
subplot(1,2,1)
imshow(A)
subplot(1,2,2)
imshow(I)

sgtitle('Ventaneo Clásico');

%% SEGUNDO PUNTO

p=input('Inserte un rango')



%% 




