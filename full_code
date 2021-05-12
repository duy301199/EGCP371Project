%%EGCP371-Group 2 Matlab Code
clc;
close all;
clear all;

% Read a signal from an audio file
a = 'Rockm.wav';
b = 'trapPiano.wav';
c = 'StarWars60.wav';
d = 'Concerto.wav';

%Display the menu of choices
choice = menu('Choose an option for type of song','a. Rock','b. Trap','c. StarWar','d. Concerto');

%If the audience wants to choose Rock music
if (choice == 1)
    [y,Fs] = audioread('Rockm.wav');
    info = audioinfo('Rockm.wav');
a = 'Original Rock ';

%If the audience wants to choose Trap music
elseif (choice == 2)
    [y,Fs] = audioread('trapPiano.wav'); 
    info = audioinfo('trapPiano.wav');
 a = 'Original Trap Piano ';

%If the audience wants to choose StarWar music
elseif (choice == 3)
    [y,Fs] = audioread('StarWars60.wav'); 
    info = audioinfo('StarWars60.wav');
    	 a = 'Original Star War ';
     

%If the audience wants to choose Concerto music  
elseif (choice == 4)
    [y,Fs] = audioread('Concerto.wav'); 
    info = audioinfo('Concerto.wav');
 	 a = 'Original Concerto ';
end

%Use this to play the audio signal
%%sound(y,Fs); 

%Program then send the chosen audio file to FFT to display signals.

% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);


%% Convert 2D audio to 1D audio(so that we can use wavelet analysis on it)
size = numel(t);
y = y(1:size);

%FFT of the original signal
L = length(t);
yFFT = fft(y);
P2_orig = abs(yFFT/L);
P1_orig = P2_orig(1:L/2+1);
P1_orig(2:end-1) = 2*P1_orig(2:end-1);
f = Fs*(0:(L/2))/L;

%Plots the wave of the audio file
figure(1);
plot(t,y)
title(['Signal of ',num2str(a),'Music'])
xlabel('Time (t)')
ylabel('Audio Signal')
grid on

%Plots the amplitude spectrum of the original signal
figure(2);
plot(f,P1_orig ) 
title(['Amplitude Spectrum of ',num2str(a),'Music'])
xlabel('f (Hz)')
ylabel('Amplitude')
grid on

%add white gaussian noise to a signal
%awgn(original signal, SNR, signal Power)
noisy_signal = awgn(y,5,'measured');
%%Play the noise if you want to see how much was added 
%%sound(noisy_signal,Fs)

plot(t,noisy_signal);
title(['Noisy Signal of  ',num2str(a),'Music'])
xlabel('Time (t)')
ylabel('Audio Signal')
grid on


%% Create audio file of noisy signal
filename = 'noisy_audio1.wav';
audiowrite(filename,noisy_signal,Fs);


%% Parameters
method = 'Sure'; % Denoising Method: Bayes, BlockJS, FDR, Minimax, Sure, or UniversalThreshold
wname = 'sym8'; % Name of Wavelet: haar, dbN, fkN, coifN, or symN where N is a positive integer
level = 5; % Keep this at 5
rule = 'Soft'; % Threshold Rule(depends on denoising method): BlockJS(James-Stein); Sure,Minimax,Universal Threshold(Soft or Hard); Bayes(Median, Mean, Soft, or Hard); FDR(Hard)

%% Decompose noisy signal using Discrete Wavelet Transform
dwtmode('per','nodisplay');
[C, L] = wavedec(noisy_signal,level,wname);
approx = wrcoef('a',C,L,wname,level);
cd5 = wrcoef('d',C,L,wname,level);
cd4 = wrcoef('d',C,L,wname,4);
cd3 = wrcoef('d',C,L,wname,3);
cd2 = wrcoef('d',C,L,wname,2);
cd1 = wrcoef('d',C,L,wname,1);

% Plot graphs of noisy signal
figure(3);
subplot(6,3,1)
plot(approx)
title('Noisy Approximation Coefficients')
subplot(6,3,4)
plot(cd5)
title('Level 5 Detail Coefficients')
subplot(6,3,7)
plot(cd4)
title('Level 4 Detail Coefficients')
subplot(6,3,10)
plot(cd3)
title('Level 3 Detail Coefficients')
subplot(6,3,13)
plot(cd2)
title('Level 2 Detail Coefficients')
subplot(6,3,16)
plot(cd1)
title('Level 1 Detail Coefficients')

%% Decompose original signal
[C1, L1] = wavedec(y,level,wname);
approx1 = wrcoef('a',C1,L1,wname,level);
cd10 = wrcoef('d',C1,L1,wname,level);
cd9 = wrcoef('d',C1,L1,wname,4);
cd8 = wrcoef('d',C1,L1,wname,3);
cd7 = wrcoef('d',C1,L1,wname,2);
cd6 = wrcoef('d',C1,L1,wname,1);


% Plot graphs of original signal
subplot(6,3,2)
plot(approx1)
title('Original Approximation Coefficients')
subplot(6,3,5)
plot(cd10)
title('Level 5 Detail Coefficients')
subplot(6,3,8)
plot(cd9)
title('Level 4 Detail Coefficients')
subplot(6,3,11)
plot(cd8)
title('Level 3 Detail Coefficients')
subplot(6,3,14)
plot(cd7)
title('Level 2 Detail Coefficients')
subplot(6,3,17)
plot(cd6)
title('Level 1 Detail Coefficients')


%% Denoise the signal and decompose
fd = wdenoise(noisy_signal,level,'Wavelet',wname,'DenoisingMethod',method,'ThresholdRule',rule,'NoiseEstimate','LevelIndependent');
[C2, L2] = wavedec(fd,level,wname);
approx2 = wrcoef('a',C2,L2,wname,level);
cd15 = wrcoef('d',C2,L2,wname,level);
cd14 = wrcoef('d',C2,L2,wname,4);
cd13 = wrcoef('d',C2,L2,wname,3);
cd12 = wrcoef('d',C2,L2,wname,2);
cd11 = wrcoef('d',C2,L2,wname,1);


%% Create audio file of clean signal
filename = 'clean_audio1.wav';
audiowrite(filename,fd,Fs);


%% Plot graphs of clean signal
subplot(6,3,3)
plot(approx2)
title('Clean Approximation Coefficients')
subplot(6,3,6)
plot(cd15)
title('Level 5 Detail Coefficients')
subplot(6,3,9)
plot(cd14)
title('Level 4 Detail Coefficients')
subplot(6,3,12)
plot(cd13)
title('Level 3 Detail Coefficients')
subplot(6,3,15)
plot(cd12)
title('Level 2 Detail Coefficients')
subplot(6,3,18)
plot(cd11)
title('Level 1 Detail Coefficients')


