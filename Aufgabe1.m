%Eilesen des Bildes
clear
Originalbild = imread('Aufgabe1.png');
class(Originalbild)

%In HSB-Bild exportieren
BildVordergrund=im2uint8(Originalbild);
class(BildVordergrund)





%Originalbild Darstellen
figure(1);
imshow(Originalbild);
%HSB-Bild Darstellen
figure(2);
imshow(BildVordergrund);