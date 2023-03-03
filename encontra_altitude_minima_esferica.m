function [h,d] = encontra_altitude_minima_esferica(x,y,z,as,bs,escala,R)
  h = zeros(1,length(x));
  d = zeros(1,length(x));
  h(1) = z(1);
  for i=1:length(as)
    d(i+1) = sqrt((x(i+1)-x(1))^2+(y(i+1)-y(1))^2);
    h(i+1) = bs(i)/(cos(d(i+1)*escala/R) - as(i)*sin(d(i+1)*escala/R)) - R;
  end
end