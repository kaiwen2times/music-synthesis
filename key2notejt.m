function xx = key2notejt(X, keynum, dur, adsr, harmonics)
  % KEY2NOTEJT Produce a sinusoidal waveform corresponding to a
  % given piano key number in the just-tempered tuning
  %
  % usage: xx = key2notejt (X, keynum, dur)
  %
  % xx = the output sinusoidal waveform
  % X = complex amplitude for the sinusoid, X = A*exp(j*phi).
  % keynum = the piano keyboard number of the desired note
  % dur = the duration (in seconds) of the output note
  %
  c4 = 40;  % base on C4
  c4f = 261.63; % C4 frequency
  major = [1, 25/24, 9/8, 6/5, 5/4, 4/3, 45/32, 3/2, 25/16, 5/3, 9/5, 15/8];
  fs = 11025; % or use 8000 Hz
  tt = 0:(1/fs):dur;
  
  if ~isempty(adsr)
    % ADSR computation
    stageDurations = adsr * dur;
    % calculate duration for each stage in samples
    attack = round(stageDurations(1)*fs);
    delay = round(stageDurations(2)*fs);
    sustain = round(stageDurations(3)*fs);
    release = length(tt)-attack-delay-sustain;
    %calculate envlope
    envelope = [linspace(0,1,attack),linspace(1,0.6,delay),linspace(0.6,0.6,sustain),linspace(0.6,0,release)];
  end
  
  if length(tt) > 1
    % calculate which octave the key is in
    octavenum = floor((keynum-40)/12)+4;
    % calculate the position in major array
    pos = mod(1+keynum-(4+(octavenum-1)*12), 12);
    if eq(pos,0)
      pos = 12;
    end
    freq = c4f*(2^(octavenum - 4))*major(pos);
    xx = real( X*exp(j*2*pi*freq*tt) );
    % apply ADSR
    if ~isempty(adsr)
      xx = xx .*envelope;
    end
    % apply harmonics
    if ~isempty(harmonics)
      % calculate harmonics
      amp = 1 ./harmonics;
      for i=1:length(harmonics)
        xx = xx + real( amp(i)*exp(j*2*pi*freq*harmonics(i)*tt) );
      end
    end 
  else
    fprintf('Duration must be greater than 0!\n')
  end
end