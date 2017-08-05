%Matlab-Projekt Aufgabe 2

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    Eine Periode = 2pi --> 10 Perioden = 20pi
                    20pi=50s*w --> w=0.4pi
                    
%}
clear


%% Funktion

t=[0:0.01:50];
w=0.4*pi;
x=1.2*t.*sin(w*t);
y=1.2*t.*cos(w*t);


%% Plot

figure(1)
plot3(x,y,t);
box on;
grid on;