function [ p ] = loadFile(  )
p = fastaread(uigetfile('*.fasta','Select All files'));
end

