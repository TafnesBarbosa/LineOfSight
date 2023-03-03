clear
close all

% Imagem teste
figure;
p=surf(peaks(500).','EdgeAlpha',0.15);

% Início do código
[~,~,image] = peaks(500);
escala = 1;
azimute = 40; % em grau
x_inicial = 11.5;
y_inicial = 26.5;

% Encontra pixels iniciais
[x_p_inicial,y_p_inicial] = posicao_dist2pix(x_inicial,y_inicial,escala);
[M,N] = size(image);

% Encontra coordenadas finais de acordo com direcao
[x_final,y_final] = seleciona_maximas_coordenadas(M,N,azimute*pi/180,x_p_inicial,y_p_inicial,escala);

% Marca o tempo
tic
% Seleciona pixels onde a direcao passa
[x,y,z] = seleciona_quadrados_v2(image,x_inicial,y_inicial,x_final,y_final);
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

%% Terra esférica
R = 15*2*pi*6400/7;
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
plot((z+R).*sin(d/R),(z+R).*cos(d/R))
hold on
grid on
plot((h+R).*sin(d/R),(h+R).*cos(d/R),':r','LineWidth',1.5)