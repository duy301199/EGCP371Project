% EGCP 371 Group Project - Denoising a signal using Wavelets

clc;
close all;
clear all;

%% Read a signal from an audio file
[y,Fs] = audioread('audiotesting1.wav');
info = audioinfo('audiotesting1.wav');


%% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);


%% Add noise
noisy_signal = awgn(y,12,'measured');


%% Parameters
method = 'Sure'; % Denoising Method: Bayes, BlockJS, FDR, Minimax, Sure, or UniversalThreshold
wname = 'sym8'; % Name of Wavelet: haar, dbN, fkN, coifN, or symN where N is a positive integer
level = 5; % Keep this at 5
rule = 'Soft'; % Threshold Rule(depends on denoising method): BlockJS(James-Stein); Sure,Minimax,UniversaldThreshold(Soft or Hard); Bayes(Median, Mean, Soft, or Hard); FDR(Hard)

%% Decompose noisy signal using Discrete Wavelet Transform
dwtmode('per','nodisplay');
[C, L] = wavedec(noisy_signal,level,wname);
%approx = appcoef(C,L,wname);
%[cd1,cd2,cd3,cd4,cd5] = detcoef(C,L,[1 2 3 4 5]);
approx = wrcoef('a',C,L,wname,level);
cd5 = wrcoef('d',C,L,wname,level);
cd4 = wrcoef('d',C,L,wname,4);
cd3 = wrcoef('d',C,L,wname,3);
cd2 = wrcoef('d',C,L,wname,2);
cd1 = wrcoef('d',C,L,wname,1);

% Plot graphs
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
%approx1 = appcoef(C1,L1,wname);
%[cd6,cd7,cd8,cd9,cd10] = detcoef(C1,L1,[1 2 3 4 5]);
approx1 = wrcoef('a',C1,L1,wname,level);
cd10 = wrcoef('d',C1,L1,wname,level);
cd9 = wrcoef('d',C1,L1,wname,4);
cd8 = wrcoef('d',C1,L1,wname,3);
cd7 = wrcoef('d',C1,L1,wname,2);
cd6 = wrcoef('d',C1,L1,wname,1);


% Plot graphs
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
%approx2 = appcoef(C2,L2,wname);
%[cd11,cd12,cd13,cd14,cd15] = detcoef(C2,L2,[1 2 3 4 5]);
approx2 = wrcoef('a',C2,L2,wname,level);
cd15 = wrcoef('d',C2,L2,wname,level);
cd14 = wrcoef('d',C2,L2,wname,4);
cd13 = wrcoef('d',C2,L2,wname,3);
cd12 = wrcoef('d',C2,L2,wname,2);
cd11 = wrcoef('d',C2,L2,wname,1);


% Zero out the small coefficients
%index1_p = cd11>0.01; index1_p_clean = cd11.*index1_p;
%index1_n = cd11<-0.01; index1_n_clean = cd11.*index1_n;
%index1 = index1_p_clean + index1_n_clean;

%index2_p = cd12>0.025; index2_p_clean = cd12.*index2_p;
%index2_n = cd12<-0.025; index2_n_clean = cd12.*index2_n;
%index2 = index2_p_clean + index2_n_clean;

%index3_p = cd13>0.03; index3_p_clean = cd13.*index3_p;
%index3_n = cd13<-0.03; index3_n_clean = cd13.*index3_n;
%index3 = index3_p_clean + index3_n_clean;

%index4_p = cd14>0.02; index4_p_clean = cd14.*index4_p;
%index4_n = cd14<-0.02; index4_n_clean = cd14.*index4_n;
%index4 = index4_p_clean + index4_n_clean;

%index5_p = cd15>0.016; index5_p_clean = cd15.*index5_p;
%index5_n = cd15<-0.016; index5_n_clean = cd15.*index5_n;
%index5 = index5_p_clean + index5_n_clean;


% Recreate the clean signal
%fd = approx2 + index1 + index2 + index3 + index4 + index5;


% Plot graphs
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
