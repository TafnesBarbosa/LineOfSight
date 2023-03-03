function [x_final,y_final] = seleciona_maximas_coordenadas(M,N,azimute,x_p_inicial,y_p_inicial,escala)
  azimute_1 = atan((N-y_p_inicial)/(M-x_p_inicial));
  azimute_2 = atan((N-y_p_inicial)/(x_p_inicial-1));
  azimute_3 = atan((y_p_inicial-1)/(x_p_inicial-1));
  azimute_4 = atan((y_p_inicial-1)/(M-x_p_inicial));
  if azimute >= azimute_1 && azimute < pi-azimute_2
    y_p_final = N;
    x_p_final = round((N-y_p_inicial)*tan(pi/2-azimute))+x_p_inicial;
  elseif azimute < -azimute_4 && azimute >= -pi+azimute_3
    y_p_final = 1;
    x_p_final = round((y_p_inicial-1)*tan(pi/2+azimute))+x_p_inicial;
  elseif azimute >= -azimute_4 && azimute < azimute_1
    x_p_final = M;
    y_p_final = round((M-x_p_inicial)*tan(azimute))+y_p_inicial;
  else
    x_p_final = 1;
    if azimute > 0
      y_p_final = round((x_p_inicial-1)*tan(pi-azimute))+y_p_inicial;
    elseif azimute < 0
      y_p_final = -round((x_p_inicial-1)*tan(pi+azimute))+y_p_inicial;
    end
  end
  [x_final,y_final] = posicao_pix2dist(x_p_final,y_p_final,escala);
end