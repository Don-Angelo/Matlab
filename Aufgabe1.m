%Marlab-Projekt Aufgabe 1

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    Teil 1: Einlesen des Bildes und aufspalten in ein HSB-Bild und ein 
                            LSB-Bild (HSB = die 8 höchstwertigen Bits LSB = die 8
                            niederwertigen Bits)
            
%}
clear

%% Teil 1:


%Eilesen des Bildes
Originalbild = imread('Aufgabe1.png');


%HSB-Bild exportieren
BildHSB=bitshift(Originalbild,-8);
BildHSB=uint8(BildHSB);        %Bild in uint8 umwandeln (8LSB werden verworfen)


%LSB-Bild exporiteren
BildLSB=bitshift(Originalbild,8);   %Bits nach links versc hieben: 
                                        %0110000001010101 -> 0101010100000000
BildLSB=bitshift(BildLSB,-8);       %Bits nach rechts verschieben: 
                                        %0101010100000000 -> 01010101
BildLSB=uint8(BildLSB);             %Bild in uint8 umwandeln


%Bit Beispiel
dec2bin(Originalbild(1,1,1))
dec2bin(BildHSB(1,1,1))
dec2bin(BildLSB(1,1,1))





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