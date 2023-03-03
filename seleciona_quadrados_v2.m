function [x_pixel,y_pixel,z_pixel] = seleciona_quadrados_v2(image,x_inicial,y_inicial,x_final,y_final)
% Recebe tamanho da imagem e a escala (distancia por pixel).
% Tbm recebe as coordenadas iniciais e finais da reta entre os pontos.
% O pixel image(1,1) eh a origem do sistema cartesiano.
% Retorna as posicoes dos pixels que a reta toca.

[x_pixel,y_pixel,z_pixel] = seleciona_quadrados_inside(image,x_inicial,y_inicial,x_final,y_final);
x_pixel = [x_pixel ceil(x_final)];
y_pixel = [y_pixel ceil(y_final)];
z_pixel = [z_pixel image(ceil(x_final),ceil(y_final))];
end