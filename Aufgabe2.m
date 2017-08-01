%Matlab-Projekt Aufgabe 2

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    
%}
clear

%% Einlesen

abtastrate=44100;                               %Hz
%aufloesung=16;                                 %Bit
[tonspur,abtastrate]=audioread('Aufgabe5.wav');
signallaenge=size(tonspur,1)/abtastrate;        %30sec

tSigPlot=0:1/abtastrate:signallaenge-1/abtastrate;
figure(1);
plot(tSigPlot,tonspur);

%% FFT
fMax=20000;
spektrum=fftshift(fft(tonspur,abtastrate)/abtastrate);

fSchritte=fMax/size(spektrum,1);
fAchse=0:fSchritte:fMax-fSchritte;
figure(2);
plot(fAchse,abs(spektrum));


%% Testsection



%% Tonspur abspielen

sound(tonspur,abtastrate);