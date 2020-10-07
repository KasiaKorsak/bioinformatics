function [ sys ] = sysOut( A,B )
%wyswietlenie dopasowania
a=mod(length(A),30); %30 - ilosc znakow w wierszu
for i=1:(30-a)
   A(end+1)=' '; 
end
A=cellstr(reshape(A,30,[])');
a=mod(length(B),30);
for i=1:(30-a)
   B(end+1)=' '; 
end
B=cellstr(reshape(B,30,[])');
[c d]=size(B);
sys={};
for i=1:c
   sys{i}=[A{i},char(10),B{i},char(10)]; %char(10) - nowa linia
end
end

