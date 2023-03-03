clear
close all
load('Regiao_SJC.mat');
% figure
% imagesc(results.image)
% hold on
% plot(results.antena_position_col,results.antena_position_row,'*r','MarkerSize',8)
% p=gca;
% p.Visible = 'off'
% title('Região sudeste do Brasil englobando São José dos Campos')

% Regiao de analise
image = double(results.image);
h_antena = 25; % altura da antena
image(results.antena_position_row,results.antena_position_col) = image(results.antena_position_row,results.antena_position_col) + h_antena; % Considerando antena

% Area de ensaio
% image = double(results.image(3601:9001,3601:9001)); % Regiao de ensaio
% image(results.antena_position_row-3600,results.antena_position_col-3600) = image(results.antena_position_row-3600,results.antena_position_col-3600) + h_antena; % Considerando antena (area de ensaio)
% xAE1 = 421; yAE1 = 2551;
% xAE2 = 3085; yAE2 = 4411;
% xAE3 = 3781; yAE3 = 1201;
% xAE4 = 3547; yAE4 = 421;

% %% Terra plana
% escala = 1;
% x_inicial = results.antena_position_row-0.5;
% y_inicial = results.antena_position_col-0.5;
% clear results
% 
% % Encontra pixels iniciais
% [x_p_inicial,y_p_inicial] = posicao_dist2pix(x_inicial,y_inicial,escala);
% [M,N] = size(image);
% 
% % Encontra coordenadas finais de acordo com direcao
% azimute = [0:0.25:180 -179.75:0.25:-0.25];
% x = cell(1,length(azimute));
% y = cell(1,length(azimute));
% z = cell(1,length(azimute));
% angulos = cell(1,length(azimute));
% h = cell(1,length(azimute));
% for i=1:length(azimute)
%     [x_final,y_final] = seleciona_maximas_coordenadas(M,N,azimute(i)*pi/180,x_p_inicial,y_p_inicial,escala);
% %     if i == 22 || i == 203 % Azimute passo = 1
% %     if i == 86 || i == 87 % Azimute passo = 1 (regiao de ensaio)
% %     if i == 44 || i == 55 || i == 56 % Azimute passo = 0.5
% %     if i <=173 && i >= 170 % Azimute passo = 0.5 (regiao de ensaio)
% %     if i == 88 || i == 109 || i == 110 || i == 115 || i == 123 || i == 145 || i == 167 || i == 809 % Azimute passo = 0.25
% %     if i == 336 || i == 339 || i == 341 || i == 342 || i == 344 || i == 345 % Azimute passo = 0.25 (regiao de ensaio)
% %         [x{i},y{i},z{i}] = seleciona_quadrados(image,M,N,escala,x_inicial,y_inicial,x_final,y_final);
% %     else
% %         [x{i},y{i},z{i}] = seleciona_quadrados_v2(image,x_inicial,y_inicial,x_final,y_final);
% %     end
%     try
%         [x{i},y{i},z{i}] = seleciona_quadrados_v2(image,x_inicial,y_inicial,x_final,y_final);
%     catch
%         [x{i},y{i},z{i}] = seleciona_quadrados(image,M,N,escala,x_inicial,y_inicial,x_final,y_final);
%     end
%     [angulos{i}] = retorna_inclinacao_plana(image,x{i},y{i});
%     [h{i},d] = encontra_altitude_minima_plana(x{i},y{i},z{i},angulos{i});
%     display([num2str(i/length(azimute)*100) ' %']);
% end
% 
% % Plota regiao 2D
% plota_regiao_2D(image,h,x,y,x_p_inicial,y_p_inicial,8,[],[])
% 
% % Plota regiao 3D
% % plota_regiao_3D(image,x,y,h,x_p_inicial,y_p_inicial,20)

%% Terra esferica
escala = 1;
x_inicial = results.antena_position_row-0.5;
y_inicial = results.antena_position_col-0.5;
clear results

% Encontra pixels iniciais
[x_p_inicial,y_p_inicial] = posicao_dist2pix(x_inicial,y_inicial,escala);
[M,N] = size(image);

% Encontra coordenadas finais de acordo com direcao
azimute = [0:0.25:180 -179.75:0.25:-0.25];
x = cell(1,length(azimute));
y = cell(1,length(azimute));
z = cell(1,length(azimute));
as = cell(1,length(azimute));
bs = cell(1,length(azimute));
h = cell(1,length(azimute));
for i=1:length(azimute)
    [x_final,y_final] = seleciona_maximas_coordenadas(M,N,azimute(i)*pi/180,x_p_inicial,y_p_inicial,escala);
%     if i == 22 || i == 203 % Azimute passo = 1
%     if i == 86 || i == 87 % Azimute passo = 1 (regiao de ensaio)
%     if i == 44 || i == 55 || i == 56 % Azimute passo = 0.5
%     if i <=173 && i >= 170 % Azimute passo = 0.5 (regiao de ensaio)
%     if i == 88 || i == 109 || i == 110 || i == 115 || i == 123 || i == 145 || i == 167 % Azimute passo = 0.25
%     if i == 336 || i == 339 || i == 341 || i == 342 || i == 344 || i == 345 % Azimute passo = 0.25 (regiao de ensaio)
%         [x{i},y{i},z{i}] = seleciona_quadrados(image,M,N,escala,x_inicial,y_inicial,x_final,y_final);
%     else
%         [x{i},y{i},z{i}] = seleciona_quadrados_v2(image,x_inicial,y_inicial,x_final,y_final);
%     end
    try
        [x{i},y{i},z{i}] = seleciona_quadrados_v2(image,x_inicial,y_inicial,x_final,y_final);
    catch
        [x{i},y{i},z{i}] = seleciona_quadrados(image,M,N,escala,x_inicial,y_inicial,x_final,y_final);
    end
    [as{i}, bs{i}] = retorna_inclinacao_esferica(image,x{i},y{i},6400000,30);
    [h{i},d] = encontra_altitude_minima_esferica(x{i},y{i},z{i},as{i},bs{i},30,6400000);
    display([num2str(i/length(azimute)*100) ' %']);
end

% Plota regiao 2D
plota_regiao_2D(image,h,x,y,x_p_inicial,y_p_inicial,8,[],[])

% Plota regiao 3D
% plota_regiao_3D(image,x,y,h,x_p_inicial,y_p_inicial,20) % para area de ensaio