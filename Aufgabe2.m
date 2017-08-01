%Matlab-Projekt Aufgabe 2

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    
%}
clear

%% Einlesen

[tonspur,abtastrate]=audioread('Aufgabe2.wav');
signallaenge=size(tonspur,1)/abtastrate;        %30sec

tSigPlot=0:1/abtastrate:signallaenge-1/abtastrate;
figure(1);
plot(tSigPlot,tonspur);

%% FFT







fftRate = 2^nextpow2(abtastrate); % nextpow2 = next higher power of 2

spektrum =fft(tonspur,fftRate)/fftRate;

figure(2)
fMax=20000;
fAchse=linspace(0,fMax,fftRate/2+1);
plot(fAchse,spektrum(1:fftRate/2+1)); % Plot Amplitudenspektrum







spektrum(find(spektrum==(0.0158 + 0.0983i)))=0;
figure(3);
plot(fAchse,abs(spektrum(1:fftRate/2+1))); % Plot Amplitudenspektrum


%% Testsection



%% Tonspur abspielen

sound(tonspur,abtastrate);