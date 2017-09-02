%Matlab-Projekt Aufgabe 5

%{
    Autor: Marcel Grandinetti
    Datum:05.08.2017
    Beschribung:    Alle Parameter für die PLL
%}
clear

% RF Parameter
f=9000; % Trägerfrequenz

% Loop Parameter
Kd=0.5; % Definition des Phasendetektorgewinns
K0=2*pi*400; % Definition der VCO Konstante in rad/Hz
w0=2*pi*190; % Definition der PLL Eigenfrequenz
zeta=0.7; % Definition der Dämpfung der PLL Regelschleife

% Analoges Loop Regelfilter habe die Form: F(s) = (1 + tau2*s)/(1 + tau1*s)
tau1=K0*Kd/w0^2;
tau2=2*zeta/w0-1/(K0*Kd);

% Simulink Simulation der zeitkontinuierlichen PLL (Aquisition)
stop=32; % Simulationsende in Sekunden

%Open Simulink Model
open_system PLL.slx

% Parameters for Simulation
set_param('PLL', 'StopTime', 'stop')

%start Simulation
sim PLL.slx