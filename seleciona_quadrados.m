function [x_pixel,y_pixel,z_pixel] = seleciona_quadrados(image,M,N,escala,x_inicial,y_inicial,x_final,y_final)
  % Recebe tamanho da imagem e a escala (distancia por pixel).
  % Tbm recebe as coordenadas iniciais e finais da reta entre os pontos.
  % O pixel image(1,1) eh a origem do sistema cartesiano.
  % Retorna as posicoes dos pixels que a reta toca.
  
  x_pixel = [];
  y_pixel = [];
  z_pixel = [];
  number_points_reta = ceil(sqrt(M^2+N^2))*10;
  
  t=0:1/number_points_reta:1;
  x = x_inicial+t*(x_final-x_inicial);
  y = y_inicial+t*(y_final-y_inicial);
  for i=1:length(t)
    x_p = ceil(x(i)/escala);
    y_p = ceil(y(i)/escala);
    if isempty(intersect(find(x_pixel == x_p),find(y_pixel == y_p)));
      x_pixel = [x_pixel x_p];
      y_pixel = [y_pixel y_p];
      z_pixel = [z_pixel image(x_p,y_p)];
    end
  end
end