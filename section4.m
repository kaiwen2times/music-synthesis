% section 4 questions
fs = 11025;
tt = 0:(1/fs):0.5;
% first wave
a1 = 100;
w1 = 2*pi*800;
x1 = zeros(1,length(tt));
phase1 = -pi/3;
for i=1:length(tt)
  x1(i) = a1*cos(w1*tt(i)+phase1);
end
soundsc(x1,fs);

% second wave
a2 = 80;
w2 = 2*pi*1200;
x2 = zeros(1,length(tt));
phase2 = pi/4;
for i=1:length(tt)
  x2(i) = a2*cos(w2*tt(i)+phase2);
end
soundsc(x2,fs);

% concatenate both waves
xx = [x1, zeros(1,.1*fs), x2];
soundsc(xx,fs);

%plot wave
tt = (1/fs)*(1:length(xx));
plot( tt, xx );
title('Graph of concatenated wave')
xlabel('Time(s)') % x-axis label
ylabel('Amplitude') % y-axis label

%higher fs for soundsc
soundsc(xx, fs*2)