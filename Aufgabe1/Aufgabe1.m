%Matlab-Projekt Aufgabe 1

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    Teil 1: Einlesen des Bildes und aufspalten in ein HSB-Bild und ein 
                            LSB-Bild (HSB = die 8 h�chstwertigen Bits LSB = die 8
                            niederwertigen Bits, Originalbild hat 16 Bits)
                            und das LSB-Bild so bearbeiten, dass es richtig
                            dargestellt wird.

                    Teil 2: Waldmeistereis des HSB-Bildes in Erdbeereis
                            umwandeln
%}
clear


%% Teil 1:

%Eilesen des Bildes
Originalbild = imread('Aufgabe1.png');

%HSB-Bild exportieren
BildHSB=bitshift(Originalbild,-8);
BildHSB=uint8(BildHSB);             %Bild in uint8 umwandeln (8LSB werden verworfen)

%LSB-Bild exporiteren
BildLSB=bitshift(Originalbild,8);   %Bits nach links versc hieben
BildLSB=bitshift(BildLSB,-8);       %Bits nach rechts verschieben
BildLSB=uint8(BildLSB);             %Bild in uint8 umwandeln

%Jede zweite zeile der Matrix in der mitte Flippen
BildLSB(2:2:size(BildLSB,1),:,:)=flip(BildLSB(2:2:size(BildLSB,1),:,:),2);
                                    %Size(x,1) gibt die anzahl an Zeilen aus
                                    %flip(x,2) Flippt die Zeilen in der Mitte
                                    
%Gr�n  und blau Anteile tauschen
BildLSBgruen=BildLSB(:,:,2);
BildLSB(:,:,2)=BildLSB(:,:,3);
BildLSB(:,:,3)=BildLSBgruen;
clear BildLSBgruen


%% Teil 2:

%HSB-Bild in HSV-Bild umwandeln
BildHSV=rgb2hsv(BildHSB);

%Grenzwerte zum Ersetzen definieren
multiplikator=1/360;                %Multiplikator pro grad da HSV Raum von 0-1=>0-360�
untereGrenze=30;                    %Farbangabe in Grad      
untereGrenze=untereGrenze*multiplikator;
obereGrenze=220;                    %Farbangabe in Grad
obereGrenze=obereGrenze*multiplikator;

%Gr�nwerte anhand der Grenzen finden und ersetzen
BildHSV(find(BildHSV(:,:,1)>untereGrenze & BildHSV(:,:,1)<obereGrenze))=1;

%HSV-Bild in RGB-Bild zur�ckwandeln
BildErdbeer=hsv2rgb(BildHSV);


%% Bildausgabe

%HSB-Bild
figure(2);
imshow(BildHSB);
imwrite(BildHSB,'Aufgabe1_HSB.png');

%LSB-Bild
figure(3);
imshow(BildLSB);
imwrite(BildLSB,'Aufgabe1_LSB.png');

%Erdbeereis
figure(4);
imshow(BildErdbeer);
imwrite(BildErdbeer,'Aufgabe1_Erdbeereis.png');