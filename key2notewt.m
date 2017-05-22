function xx = key2notewt(X, keynum, dur, adsr, harmonics)
  % KEY2NOTEWT Produce a sinusoidal waveform corresponding to a
  % given piano key number in the well-tempered tuning
  %
  % usage: xx = key2note (X, keynum, dur)
  %
  % xx = the output sinusoidal waveform
  % X = complex amplitude for the sinusoid, X = A*exp(j*phi).
  % keynum = the piano keyboard number of the desired note
  % dur = the duration (in seconds) of the output note
  %
  fs = 11025; % or use 8000 Hz
  tt = 0:(1/fs):dur;
  a440 = 49;  % A440 key
  
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
    freq = 440*2^((keynum - a440)/12);
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