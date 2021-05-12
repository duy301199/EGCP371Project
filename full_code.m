%%EGCP371-Group 2 Matlab Code
clc;
close all;
clear all;

% Read a signal from an audio file
a = 'Rockm.wav';
b = 'trapPiano.wav';
c = 'StarWars60.wav';
d = 'Concerto.wav';

% Display the menu of choices
choice = menu('Choose an option for type of song','a. Rock','b. Trap','c. StarWar','d. Concerto');

% If the audience wants to choose Rock music
if (choice == 1)
    [y,Fs] = audioread('Rockm.wav');
    info = audioinfo('Rockm.wav');
a = 'Original Rock ';

% If the audience wants to choose Trap music
elseif (choice == 2)
    [y,Fs] = audioread('trapPiano.wav'); 
    info = audioinfo('trapPiano.wav');
 a = 'Original Trap Piano ';

% If the audience wants to choose StarWar music
elseif (choice == 3)
    [y,Fs] = audioread('StarWars60.wav'); 
    info = audioinfo('StarWars60.wav');
    	 a = 'Original Star War ';
     

% If the audience wants to choose Concerto music  
elseif (choice == 4)
    [y,Fs] = audioread('Concerto.wav'); 
    info = audioinfo('Concerto.wav');
 	 a = 'Original Concerto ';
end


% Add white gaussian noise to a signal
%awgn(original signal, SNR, signal Power)
noisy_signal = awgn(y,5,'measured');

% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);


%% Convert 2D audio to 1D audio(so that we can use wavelet analysis on it)
size = numel(t);
y = y(1:size);


% Program then send the chosen audio file to FFT to display signals.

%% FFT
% FFT of the original signal
L = length(t);
yFFT = fft(y);
P2_orig = abs(yFFT/L);
P1_orig = P2_orig(1:L/2+1);
P1_orig(2:end-1) = 2*P1_orig(2:end-1);
f = Fs*(0:(L/2))/L;


% FFT of the noisy signal
noisyFFT = fft(noisy_signal);
P2_noisy = abs(noisyFFT/L);
P1_noisy = P2_noisy(1:L/2+1);
P1_noisy(2:end-1) = 2*P1_noisy(2:end-1);

% This helps graph the cleaned signal
P2_noisy2 = abs(noisyFFT);


%% Filter out the noise
threshold = 0.003; % Threshold choices which signals to remove
threshold = threshold * 100000;
selector = P2_noisy2 > threshold; % Anything below the threshold is removed
P2_clean = P2_noisy2.*selector;
Y_clean = selector.*noisyFFT;
inv = ifft(Y_clean,L);

P1_clean = P2_clean(1:L/2+1);
P1_clean(2:end-1) = 2*P1_clean(2:end-1);

%% Plots
% Plots the wave of the audio file
subplot(3,2,1);
plot(t,y)
title('Signal of Original Audio')
xlabel('Time (t)')
ylabel('Audio Signal')
grid on


% Plots the noisy signal
subplot(3,2,3);
plot(t,noisy_signal)
title('Signal of Noisy Audio')
xlabel('Time (t)')
ylabel('Audio Signal')
grid on


% Plots the wave of the clean audio
subplot(3,2,5);
plot(t,inv)
title('Signal of Clean Audio')
xlabel('Time (t)')
ylabel('Audio Signal')
grid on


% Plots the amplitude spectrum of the original signal
subplot(3,2,2);
plot(f,P1_orig) 
title('Amplitude Spectrum of Original Audio')
xlabel('f (Hz)')
ylabel('Amplitude')
grid on


% Plots the amplitude spectrum of the noisy signal
subplot(3,2,4);
plot(f,P1_noisy) 
title('Amplitude Spectrum of Noisy Audio')
xlabel('f (Hz)')
ylabel('Amplitude')
grid on


% Plots the amplitude spectrum of the clean signal
subplot(3,2,6);
plot(f,P1_clean) 
title('Amplitude Spectrum of Clean Audio')
xlabel('f (Hz)')
ylabel('Amplitude')
grid on


%% WAVELET TRANSFORM
% Parameters
method = 'Sure'; % Denoising Method: Bayes, BlockJS, FDR, Minimax, Sure, or UniversalThreshold
wname = 'sym8'; % Name of Wavelet: haar, dbN, fkN, coifN, or symN where N is a positive integer
level = 5; % Keep this at 5
rule = 'Soft'; % Threshold Rule(depends on denoising method): BlockJS(James-Stein); Sure,Minimax,Universal Threshold(Soft or Hard); Bayes(Median, Mean, Soft, or Hard); FDR(Hard)


%% Decompose original signal
[C1, L1] = wavedec(y,level,wname);
approx1 = wrcoef('a',C1,L1,wname,level);
cd10 = wrcoef('d',C1,L1,wname,level);
cd9 = wrcoef('d',C1,L1,wname,4);
cd8 = wrcoef('d',C1,L1,wname,3);
cd7 = wrcoef('d',C1,L1,wname,2);
cd6 = wrcoef('d',C1,L1,wname,1);


% Plot graphs of original signal
figure(2);
subplot(6,3,1)
plot(approx1)
title('Original Approximation Coefficients')
subplot(6,3,4)
plot(cd10)
title('Level 5 Detail Coefficients')
subplot(6,3,7)
plot(cd9)
title('Level 4 Detail Coefficients')
subplot(6,3,10)
plot(cd8)
title('Level 3 Detail Coefficients')
subplot(6,3,13)
plot(cd7)
title('Level 2 Detail Coefficients')
subplot(6,3,16)
plot(cd6)
title('Level 1 Detail Coefficients')


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
subplot(6,3,2)
plot(approx)
title('Noisy Approximation Coefficients')
subplot(6,3,5)
plot(cd5)
title('Level 5 Detail Coefficients')
subplot(6,3,8)
plot(cd4)
title('Level 4 Detail Coefficients')
subplot(6,3,11)
plot(cd3)
title('Level 3 Detail Coefficients')
subplot(6,3,14)
plot(cd2)
title('Level 2 Detail Coefficients')
subplot(6,3,17)
plot(cd1)
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

