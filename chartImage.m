function [  ] = chartImage( m,kolumny,wiersze )
%tworzenie mapy kolorow
imagesc(m);
colormap parula
hold on;
plot(kolumny,wiersze,'k.'); %sciezka
hold off;
ylabel('Sekwencja 1');xlabel('Sekwencja 2');
end

