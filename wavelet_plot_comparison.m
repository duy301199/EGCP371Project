% EGCP 371 Group Project - Denoising a signal using Wavelets

clc;
close all;
clear all;

%% Read a signal from an audio file
[y,Fs] = audioread('audiotesting.wav');
info = audioinfo('audiotesting.wav');


%% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);


%% Add noise
noisy_signal = awgn(y,20,'measured');


%% Parameters
method = 'FDR'; % Denoising Method: Bayes, BlockJS, FDR, Minimax, Sure, or UniversalThreshold
wname = 'sym4'; % Name of Wavelet: haar, dbN, fkN, coifN, or symN where N is a positive integer
level = 5; % Keep this at 5
rule = 'Hard'; % Threshold Rule(depends on denoising method): BlockJS(James-Stein); Sure,Minimax,UniversaldThreshold(Soft or Hard); Bayes(Median, Mean, Soft, or Hard); FDR(Hard)

  
%% Decompose noisy signal using Discrete Wavelet Transform
dwtmode('per','nodisplay');
[C, L] = wavedec(noisy_signal,level,wname);
approx = appcoef(C,L,wname);
[cd1,cd2,cd3,cd4,cd5] = detcoef(C,L,[1 2 3 4 5]);

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
approx1 = appcoef(C1,L1,wname);
[cd6,cd7,cd8,cd9,cd10] = detcoef(C1,L1,[1 2 3 4 5]);

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
approx2 = appcoef(C2,L2,wname);
[cd11,cd12,cd13,cd14,cd15] = detcoef(C2,L2,[1 2 3 4 5]);

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
