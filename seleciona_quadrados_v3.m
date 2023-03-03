function [x_pixel,y_pixel,z_pixel] = seleciona_quadrados_v3(image,x_inicial,y_inicial,x_final,y_final)
  # Receives size of image.
  # Azimuth grows at counter clockwise. && is in radians.
  # Returns the positions of pixels that the line touches
  [M,N] = size(image);
  
  [x_p_initial,y_p_initial] = posicao_dist2pix(x_inicial,y_inicial,1);
  azimuth = atan((y_final-y_inicial)/(x_final-x_inicial));
  
  x_pixel = [x_p_initial];
  y_pixel = [y_p_initial];
  z_pixel = [image(x_p_initial,y_p_initial)];
  x_initial, y_initial = position_pix2dist(x_p_initial, y_p_initial, 1);
  if (azimuth >= 0 && azimuth < pi / 4) || (azimuth >= 7 * pi / 4 && azimuth < 2 * pi)
    x_next = x_initial + 0.5;
    y_next = y_initial + tan(azimuth) * 0.5;
    came_from = 'l';
  elseif (azimuth >= pi / 4 && azimuth < 3 * pi / 4)
    y_next = y_initial + 0.5;
    x_next = x_initial + 0.5 / tan(azimuth);
    came_from = 'd';
  elseif (azimuth >= 5 * pi / 4 && azimuth < 7 * pi / 4)
    y_next = y_initial - 0.5;
    x_next = x_initial - 0.5 / tan(azimuth);
    came_from = 'u';
  else
    x_next = x_initial - 0.5;
    y_next = y_initial - tan(azimuth) * 0.5;
    came_from = 'r';
  end
  while x_next <= M && x_next > 1 && y_next <= N && y_next > 1:
    x_p_next, y_p_next = position_dist2pix(x_next, y_next, 1);
    if came_from == 'r'
      x_p_next = x_p_next - 1;
    elseif came_from == 'u'
      y_p_next = y_p_next - 1;
    end
    x_pixel = [x_pixel x_p_next];
    y_pixel = [y_pixel y_p_next];
    z_pixel = [z_pixel image[x_p_next, y_p_next]];
    if x_next == floor(x_next) && y_next == floor(y_next)
      if came_from == 'l' || came_from == 'd'
        if azimuth < pi / 4
          x_next = x_next + 1;
          y_next = y_next + tan(azimuth);
          came_from = 'l';
        elseif azimuth >= pi / 4 && azimuth < pi / 2
          y_next = y_next + 1;
          x_next = x_next + 1 / tan(azimuth);
          came_from = 'd';
        end
      end
      if came_from == 'd' || came_from == 'r'
        if azimuth >= pi / 2 && azimuth < 3 * pi / 4
          y_next = y_next + 1;
          x_next = x_next + 1 / tan(azimuth);
          came_from = 'd';
        elseif azimuth >= 3 * pi / 4 && azimuth < pi
          x_next = x_next - 1;
          y_next = y_next + tan(azimuth);
          came_from = 'r';
        end
      end
      if came_from == 'u' || came_from == 'r'
        if azimuth >= pi && azimuth < 5 * pi / 4
          x_next = x_next - 1;
          y_next = y_next - tan(azimuth);
          came_from = 'r';
        elseif azimuth >= 5 * pi / 4 && 3 * pi / 2
          y_next = y_next - 1;
          x_next = x_next - 1 / tan(azimuth);
          came_from = 'u';
        end
      end
      if came_from == 'u' || came_from == 'l'
        if azimuth >= 3 * pi / 2 && azimuth < 7 * pi / 4
          y_next = y_next - 1;
          x_next = x_next - 1 / tan(azimuth);
          came_from = 'u';
        elseif azimuth >= 7 * pi / 4 && azimuth < 2 * pi
          x_next = x_next + 1;
          y_next = y_next - tan(azimuth);
          came_from = 'l';
        end
      end
    elseif came_from == 'd'
      [alpha1, alpha2, alpha3] = return_alpha123(x_next);
      if azimuth < alpha1
        came_from = 'l';
        y_next = y_next + tan(azimuth) * (floor(x_next + 1) - x_next);
        x_next = floor(x_next + 1);
      elseif azimuth < alpha2 + alpha1
        came_from = 'd';
        y_next = y_next + 1;
        x_next = x_next + 1 / tan(azimuth);
      else
        came_from = 'r';
        y_next = y_next - tan(azimuth) * (x_next - floor(x_next));
        x_next = floor(x_next);
      end
    elseif came_from == 'r'
      [alpha1, alpha2, alpha3] = return_alpha123(y_next);
      if azimuth < alpha1 + pi / 2
        came_from = 'd';
        x_next = x_next - tan(azimuth - pi / 2) * (floor(y_next + 1) - y_next);
        y_next = floor(y_next + 1);
      elseif azimuth < alpha1 + alpha2 + pi / 2
        came_from = 'r';
        x_next = x_next - 1;
        y_next = y_next - tan(azimuth);
      else
        came_from = 'u';
        x_next = x_next - (y_next - floor(y_next)) / tan(azimuth);
        y_next = floor(y_next);
      end
    elseif came_from == 'u'
      [alpha3, alpha2, alpha1] = return_alpha123(x_next);
      if azimuth < pi + alpha1
        came_from = 'r';
        y_next = y_next - (x_next - floor(x_next)) * tan(azimuth);
        x_next = floor(x_next);
      elseif azimuth < pi + alpha1 + alpha2
        came_from = 'u';
        x_next = x_next - 1 / tan(azimuth);
        y_next = y_next - 1;
      else
        came_from = 'l';
        y_next = y_next + (floor(x_next + 1) - x_next) * tan(azimuth);
        x_next = floor(x_next + 1);
      end
    else
      [alpha3, alpha2, alpha1] = return_alpha123(y_next);
      if azimuth < 3 * pi / 2 + alpha1 && azimuth >= 3 * pi / 2
        came_from = 'u';
        x_next = x_next - (y_next - floor(y_next)) / tan(azimuth);
        y_next = floor(y_next);
      elseif azimuth < pi / 2 && azimuth >= pi / 2 - alpha3
        came_from = 'd';
        x_next = x_next + (floor(y_next + 1) - y_next) / tan(azimuth);
        y_next = floor(y_next + 1);
      else
        came_from = 'l';
        x_next = x_next + 1;
        y_next = y_next + tan(azimuth);
      end
    end
  end
end