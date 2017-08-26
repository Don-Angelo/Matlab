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
originalbild = imread('Aufgabe1.png');

%HSB-Bild exportieren
bildMSB=bitshift(originalbild,-8);  %Bits nach rechts verschieben
bildMSB=uint8(bildMSB);             %Bild in uint8 umwandeln (8LSB werden verworfen)

%LSB-Bild exporiteren
bildLSB=bitshift(originalbild,8);   %Bits nach links versc hieben
bildLSB=bitshift(bildLSB,-8);       %Bits nach rechts verschieben
bildLSB=uint8(bildLSB);             %Bild in uint8 umwandeln (8HSB werden verworfen)

%Jede zweite zeile der Matrix in der mitte Flippen
bildLSB(2:2:size(bildLSB,1),:,:)=flip(bildLSB(2:2:size(bildLSB,1),:,:),2);
                                    %Size(x,1) gibt die anzahl an Zeilen aus
                                    %flip(x,2) Flippt die Zeilen in der Mitte
                                    
%Grün  und blau Anteile tauschen
bildLSBgruen=bildLSB(:,:,2);        %Grüner Anteil Zwischenspeichern
bildLSB(:,:,2)=bildLSB(:,:,3);      
bildLSB(:,:,3)=bildLSBgruen;
clear BildLSBgruen;                 %Zwischenspeicher nicht mehr benötigt


%% Teil 2:

%HSB-Bild in HSV-Bild umwandeln
bildHSV=rgb2hsv(bildMSB);

%Grenzwerte zum Ersetzen definieren
multiplikator=1/360;                %Multiplikator pro grad da HSV Raum von 0-1=>0-360°
untereGrenze=30;                    %Farbangabe in Grad      
untereGrenze=untereGrenze*multiplikator;
obereGrenze=220;                    %Farbangabe in Grad
obereGrenze=obereGrenze*multiplikator;

%Grünwerte anhand der Grenzen finden und ersetzen
bildHSV(find(bildHSV(:,:,1)>untereGrenze & bildHSV(:,:,1)<obereGrenze))=1;

%HSV-Bild in RGB-Bild zurückwandeln
bildErdbeer=hsv2rgb(bildHSV);


%% Bildausgabe

%HSB-Bild
figure(1);
imshow(bildMSB);
title('MSB-Bild');
imwrite(bildMSB,'Aufgabe1_MSB.png');

%LSB-Bild
figure(2);
imshow(bildLSB);
title('LSB-Bild');
imwrite(bildLSB,'Aufgabe1_LSB.png');

%Erdbeereis
figure(3);
imshow(bildErdbeer);
title('Erdbeereis');
imwrite(bildErdbeer,'Aufgabe1_Erdbeereis.png');