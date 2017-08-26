%Matlab-Projekt Aufgabe 2

%{
    Autor: Marcel Grandinetti
    Datum:01.08.2017
    Beschribung:    
                    For-Schleife da vector mit den orten der Peaks aber
                    keine möglichkeit bereiche dahinzu zu fügen
%}
clear

%% Einlesen

[tonspur,abtastrate]=audioread('Aufgabe2.wav');
signallaenge=size(tonspur,1)/abtastrate;        

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

%Spektrum in Imaginär- und Realteil aufteilen
spektrumReal=real(spektrum);
spektrumImag=imag(spektrum);

%Frequenzachse
f=linspace(0,size(spektrum,1),size(spektrum,1));

%Plot reales Spektrum
subplot(2,2,1);
plot(f,spektrumReal); % Plot Amplitudenspektrum
findpeaks(abs(spektrumReal(:,1)),f,'Threshold',1e-3);
title('Realteil ungefiltert');

%Plot imaginäres Spektrum
subplot(2,2,2);
plot(f,spektrumImag);
findpeaks(abs(spektrumImag(:,1)),f,'Threshold',1e-3);
title('Imaginärteil ungefiltert');

%Filtern reales Spektrum
[pks,locs,w,p] = findpeaks(abs(spektrumReal(:,1)),f,'Threshold',1e-3);
locs=int32(locs);
 for x = 1:size(locs,2)
     bandbreite=int32(w(x)*150);
     st=locs(x)-bandbreite:1:locs(x)+bandbreite;
     spektrumReal(st,:)=0;
 end

%Filtern imaginäres Spektrum
[pks,locs,w,p] = findpeaks(abs(spektrumImag(:,1)),f,'Threshold',1e-3);
locs=int32(locs);
 for x = 1:size(locs,2)
     bandbreite=int32(w(x)*150);
     st=locs(x)-bandbreite:1:locs(x)+bandbreite;
     spektrumImag(st,:)=0;
 end

%Plot reales Spektrum nach dem Filtern
subplot(2,2,3);
plot(f,spektrumReal); 
title('Realteil gefiltert');

%Plot imaginäres Spektrum nach dem Filtern
subplot(2,2,4);
plot(f,spektrumImag);
title('Imaginärteil gefiltert');

%Komplexes Spektrum wieder zusammensetzen
spektrumZsm=complex(spektrumReal,spektrumImag);

%IFFT
tonNeu=real(ifft(spektrumZsm,fftRate)*fftRate);




%% Tonspur abspielen


sound(tonNeu,abtastrate);
%audiowrite('EntstoertA2.mp3',tonNeu,abtastrate);
