% EGCP 371 Group Project - Denoising a signal using FFT

clc;
close all;
clear all;

% Read a signal from an audio file
[y,Fs] = audioread('audiotesting.wav');
info = audioinfo('audiotesting.wav');

% Play
sound(y,Fs);

% Create a t vector that is as long as the duration of the audio file
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

% Add noise
noisy_signal = y + 0.5*randn(size(y));

% FFT of the original signal
L = length(t);
orig_Y = fft(y,L);
P2_orig = abs(orig_Y/L);
P1_orig = P2_orig(1:L/2+1);
P1_orig(2:end-1) = 2*P1_orig(2:end-1);
f_orig = Fs*(0:(L/2))/L;

% FFT of the noisy signal
noisy_Y = fft(noisy_signal,L);
P2_noisy = abs(noisy_Y/L);
P1_noisy = P2_noisy(1:L/2+1);
P1_noisy(2:end-1) = 2*P1_noisy(2:end-1);
f_noisy = Fs*(0:(L/2))/L;

% Plots the wave of the audio file
subplot(4,1,1);
plot(t,y)
title('Signal of Original Audio')
xlabel('Time (t)')
ylabel('Audio Signal')

% Plots the noisy signal
subplot(4,1,2);
plot(t,noisy_signal)
title('Signal of Noisy Audio')
xlabel('Time (t)')
ylabel('Audio Signal')

% Plots the amplitude spectrum of the original signal
subplot(4,1,3);
plot(f_orig,P1_orig) 
title('Single-Sided Amplitude Spectrum of Original Audio')
xlabel('f (Hz)')
ylabel('Amplitude')

% Plots the amplitude spectrum of the noisy signal
subplot(4,1,4);
plot(f_noisy,P1_noisy) 
title('Single-Sided Amplitude Spectrum of Noisy Audio')
xlabel('f (Hz)')
ylabel('Amplitude')
