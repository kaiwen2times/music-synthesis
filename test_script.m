%% CMPE480 - DSP Spring 2017
%% Sample Test script for project 1
%% Author: Kaiwen Zheng
%% Composed: 3/20/2017

%% paramemters
songfile = 'BWV847';
adsr = [0.2,0.25,0.4,0.15];
harmonics = [2,4,6,8,10];
justorwell = 1;
fs = 11025;
description = '_final_product.wav';

disp('testing synthandplay');
soundtrack = synthandplay(songfile, fs, justorwell, adsr, harmonics);

% record sound to a WAV file
%fprintf('recording sound to WAV\n')
%audiowrite([songfile description], soundtrack, fs);
%% Playback in speaker
soundsc( soundtrack, fs );