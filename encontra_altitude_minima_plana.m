function [h,d] = encontra_altitude_minima_plana(x,y,z,angulos)
  h = zeros(1,length(x));
  d = zeros(1,length(x));
  h(1) = z(1);
  for i=1:length(angulos)
    d(i+1) = sqrt((x(i+1)-x(1))^2+(y(i+1)-y(1))^2);
    h(i+1) = d(i+1)*tan(angulos(i))+z(1);
  end
end