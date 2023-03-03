function [alpha1, alpha2, alpha3] = return_alpha123(xy_next)
    try
        alpha1 = atan(1 / (floor(xy_next + 1) - xy_next));
    catch
        alpha1 = atan(Inf);
    end
    try
        alpha3 = atan(1 / (xy_next - floor(xy_next)));
    catch
        alpha3 = atan(Inf);
    end
    alpha2 = pi - alpha1 - alpha3;
end