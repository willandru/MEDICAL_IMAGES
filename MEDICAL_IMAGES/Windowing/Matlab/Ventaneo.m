clear, clc, close all; 
A = imread('eco_gray.png');


disp(['El valor máximo de esta imagen es: ', num2str(max(A(:)))]);
disp(['El valor minimo de esta imagen es: ', num2str(min(A(:)))]);

m_anchoBanda=1.7;
b_nivelVentana=-20;

I= m_anchoBanda.*A + b_nivelVentana;

figure(1)
subplot(1,2,1)
imshow(A)
title('Imagen Original')
subplot(1,2,2)
imshow(I)
title(['Filtro Lineal con  Ancho= ', num2str(m_anchoBanda), ' y Nivel= ', num2str(b_nivelVentana)]);

sgtitle('Ventaneo Clásico');
% se asinga un nvivel y un ancho de ventana, pa alo cual todos los valores
% por fura de esta ventana seran asignados a blanoc o negro segun
% corresponda

%% SEGUNDO PUNTO


FlagVentanas = false;
FlagV1 = false;
FlagV2 = false;
FlagV3 = false;

while ~FlagVentanas
    nivel1 = input('Inserte el Nivel de la ventana 1: ');
    
    if nivel1 < 255 && nivel1 > 0
        while ~FlagV1
            ancho1 = input('Inserte el ancho de Ventana 1: ');
            
            if nivel1 - ancho1 / 2 < 0 || nivel1 + ancho1 / 2 > 255
                disp('Error: La Ventana debe estar entre 0 y 255');
                continue;
            else
                while ~FlagV2
                    nivel2 = input('Inserte el Nivel de la ventana 2: ');
                    
                    if (nivel2 <= nivel1 + ancho1 / 2 && nivel2 >= nivel1 - ancho1 / 2) || nivel2 < 0 || nivel2 > 255
                        disp('Error: El nivel debe estar entre 0 y 255 y no puede estar dentro de la VENTANA 1');
                        continue;
                    else
                        ancho2 = input('Inserte el Ancho de la ventana 2: ');
                        
                        if nivel2 + ancho2 / 2 > 255 || nivel2 - ancho2 / 2 < 0
                            disp('Error: El Ancho de la VENTANA 2 debe estar entre 0 y 255');
                            continue;
                        elseif nivel2 + ancho2 / 2 >= nivel1 - ancho1 / 2 && nivel2 - ancho2 / 2 <= nivel1 + ancho1 / 2
                            disp('Error: La VENTANA 2 se cruza con la ventana 1');
                            continue;
                        else
                            while ~FlagV3
                                nivel3 = input('Inserte el Nivel 3: ');
                                
                                if nivel3 < 0 || nivel3 > 255
                                    disp('Error: El nivel de la ventana debe estar entre 0 y 255');
                                    continue;
                                elseif (nivel3 >= nivel1 - ancho1 / 2 && nivel3 <= nivel1 + ancho1 / 2) || ...
                                    (nivel3 >= nivel2 - ancho2 / 2 && nivel3 <= nivel2 + ancho2 / 2)
                                    disp('Error: El nivel de la ventana no debe estar en las VENTANAS 1 o 2');
                                    continue;
                                else
                                    ancho3 = input('Inserte el Ancho de la ventana 3: ');
                                    
                                    if nivel3 - ancho3 / 2 < 0 || nivel3 + ancho3 / 2 > 255
                                        disp('Error: El Ancho de la VENTANA 3 debe estar entre 0 y 255');
                                        continue;
                                    elseif (nivel3 + ancho3 / 2 >= nivel1 - ancho1 / 2 && nivel3 - ancho3 / 2 <= nivel1 + ancho1 / 2) || ...
                                        (nivel3 + ancho3 / 2 >= nivel2 - ancho2 / 2 && nivel3 - ancho3 / 2 <= nivel2 + ancho2 / 2)
                                        disp('Error: La VENTANA 3 se cruza con las ventanas 1 o 2');
                                        continue;
                                    else
                                        FlagV3 = true;
                                    end
                                end
                            end
                            FlagV2 = true;
                        end
                    end
                end
                FlagV1 = true;
            end
        end
        FlagVentanas = true;
    else
        disp('Error: El nivel de la ventana debe estar entre 0 y 255');
        continue;
    end
end

%%

 % m= ancho , b=nivel

limite0=nivel1- ancho1/2;
limite1=nivel1+ ancho1/2;
limite2=nivel2- ancho1/2;
limite3=nivel2+ ancho1/2;
limite4=nivel3- ancho1/2;
limite5=nivel3+ ancho1/2;


I1= double((A >= limite0) & (A<= limite1));
I2= double((A >= limite2) & (A<= limite3));
I3= double((A >= limite4) & (A<= limite5));

A=double(A);

I_1 = A.*I1;
I_2 = A.*I2;
I_3 = A.*I3;


ancho1=255/ancho1;
ancho2=255/ancho2;
ancho3=255/ancho3;

I_1= ancho1.*I_1 + nivel1;
I_2= ancho2.*I_2 + nivel2;
I_3= ancho3.*I_3 + nivel3;

I_1= I_1.*I1;
I_2= I_2.*I2;
I_3= I_3.*I3;

I_S=I_1 + I_2 + I_3;

A=uint8(A);
I_S=uint8(I_S);
I_1=uint8(I_1);
I_2=uint8(I_2);
I_3=uint8(I_3);

figure(2)


subplot(2,3,1)
imshow(I_1)
title('Ventana 1')

subplot(2,3,2)
imshow(I_2)
title('Ventana 2');

subplot(2,3,3)
imshow(I_3)
title('Ventana 3')

subplot(2,3,5)
imshow(I_S)
title('Ventaneo por Secciones')


sgtitle('Ventaneo por Secciones');
%% TERCER PUNTO
