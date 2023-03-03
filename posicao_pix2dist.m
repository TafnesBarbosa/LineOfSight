function [x0,y0] = posicao_pix2dist(x,y,escala)
  % Transforma a posicao do pixel na matriz para posicao em distancia
  x0 = (x-0.5)*escala;
  y0 = (y-0.5)*escala;
end