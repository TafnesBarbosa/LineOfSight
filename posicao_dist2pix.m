function [x,y] = posicao_dist2pix(x0,y0,escala)
  % Transforma a posicao do pixel em dist para posicao na matrix
  x = ceil(x0/escala);
  y = ceil(y0/escala);
end