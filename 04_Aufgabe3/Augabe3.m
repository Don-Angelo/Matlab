%Matlab-Projekt Aufgabe 3

%{
    Autor: Marcel Grandinetti
    Datum:05.08.2017
    Beschribung:    M-Script zum erzeugen einer Helix        
                    Eine Periode = 2pi --> 10 Perioden = 20pi
                    20pi=50s*w --> w=0.4pi           
%}
clear


%% Funktionsdefinition

%Grundeinstellungen
laenge=50;
windungen=10;

%Kreisfrequenz berechnen
w=2*(windungen/laenge)*pi;

%Zeitachse
t=[0:0.01:laenge]; 

%Amplitude
a=1.2*t;

%X-Funktion
x=a.*sin(w*t);

%Y-Funktion
y=a.*cos(w*t);


%% Plot

%Plot Helix 3D
figure(1);
plot3(x,y,t);
box on;
grid on;
title('Helix 3D');
xlabel('x');
ylabel('y');
zlabel('t');

%Plot Helix Draufsicht
figure(2);
plot3(x,y,t);
box on;
grid on;
title('Helix Draufsicht');
xlabel('x');
ylabel('y');
view(2);