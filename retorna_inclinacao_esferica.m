function [as, bs] = retorna_inclinacao_esferica(image,x_pixel,y_pixel,R,escala)
  as = [];
  bs = [];
  for i=1:length(x_pixel)-1
    d=sqrt((y_pixel(i+1)-y_pixel(1))^2+(x_pixel(i+1)-x_pixel(1))^2)*escala;
    theta0 = d / R;
    a = ((image(x_pixel(i+1),y_pixel(i+1)) + R) * cos(theta0) - (image(x_pixel(1),y_pixel(1)) + R)) / ((image(x_pixel(i+1),y_pixel(i+1)) + R) * sin(theta0));
    b = image(x_pixel(1),y_pixel(1)) + R;
    if i == 1
      as = [as a];
      bs = [bs b];
    elseif a >= as(end)
      as = [as a];
      bs = [bs b];
    else
      as = [as as(end)];
      bs = [bs bs(end)];
    end
  end
end