%Matlab-Projekt Aufgabe 2

%{
    Autor: Marcel Grandinetti
    Datum:02.08.2017
    Beschribung:    Einlesen einer Audiodatei, umwandeln in das Spektrum,
                    Störfrequenzen dedektieren und automatisch rausfiltern.
                    Anschließend rücktransformieren und ausgeben der
                    gefilterten Datei.
%}
clear


%% Einlesen und Transformieren

%Audiodatei einlesen
[tonspur,abtastrate]=audioread('Aufgabe2.wav');

%Signallänge berechnen
signallaenge=size(tonspur,1)/abtastrate;        

% Darstellen des Audiosignals im Zeitbereich
tSigPlot=0:1/abtastrate:signallaenge-1/abtastrate;
subplot(3,1,1);
plot(tSigPlot,tonspur);
title('Audiosignal im Zeitbereich');
xlabel('Zeit (s)');
ylabel('Y(t)');

%FFT
fftRate=size(tonspur,1);
spektrum =fft(tonspur,fftRate)/fftRate;

%Plot detektierte Peaks
subplot(3,1,2);
fAchse=linspace(0,20000,size(spektrum,1)/2);
spektrumPeaks=fftshift(spektrum);
spektrumPeaks=spektrumPeaks((size(spektrum,1)/2)+1:size(spektrum,1),:);
plot(fAchse,abs(spektrumPeaks)); % Plot Amplitudenspektrum
findpeaks(abs(spektrumPeaks(:,1)),fAchse,'Threshold',1e-3);
title('Spektrum mit dedektierten Peaks');
xlabel('Frequenz (Hz)');
ylabel('|Y(f)|');

%Peaks ausgeben
[pks,locs,mittlereBreite,p] = findpeaks(abs(spektrumPeaks(:,1)),fAchse,'Threshold',1e-3);
disp('Störfrequenzen:')
round(locs)


%% Filtern

%Spektrum in Imaginär- und Realteil aufteilen
spektrumReal=real(spektrum);
spektrumImag=imag(spektrum);

%Frequenzen
f=linspace(0,size(spektrum,1),size(spektrum,1));

%Filtern reales Spektrum
[pks,locs,mittlereBreite,p] = findpeaks(abs(spektrumReal(:,1)),f,'Threshold',1e-3);
locs=int32(locs);
 for x = 1:size(locs,2)
     bandbreite=int32(mittlereBreite(x)*150);
     st=locs(x)-bandbreite:1:locs(x)+bandbreite;
     spektrumReal(st,:)=0;
 end

%Filtern imaginäres Spektrum
[pks,locs,mittlereBreite,p] = findpeaks(abs(spektrumImag(:,1)),f,'Threshold',1e-3);
locs=int32(locs);
 for x = 1:size(locs,2)
     bandbreite=int32(mittlereBreite(x)*150);
     st=locs(x)-bandbreite:1:locs(x)+bandbreite;
     spektrumImag(st,:)=0;
 end

%Komplexes Spektrum wieder zusammensetzen
spektrumZsm=complex(spektrumReal,spektrumImag);

%Plot Spektrum nach dem Filtern
subplot(3,1,3);
spektrumPlot=fftshift(spektrumZsm);
spektrumPlot=spektrumPlot((size(spektrum,1)/2)+1:size(spektrum,1));
plot(fAchse,abs(spektrumPlot)); 
title('Spektrum gefiltert');
xlabel('Frequenz (Hz)');
ylabel('|Y(f)|');


%% Rücktransformieren, abspielen & speichern

%IFFT
tonNeu=real(ifft(spektrumZsm,fftRate)*fftRate);

%Abspielen
sound(tonNeu,abtastrate);

%Speichern
audiowrite('Aufgabe2Entstoert.wav',tonNeu,abtastrate);