% EGCP 371 Group Project - Denoising a signal using FFT

clc;
close all;
clear all;

% Read a signal from an audio file
[y,Fs] = audioread('audiotesting1.wav');
info = audioinfo('audiotesting1.wav');


% Play audio file
% sound(y,Fs);


% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);


% Add noise
noisy_signal = y + 0.2*randn(size(y));


% FFT of the original signal
L = length(t);
orig_Y = fft(y,L);
x_orig = (0:length(y)-1)*Fs/length(y);
P2_orig = abs(orig_Y);


% FFT of the noisy signal
Y_noisy = fft(noisy_signal,L);
x_noisy = (0:length(noisy_signal)-1)*Fs/length(noisy_signal);
P2_noisy = abs(Y_noisy);


% Filter out the noise
selector = P2_noisy > 700;
P2_clean = P2_noisy.*selector;
Y_clean = selector.*Y_noisy;
inv = ifft(Y_clean,L);


% Plots the wave of the audio file
subplot(4,2,1);
plot(t,y)
title('Signal of Original Audio')
xlabel('Time (t)')
ylabel('Audio Signal')


% Plots the wave of the clean audio
subplot(4,2,2);
plot(t,inv)
title('Signal of Original Audio')
xlabel('Time (t)')
ylabel('Audio Signal')


% Plots the noisy signal
subplot(4,2,3);
plot(t,noisy_signal)
title('Signal of Noisy Audio')
xlabel('Time (t)')
ylabel('Audio Signal')


% Plots the amplitude spectrum of the original signal
subplot(4,2,5);
plot(x_orig,P2_orig) 
title('Amplitude Spectrum of Original Audio')
xlabel('f (Hz)')
ylabel('Amplitude')


% Plots the amplitude spectrum of the clean signal
subplot(4,2,6);
plot(x_orig,P2_clean) 
title('Amplitude Spectrum of Original Audio')
xlabel('f (Hz)')
ylabel('Amplitude')


% Plots the amplitude spectrum of the noisy signal
subplot(4,2,7);
plot(x_noisy,P2_noisy) 
title('Amplitude Spectrum of Noisy Audio')
xlabel('f (Hz)')
ylabel('Amplitude')
