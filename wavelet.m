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
noisy_signal = awgn(y,15,'measured');

%% Denoise the signal
wname = 'sym4';
level = 5;
method = 'SURE';
fd = wdenoise(noisy_signal,level,'Wavelet',wname,'DenoisingMethod',method,'ThresholdRule','Soft','NoiseEstimate','LevelIndependent');


%% Plot the data
figure;
subplot(3,1,1);
plot(t,y);axis tight; grid on; title('Original Signal');
subplot(3,1,2);
plot(t,noisy_signal);axis tight; grid on; title('Noisy Signal');
subplot(3,1,3)
plot(t,fd);axis tight; grid on; title('Clean Noise')
