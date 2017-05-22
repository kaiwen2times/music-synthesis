function [xx,tt] = syn_sin(fk, Xk, fs, dur, tstart)
  % SYN_SIN Function to synthesize a sum of cosine waves
  % usage:
  % [xx,tt] = syn_sin(fk, Xk, fs, dur, tstart)
  % fk = vector of frequencies
  % (these could be negative or positive)
  % Xk = vector of complex amplitudes: Amp*e^(j*phase)
  % fs = the number of samples per second for the time axis
  % dur = total time duration of the signal
  % tstart = starting time (default is zero, if you make this input optional)
  % xx = vector of sinusoidal values
  % tt = vector of times, for the time axis
  %
  % Note: fk and Xk must be the same length.
  % Xk(1) corresponds to frequency fk(1),
  % Xk(2) corresponds to frequency fk(2), etc.
  fkl = length(fk);
  Xkl = length(Xk);
  if fkl == Xkl
    %proceed to calculation
    tt = tstart:(1/fs):dur;
    xx = [];
    % make sure duration is greater than 0
    if length(tt) > 1
        for i = 1:fkl
            xx = [xx, real(Xk(i)*exp(j*2*pi*fk(i).*tt))];
        end
    else
        fprintf('Duration has to be longer that start time!\n')
    end
  else
    fprintf('frequency vector has size %d while ampplitude vector has size %d\n',fkl,Xkl)
  end
end