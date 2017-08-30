% Dimensionierung einer kontinuierlichen PLL zur FM Demodulation
clear
% RF Parameter
f=1e6; % Trägerfrequenz
df=25e3; % Frequenzhub bei FM Modulation
fmod=10e3; % Modulationsfrequenz
% Loop Parameter
Kd=0.5; % Definition des Phasendetektorgewinns
K0=2*pi*1e5; % Definition der VCO Konstante in rad/Hz
w0=2*pi*50e3; % Definition der PLL Eigenfrequenz
zeta=0.7; % Definition der Dämpfung der PLL Regelschleife
% Analoges Loop Regelfilter habe die Form: F(s) = (1 + tau2*s)/(1 + tau1*s)
tau1=K0*Kd/w0^2;
tau2=2*zeta/w0-1/(K0*Kd);
% Simulink Simulation der zeitkontinuierlichen PLL (Aquisition)
stop=2.5e-3; % Simulationsende in Sekunden
%Open Simulink Model
open_system mod_track.mdl
% Parameters for Simulation
set_param('mod_track', 'StopTime', 'stop')
%start Simulation
sim Aufgabe5