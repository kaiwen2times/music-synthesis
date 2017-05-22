%% CMPE480 - DSP Spring 2017
%% Sample Test script for beta/project 1
%% Author: Kaiwen Zheng
%% Composed: 3/20/2017

%% paramemters
fs=11025;
dur=1;
%% coscos
disp('testing coscos');
xx = coscos(320,440,fs,dur);
soundsc(xx,fs)
pause
%% syn_sin
  % single frequency
  disp('testing syn_sin 1 tone with correct duration');
  tstart=0;
  fk=440;  
  Xk=rand+j*rand;
  [xx,tt] = syn_sin(fk, Xk, fs, dur, tstart);
  soundsc(xx,fs)    
  pause
  % multiple frequencies
  fk=440*[1 3/4 4/5];
  Xk=rand(1,3).*exp(j*rand(1,3));
  [xx,tt] = syn_sin(fk, Xk, fs, dur, tstart);
  disp('testing syn_sin 3 tones...');
  for i=1:size(xx,1)
    soundsc(xx(i,:),fs)
  end
  pause
%% key2notewt
disp('testing well tempered keywnote with keynum=50');
keynum=50;
X =  exp(j*rand)
xx1 = key2notewt(X, keynum, dur);
soundsc(xx1,fs)
pause
disp('spectogram plot for well tempered tuning');
specgram(xx1,512,fs);
axis([0 2 200 1000]);
title('well tempered spectrogram')
xlabel('Time') % x-axis label
ylabel('Frequency') % y-axis label
disp('Done plotting for well tempered tuning');
pause    
%% key2notejt
disp('testing just tempered keywnote with keynum=50');
keynum=50;
X =  exp(j*rand)
xx2 = key2notejt(X, keynum, dur);
soundsc(xx2,fs)
pause
disp('spectogram plot for just tempered tuning');
specgram(xx2,512,fs);
axis([0 2 200 1000]);
title('well tempered spectrogram')
xlabel('Time') % x-axis label
ylabel('Frequency') % y-axis label
disp('Done plotting for just tempered tuning');
pause               
%% playscale
disp('testing play_scale using well tempered tuning');
RootNote=(50);
xx3 = play_scale(RootNote);
pause
disp('spectogram plot for play_scale');
specgram(xx3,512,fs);
axis([0 2 200 1000]);
title('well tempered spectrogram')
xlabel('Time') % x-axis label
ylabel('Frequency') % y-axis label
disp('Done plotting');