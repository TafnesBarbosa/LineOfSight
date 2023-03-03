function [angulos] = retorna_inclinacao_plana(image,x_pixel,y_pixel)
  angulos = [];
  for i=1:length(x_pixel)-1
    d=sqrt((y_pixel(i+1)-y_pixel(1))^2+(x_pixel(i+1)-x_pixel(1))^2);
    ang = atan((image(x_pixel(i+1),y_pixel(i+1))-image(x_pixel(1),y_pixel(1)))/d);
    if i == 1
      angulos = [angulos ang];
    elseif ang >= angulos(end)
      angulos = [angulos ang];
    else
      angulos = [angulos angulos(end)];
    end
  end
end