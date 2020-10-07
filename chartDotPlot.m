function [ a,b,m,i,s ] = chartDotPlot( str1,str2,t )

%zapewnienie jednakowej dlugosci ciagu znakow
s1=str1;s2=str2;
if length(str1)>length(str2)
    div=length(str1)-length(str2);
        for i=1:div
        s2=[s2 str2(i)];
        end
elseif length(str1)<length(str2)
div=length(str2)-length(str1);
for i=1:div
s1=[s1 str1(i)];
end
end
str1=s1;
str2=s2;

macierz=zeros(length(str1),length(str2));
%utworzenie macierzy zero-jedynkowej dla miejsc wystapienia rownosci
for i=1:length(str1)
  for j=1:length(str2)
    if str1(i)==str2(j)
        macierz(j,i)=1;
    end
   end
end

macierz2=zeros(size(macierz));
m=eye(t); %macierz diagonalna o zadanej ilosci kropek w ciagu
a=[];
b=a;
%filtracja - dzielimy macierz zero-jedynkowa na macierze wielkosci txt i
%przyrownujemy do macierzy diagonalnej m; jesli sa rowne zapisuje zgodna
%macierz do nowej macierzy2
for i=1:(length(macierz)-(length(m)-1))
    for j=1:(length(macierz)-(length(m)-1))
        %A - macierz pomocnicza
         A=diag( diag( macierz(i:(i+length(m)-1),j:(j+length(m)-1)) ) ); 
         %funkcja diag(diag(x)) pozostawia wartosci jedynie na przekatnej 
         %tej macierzy, reszte zeruje
            if A==m
                macierz2(i:(i+length(m)-1),j:(j+length(m)-1))=m;
            end
    end
end

%zapisanie wartosci wspolrzednych dla jedynek w wektorach a i b
a=[];
b=[];
for x=1:length(macierz2)      
    for y=1:length(macierz2)
        if macierz2(x,y)==1
        a=[a,x];
        b=[b,y];
        end 
    end
end
m=macierz2;

indel = false;
substytucja = false;

%sprawdzenie mutacji - wystapi jesli nastapi przesuniecie wykresu
%w gore (po osi Y)
size(m,2)
for i=1:size(m,1)
    l=0;
    for j=1:size(m,2)
        if m(i,j)==1
        l = l+1;
        end
    end
    if l > 1
    indel = true;
    substytucja = true;
    break;
    end
end

%jesli nastapilo przesuniecie w macierzy w prawo to oznacza delecje
for j=1:size(m,2)
    l = 0;
    for i=1:size(m,1)
        if m(j,i)==1
        l = l+1;
        end
    end
    if l>=0
    indel = true;
    break;
    end
end

%substytucja wystapi jesli na przekatnej bedzie przerwa, tzn. gdzies
%zamiast 1 bedzie 0
for i=1:size(m,1)
    l = 0;
        if m(i,i)==0
        l= l+1;
        end
end
    if l > 0
    substytucja = true;
    end
    
i=indel;
s=substytucja;
end

