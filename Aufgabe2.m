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

fftRate=size(tonspur,1);
spektrum =fft(tonspur,fftRate)/fftRate;


%Plot Spektrum
figure(2)
fMax=20000;
fAchse=linspace(0,fMax,fftRate/2+1);
plot(fAchse,abs(spektrum(1:fftRate/2+1))); % Plot Amplitudenspektrum

%% Filtern und Rücktransformieren



% bandbreite=100;
% [M,I]=max(abs(spektrum(:,1)))
% st=I-bandbreite:1:I+bandbreite;
% spektrum(st,:)=0;

% anfang=mean(abs(spektrum(:,1)))    
% while (mean(abs(spektrum(:,1))) > 0.000005)
%     bandbreite=200;
%     [M,I]=max(abs(spektrum));
%     st=I-bandbreite:1:I+bandbreite;
%     spektrum(st,:)=0;   
% end
% ende=mean(abs(spektrum(:,1)))


figure(3);
plot(fAchse,abs(spektrum(1:fftRate/2+1))); % Plot Amplitudenspektrum



%IFFT
tonNeu=ifft(spektrum,fftRate)*fftRate;

%% Testsection





%% Tonspur abspielen

sound(tonNeu,abtastrate);

