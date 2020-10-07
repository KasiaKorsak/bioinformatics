function [ sequence ] = plik(  )
p = fastaread(uigetfile);
sequence = p.Sequence;
end

