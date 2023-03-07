clear
close all

% Imagem teste
figure;
p=surf(peaks(500).','EdgeAlpha',0.15);

% Início do código
[~,~,image] = peaks(500);
escala = 1;
azimute = -135; % em grau
x_inicial = 100.5;
y_inicial = 210.5;

% Encontra pixels iniciais
[x_p_inicial,y_p_inicial] = posicao_dist2pix(x_inicial,y_inicial,escala);
[M,N] = size(image);

% Encontra coordenadas finais de acordo com direcao
[x_final,y_final] = seleciona_maximas_coordenadas(M,N,azimute*pi/180,x_p_inicial,y_p_inicial,escala);

% Plota contorno
figure
contourf(image.')
hold on
plot([x_p_inicial x_final],[y_p_inicial y_final],'r','LineWidth',1.5)
plot(x_p_inicial,y_p_inicial,'*k','MarkerSize',8)

% Marca o tempo
tic
% Seleciona pixels onde a direcao passa
[x,y,z] = seleciona_quadrados_v3(image,x_inicial,y_inicial,x_final,y_final);
toc

%% Terra plana
% Retorna inclinacao das alturas achadas
[angulos] = retorna_inclinacao_plana(image,x,y);

% Transforma angulos em alturas
[h,d] = encontra_altitude_minima_plana(x,y,z,angulos);

% Plota alturas achadas
hold on
plot3(x,y,h,'r','LineWidth',1.5)

% Plota direcao com altura de visada encontrada
figure
plot(d,z)
hold on
grid on
plot(d,h,':r','LineWidth',1.5)
plot(d(1),h(1),'*k','MarkerSize',8)
xlabel('d')
ylabel('h')
title('Altitudes na direção traçada - Terra plana')

%% Terra esférica
R = 6000;
escala = 1;

% Retorna inclinacao das alturas achadas
[as, bs] = retorna_inclinacao_esferica(image,x,y,R,escala);

% Transforma angulos em alturas
[h,d] = encontra_altitude_minima_esferica(x,y,z,as,bs,escala,R);

% Plota alturas achadas
figure;
p=surf(peaks(500).','EdgeAlpha',0.15);
hold on
plot3(x,y,h,'r','LineWidth',1.5)

% Plota direcao com altura de visada encontrada
figure
plot((z+R).*sin(d/R),(z+R).*cos(d/R)-R)
hold on
grid on
plot((h+R).*sin(d/R),(h+R).*cos(d/R)-R,':r','LineWidth',1.5)
plot(d(1),h(1),'*k','MarkerSize',8)
xlabel('d')
ylabel('h')
title('Altitudes na direção traçada - Terra esférica')

% Plota direcao com altura de visada encontrada como se fosse Terra plana
figure
plot(d,z)
hold on
grid on
plot(d,h,':r','LineWidth',1.5)
plot(d(1),h(1),'*k','MarkerSize',8)
xlabel('d')
ylabel('h')
title('Altitudes na direção traçada - Valores da Terra esférica em Terra plana')
