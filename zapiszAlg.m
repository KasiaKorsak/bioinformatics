function [ ] = zapiszAlg( kolumny,wiersze,m )
%jesli nie istnieje folder 'saved' to go tworzymy
if ~(exist('saved','dir'))
   mkdir('../program','saved');
end
%otworzenie folderu 'saved'
cd saved
%zapis plikow
xlswrite('macierzGlobalne',m); %zapisanie wypelnionej macierzy
figure 
imagesc(m)
colormap parula
hold on;
plot(kolumny,wiersze,'k.'); %zapisanie mapy kolorow ze sciezka
hold off;
set(gca,'Position',[0 0 1 1]); % Make the axes occupy the hole figure
saveas(gcf,'Image','png');
close all;
end