function [x_p,y_p] =  procura_altura(h,x,y,altura)
  for i=1:length(h)
    if max(h{i}) > altura
      [~,b] = min(abs(h{i}-altura));
      x_p(i) = x{i}(b);
      y_p(i) = y{i}(b);
    else 
      x_p(i) = NaN;
      y_p(i) = NaN;
    end
  end
end