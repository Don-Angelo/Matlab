%Matlab-Projekt Aufgabe 4

%{
    Autor: Marcel Grandinetti
    Datum:05.08.2017
    Beschribung:    Einlesen eines bin�ren Bildes, mittels PN-Sequenz
                    entschl�sseln, Bits sortieren und als Text ausgeben.                  
%}
clear


%% Einlesen des Bildes

%Bild einlesen
bild = imread('Aufgabe4.png');

%Daten auswerten
pixelanzahl=size(bild,1)*size(bild,2);

%Transponierte Erzeugen, damit im reshape vorgang die Matrix richtig
%abgearbeitet wird
bild=bild.';

%Bin�re Matrix in einen Vektor umwandeln
binDaten=reshape(bild,pixelanzahl,[]);



%% PN-Generator

%Parameter
generatorpolynom=[12 8 2 0];
initialwert=[1 0 0 0 1 0 0 0 0 0 1 0];

pnFunktion = comm.PNSequence('Polynomial', generatorpolynom,'VariableSizeOutput', false,'SamplesPerFrame', pixelanzahl,'InitialConditions', initialwert);

%
pnReihe = step(pnFunktion);


binErgebnis=xor(binDaten,pnReihe);


%% In Text umwandeln

%Bin�rdaten in einen Matrix mit der Breite des ASCII formats (8) umwandeln
binText=reshape(binErgebnis,8,[]).';

%Double Format in char Format �ndern
binText=num2str(binText);

%Bin�rbl�cke der Matrix in Dezimalzahlen umwandeln
decText=bin2dec(binText);

%Dezimalzahlen in Buchstaben wandeln und zu einem Spaltenvector formatieren
text=char(decText).';

%Text umdrehen
text=flip(text);

%Text ausgeben
disp(text);


%% a

a=[1 2 ; 3 4; 5 6]
x=size(a,1)*size(a,2)
b=reshape(a,x,[])
c=reshape(a.',x,[])