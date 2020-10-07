function [ m,all,q ] = local2( str1,str2,match,mismatch,gap )
a=length(str2)+1; %wiersze
b=length(str1)+1; %kolumny
m=zeros(a,b);

H=0;
H_skos=0;
H_lewo=m(2,1);
H_gora=m(1,2);
for i=2:a %wiersze
   for j=2:b %kolumny
       if str1(j-1)==str2(i-1)
           H_skos=m(i-1,j-1)+match;
       else
           H_skos=m(i-1,j-1)+mismatch;
       end   
       H_lewo=m(i,j-1)+gap;
       H_gora=m(i-1,j)+gap;
       if H_skos<0
           H_skos=0;
       end
       if H_lewo<0
           H_lewo=0;
       end
       if H_gora<0
           H_gora=0;
       end
       liczby=[H_skos,H_lewo,H_gora];
       H=max(liczby);
       m(i,j)=H;
   end
end

all=struct('gaps',0.0,'procent',0.0,'s1','','s2','','wiersze',[],'kolumny',[],'identity','');

max1=max(m(a,:));
max2=max(m(:,b));
if max2>max1
    max1=max2;
end
indx_max=[];
indy_max=[];
%dla kazdego maxa:

for i=1:b
    if m(a,i)==max1
        indx_max=[indx_max,i];
        indy_max=[indy_max,a];
    end
end
for i=1:(a-1)
    if m(i,b)==max1
        if(i~=b)
        indy_max=[indy_max,i];
        indx_max=[indx_max,b];
        end
    end
end

for q=1:length(indx_max)

sciezka=[];
wiersze=[];
kolumny=[];
i=indy_max(q);%(q);%wiersze, str2
j=indx_max(q);%(q);%kolumny
sciezka(1)=max1;
H_skos=0;
H_lewo=0;
H_gora=0;
dop_str1=[];
dop_str2=[];
wiersze=[wiersze,i];
kolumny=[kolumny,j];
gaps=0;
f=true;
while i>1 && f==true;
   while j>1 && f==true;
       if m(i,j)==0
          f=false;
          break;
       end
       if str1(j-1)==str2(i-1)
           sciezka=[sciezka,m(i-1,j-1)];
           i=i-1;
           j=j-1;
           dop_str1=[dop_str1,str1(j)];
           dop_str2=[dop_str2,str2(i)];
       else
           H_skos=m(i-1,j-1);
           H_lewo=m(i-1,j);
           H_gora=m(i,j-1);
           liczby=[H_skos,H_lewo,H_gora];
           H=max(liczby);
           sciezka=[sciezka,H];
           if (H==H_skos)
              i=i-1;
              j=j-1; 
              dop_str1=[dop_str1,str1(j)];
              dop_str2=[dop_str2,str2(i)];
           elseif (H==H_lewo)
               i=i-1;
               dop_str1=[dop_str1,'–'];
               dop_str2=[dop_str2,str2(i)];
               gaps=gaps+1;
           else
               j=j-1;
               dop_str2=[dop_str2,'–'];
               dop_str1=[dop_str1,str1(j)];
               gaps=gaps+1;
           end
       end
       wiersze=[wiersze,i];
       kolumny=[kolumny,j];
       if((j==1&&i==2) || (i==1&&j==2))
                sciezka=[sciezka,0]; 
                wiersze=[wiersze,1];
                kolumny=[kolumny,1];
                gaps=gaps+1;
                if(j==1)
                    dop_str1=[dop_str1,'–'];
                    dop_str2=[dop_str2,str2(i-1)];
                else
                    dop_str2=[dop_str2,'–'];
                    dop_str1=[dop_str1,str1(j-1)];
                end
                f=false;
       end
   end    
end


dop_str1=fliplr(dop_str1);
dop_str2=fliplr(dop_str2);
dopasowanie=0;
if (length(dop_str1)<length(dop_str2))
   i=length(dop_str1);
else
    i=length(dop_str2);
end
for j=1:i
    if (dop_str1(j)==dop_str2(j))
        dopasowanie=dopasowanie+1;
    end
 end
procent=dopasowanie/length(dop_str1)*100;
pr=round(10*procent)/10;
identity=[num2str(dopasowanie),'/',num2str(length(dop_str1)),' (',num2str(pr),'%)'];

w1=fliplr(wiersze);
k1=fliplr(kolumny);
all(q).gaps=gaps;
all(q).procent=procent;
all(q).s1=dop_str1;
all(q).s2=dop_str2;
all(q).wiersze=w1;
all(q).kolumny=k1;
all(q).identity=identity;
end
Afields = fieldnames(all);
Acell = struct2cell(all);
sz = size(Acell);
Acell = reshape(Acell, sz(1), []); 
Acell = Acell';
Acell = sortrows(Acell, 2);
Acell = reshape(Acell', sz);
Asorted = cell2struct(Acell, Afields, 1);
all=Asorted;

q=length(indx_max);
end

