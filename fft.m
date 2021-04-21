% EGCP 371 Group Project - Denoising a signal using FFT

clc;
close all;
clear all;

% Read a signal from an audio file
[y,Fs] = audioread('audiotesting.wav');
info = audioinfo('audiotesting.wav');
sound(y,Fs);

% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

% Plot the wave of the audio file
figure(1)
plot(t,y)
xlabel('Time (t)')
ylabel('Audio Signal')
