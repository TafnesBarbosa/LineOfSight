function plota_regiao_3D(image,x,y,h,x_p_inicial,y_p_inicial,N_undersample)
z_mat = NaN*zeros(size(image));
for i=1:length(h)
    for j=1:length(x{i})
        z_mat(x{i}(j),y{i}(j)) = h{i}(j);
    end
end

[M,N] = size(image);
image_undersampled = zeros(floor(M/N_undersample),floor(N/N_undersample));
for i=1:floor(M/N_undersample)
    for j=1:floor(N/N_undersample)
        image_undersampled(i,j) = mean(mean(image(N_undersample*(i-1)+1:N_undersample*i,N_undersample*(j-1)+1:N_undersample*j)));
    end
end

z_mat_undersampled = zeros(floor(M/N_undersample),floor(N/N_undersample));
for i=1:floor(M/N_undersample)
    for j=1:floor(N/N_undersample)
        z_mat_undersampled(i,j) = nanmean(nanmean(z_mat(N_undersample*(i-1)+1:N_undersample*i,N_undersample*(j-1)+1:N_undersample*j)));
    end
end
clear image h z_mat x y
[M0,N0] = size(z_mat_undersampled);
y_plot = 0:0.03*N_undersample:0.03*N_undersample*(N0-1);
x_plot = 0.03*N_undersample*(M0-1):-0.03*N_undersample:0;
figure;
surf(y_plot,x_plot,image_undersampled,'EdgeAlpha',0.15);
hold on
surf(y_plot,x_plot,z_mat_undersampled,'EdgeAlpha',0.25,'FaceAlpha',0.5,'EdgeColor',[1 0 0]);
plot3((y_p_inicial-1)*0.03,(M-x_p_inicial+1)*0.03,image_undersampled(floor(x_p_inicial/N_undersample),floor(y_p_inicial/N_undersample)),'*y','MarkerSize',8.5);
p = gca;
p.XLim(2) = max(x_plot);
p.YLim(2) = max(y_plot);
xlabel('d (km)')
ylabel('d (km)')
zlabel('h (m)')
title('Visão tridimensional da região')
end