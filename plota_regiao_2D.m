function plota_regiao_2D(image,h,x,y,x_p_inicial,y_p_inicial,N_lines,y_AE,x_AE)
figure;
f = gcf;
f.Position = [403 246 760 420];
subplot(1,2,1);
% contourf(image.',':')
imagesc(image)
hold on

a_min = Inf;
a_max = -Inf;
for i=2:length(h)
    if ~isempty(h{i})
        if a_min > min(h{i})
            a_min = min(h{i});
        elseif a_max < max(h{i});
            a_max = max(h{i});
        end
    end
end

H_plot = ((a_max-a_min)/N_lines:(a_max-a_min)/N_lines:(a_max-a_min)) + a_min*-0.01;

x_p = cell(1,length(H_plot));
y_p = cell(1,length(H_plot));
for i=1:length(H_plot)
    [x_p{i},y_p{i}] = procura_altura(h,x,y,H_plot(i));
end

Colors = [];
for i=1:length(H_plot)
    vec = [1 0.7-0.7*i/length(H_plot) 0];
    if i > length(H_plot)/2 && i <= length(H_plot)/2 + 1
        p_plot = plot(y_p{i},x_p{i},'Color',vec,'LineWidth',1.5);
    else
        plot(y_p{i},x_p{i},'Color',vec,'LineWidth',1.5)
    end
    Colors = [Colors; vec];
end
pAntena = plot(y_p_inicial,x_p_inicial,'*k');
p2=gca;
ay = p2.YTickLabel;
for i=1:length(p2.YTickLabel)
    p2.YTickLabel{i} = num2str(0.03*str2num(ay{length(ay)-i+1}));
end
for i=1:length(p2.XTickLabel)
    p2.XTickLabel{i} = num2str(0.03*str2num(p2.XTickLabel{i}));
end
pAE = plot(y_AE,x_AE,'--k','LineWidth',1.5); % Regiao de ensaio
% L=legend([pAntena pAE p_plot],{'Antena da Telemetria','Área de Ensaio',['    Mínima Altura' char(10) 'para Visada Direta']}); % Area de Ensaio
L=legend([pAntena pAE p_plot],{'Antena da Telemetria',['    Mínima Altura' char(10) 'para Visada Direta']});
xlabel('d (km)')
ylabel('d (km)')
title('Alturas para linhas de visada direta com h_{antena} = 25 m');

f=subplot(1,2,2);
[~,p]=contourf([0 1],H_plot,[H_plot.' H_plot.']);
p.LineStyle = ':';
p.LevelList = H_plot;
colormap(f,Colors);
ylabel('h (m)')

p1=gca;
p1.Position(1) = 0.66;
p1.Position(3) = 0.03;
p1.YAxisLocation = 'right';
p1.XTickLabel = {''};
p1.YTick = round(H_plot);
p1.YLim = [floor(p1.YLim(1)) ceil(p1.YLim(2))];
% for i=1:length(p1.YTickLabel)
%     p1.YTickLabel{i} = num2str(round(str2num(p1.YTickLabel{i})));
% end

p2.Position(3) = 0.575;
p2.Position(1) = 0.075;

L.Position = [0.7790 0.8405 0.1803 0.0857];
end