function [x,y] = posicao_dist2pix(x0,y0,escala)
  % Transforma a posicao do pixel em dist para posicao na matrix
  x = x0/escala+0.5;
  y = y0/escala+0.5;
end