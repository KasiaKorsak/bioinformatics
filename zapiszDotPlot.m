function [ ] = zapiszDotPlot( a,b,m )
%jesli nie istnieje folder 'saved' to go tworzymy
if ~(exist('saved','dir'))
   mkdir('../program','saved');
end
%otworzenie folderu 'saved'
cd saved
%zapis plikow
saveas(scatter(a,b),'wykresDotPlot','jpg');
xlswrite('macierzDotPlot',m);
end

