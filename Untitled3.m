clc;
close all;
clear all;


[y,fs] = audioread('audiotesting.wav');
sound(y,fs);
