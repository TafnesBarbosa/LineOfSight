function [x,y] = posicao_dist2pixnext(x0,y0,azimuth)
  % Transforma a posicao do pixel em dist para posicao na matrix
  if (azimuth >= 0 && azimuth < pi / 2)
    x = floor(x0+1);
    y = floor(y0+1);
  elseif (azimuth >= pi / 2 && azimuth < pi)
    x = ceil(x0);
    y = floor(y0+1);
  elseif (azimuth >= pi && azimuth < 3 * pi / 2)
    x = ceil(x0);
    y = ceil(y0);
  else
    x = floor(x0+1);
    y = ceil(y0);
  end
end