%Eilesen des Bildes
clear
Originalbild = imread('Aufgabe1.png');
class(Originalbild)
Bild=Originalbild;
%Bild=bitget(Originalbild,8:-1:1,'unit16');
class(Bild)

a=Originalbild(1,1)
dec2bin(a)
bitget(a,8:-1:1,'uint8')

%Originalbild Darstellen
%figure(1);
%imshow(Originalbild);