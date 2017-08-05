%Matlab-Projekt Aufgabe 4

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    x(zeile,spalte)
                    
%}
clear


%% Einlesen des Bildes

bild = imread('Aufgabe4.png');
% bild2=flip(flip(bild,2),1)

%% PN-Generator

% generatorpolynom=[12 8 2 0];
generatorpolynom=[[8 2 0]];
% initialwert=[1 0 0 0 1 0 0 0 0 0 1 0];
initialwert=[1 0 0 0 0 0 1 0];

h = commsrc.pn('GenPoly', generatorpolynom, 'Mask', initialwert);
set(h, 'NumBitsOut', 1023);
pnseq = generate(h);



% pn = comm.PNSequence('Polynomial', generatorpolynom, 'InitialConditions', initialwert, 'BitPackedOutput',10, 'SamplesPerFrame',12)
% x1 = step(pn);
% [x1(1:7) x1(8:14)]
% ergebnismatrix=xor(pn,bild);


%%
a=[1 1; 0 0];
b=[1 0; 1 0];
c=xor(a,b)

%% 
figure(1);
subplot(1,2,1);
imshow(bild);

subplot(1,2,2);
imshow(bild2);