%Matlab-Projekt Aufgabe 1

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    Teil 1: Einlesen des Bildes und aufspalten in ein HSB-Bild und ein 
                            LSB-Bild (HSB = die 8 höchstwertigen Bits LSB = die 8
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
    %Size(x,1) gibt die anzahl an Zeilen aus
    %flip(x,2) Flippt die Zeilen in der Mitte
BildLSB(2:2:size(BildLSB,1),:,:)=flip(BildLSB(2:2:size(BildLSB,1),:,:),2);

%Grün  und blau Anteile tauschen
BildLSBgruen=BildLSB(:,:,2);
BildLSB(:,:,2)=BildLSB(:,:,3);
BildLSB(:,:,3)=BildLSBgruen;

%% Teil 2:

%HSB-Bild in HSV-Bild umwandeln
BildHSV=rgb2hsv(BildHSB);

BildErdbeer=hsv2rgb(BildHSV);

%% Testsection




%% Bildausgabe

%Originalbild
figure(1);
imshow(Originalbild);

%HSB-Bild
figure(2);
imshow(BildHSB);

%LSV-Bild
figure(3);
imshow(BildLSB);

%Erdbeereis
figure(4);
imshow(BildErdbeer);