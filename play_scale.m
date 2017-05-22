% PLAY_SCALE Function to play a major scale with root in RootNote
% usage: play_scale % Plays C major (Middle-C)
% play_scale(RootNote)
% Note: key #40 is middle-C
function xx = play_scale(RootNote)
  if nargin==0
    RootNote = 40; % Default is C major
  end
  scale.keys = RootNote + [0 2 4 5 7 9 11 12];

  scale.durations = 0.25 * ones(1,length(scale.keys));
  fs = 11025; % or 8000 Hz
  xx = zeros(1, sum(scale.durations)*fs+length(scale.keys) );
  n1 = 1;
  for kk = 1:length(scale.keys)
    keynum = scale.keys(kk);
    % play with well tempered tuning
    tone = key2notewt(1, keynum, scale.durations(kk));
    n2 = n1 + length(tone) - 1;
    xx(n1:n2) = xx(n1:n2) + tone;
    n1 = n2 + 1;
  end
  soundsc( xx, fs );
end