% EGCP 371 Group Project - Denoising a signal using Wavelets

clc;
close all;
clear all;

%% Read a signal from an audio file
[y,Fs] = audioread('Rockm.wav');
info = audioinfo('Rockm.wav');


%% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);


%% Add noise
noisy_signal = awgn(y,20);


%% Denoise the signal
fd = wdenoise(noisy_signal,5,'Wavelet','sym4');

figure;
subplot(2,1,1);
plot(t,noisy_signal);axis tight; grid on; title('Noisy Signal');
subplot(2,1,2)
plot(fd);axis tight; grid on;

%% Play audio
% sound(fd,Fs);
