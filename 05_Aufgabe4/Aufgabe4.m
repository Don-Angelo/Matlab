%Matlab-Projekt Aufgabe 4

%{
    Autor: Marcel Grandinetti
    Datum:05.08.2017
    Beschribung:    Einlesen eines binären Bildes, mittels PN-Sequenz
                    entschlüsseln, Bits sortieren und als Text ausgeben
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

%Binäre Matrix in einen Vektor umwandeln
binDaten=reshape(bild,pixelanzahl,[]);



%% PN-Generator

%Parameter
generatorpolynom=[12 8 2 0];
initialwert=[1 0 0 0 1 0 0 0 0 0 1 0];

%PN-Klasse
pnFunktion = comm.PNSequence(   'Polynomial', generatorpolynom,...
                                'VariableSizeOutput', false,...
                                'SamplesPerFrame', pixelanzahl,...
                                'InitialConditions', initialwert);

%PN-Reihe erzeugen
pnReihe = step(pnFunktion);

%Binäre Bilddaten mit der PN reihe entschlüsseln
binErgebnis=xor(binDaten,pnReihe);


%% In Text umwandeln

%Binärdaten in einen Matrix mit der Breite des ASCII Formats (8 Bit) umwandeln
binText=reshape(binErgebnis,8,[]).';

%Double Format in char Format ändern
binText=num2str(binText);

%Binärblöcke der Matrix in Dezimalzahlen umwandeln
decText=bin2dec(binText);

%Dezimalzahlen in Buchstaben wandeln und zu einem Spaltenvector formatieren
text=char(decText).';

%Text umdrehen
text=flip(text);

%Text ausgeben
disp(text);