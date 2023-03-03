function [x_pixel,y_pixel,z_pixel] = seleciona_quadrados_inside(image,x_inicial,y_inicial,x_final,y_final)
% Recebe tamanho da imagem e a escala (distancia por pixel).
% Tbm recebe as coordenadas iniciais e finais da reta entre os pontos.
% O pixel image(1,1) eh a origem do sistema cartesiano.
% Retorna as posicoes dos pixels que a reta toca.

x_pixel = [];
y_pixel = [];
z_pixel = [];
if abs(ceil(y_final) - ceil(y_inicial)) <= 1 && abs(ceil(x_final) - ceil(x_inicial)) <= 1
    if ceil(y_final) == ceil(y_inicial) && ceil(x_final) == ceil(x_inicial)
        return;
    elseif ceil(y_final) == ceil(y_inicial) || ceil(x_final) == ceil(x_inicial)
        x_pixel = [x_pixel ceil(x_inicial)];
        y_pixel = [y_pixel ceil(y_inicial)];
        z_pixel = [z_pixel image(ceil(x_inicial),ceil(y_inicial))];
    elseif (x_inicial-ceil(x_inicial))*(y_final-ceil(y_inicial)) == (y_inicial-ceil(y_inicial))*(x_final-ceil(x_inicial))
        x_pixel = [x_pixel ceil(x_inicial)];
        y_pixel = [y_pixel ceil(y_inicial)];
        z_pixel = [z_pixel image(ceil(x_inicial),ceil(y_inicial))];
    else
        [x1,y1,z1] = seleciona_quadrados_inside(image,x_inicial,y_inicial,(x_inicial+x_final)/2,(y_inicial+y_final)/2);
        [x2,y2,z2] = seleciona_quadrados_inside(image,(x_inicial+x_final)/2,(y_inicial+y_final)/2,x_final,y_final);
        x_pixel = [x_pixel x1 x2];
        y_pixel = [y_pixel y1 y2];
        z_pixel = [z_pixel z1 z2];
    end
else
    [x1,y1,z1] = seleciona_quadrados_inside(image,x_inicial,y_inicial,(x_inicial+x_final)/2,(y_inicial+y_final)/2);
    [x2,y2,z2] = seleciona_quadrados_inside(image,(x_inicial+x_final)/2,(y_inicial+y_final)/2,x_final,y_final);
    x_pixel = [x_pixel x1 x2];
    y_pixel = [y_pixel y1 y2];
    z_pixel = [z_pixel z1 z2];
end
end