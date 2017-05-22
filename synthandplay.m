function norm_sound = synthandplay(songfile_in, fs_in, justorwell_in, adsr_in, harmonics_in)
  % Synthesize and Play a song encoded in theVoices (see handout section 6.3)
  
  adsr = [0.2,0.25,0.4,0.15];
  harmonics = [2,4,6,8,10];
  justorwell = 1;
  fs = 11025;
  songfile = 'BWV847';
  % Set default values
  if nargin==1,
    songfile = songfile_in;
  elseif nargin==2,
    songfile = songfile_in;
    fs = fs_in;
  elseif nargin==3
    songfile = songfile_in;
    fs = fs_in;
    justorwell = justorwell_in;
  elseif nargin==4
    songfile = songfile_in;
    fs = fs_in;
    justorwell = justorwell_in;
    adsr = adsr_in;
  elseif nargin==5
    songfile = songfile_in;
    fs = fs_in;
    justorwell = justorwell_in;
    adsr = adsr_in;
    harmonics = harmonics_in;
  end

  %% Playback parameters
  bpm= 120;
  beats_per_second = bpm/60;
  seconds_per_beat = 1/beats_per_second;
  seconds_per_pulse = seconds_per_beat /4;
  samples_per_pulse = fs * seconds_per_pulse;

  %% Load Music file and find number of voices
  eval([' load' ' ''' songfile '.mat''']);
  number_of_voices = size(theVoices,2);

  %% Process theVoices to generate sinusoids
  %% 1. Find last pulse and total duration of piece
  for vloop = 1:number_of_voices,
    % find # of notes per voice
    number_of_notes(vloop) = length(theVoices(vloop).noteNumbers);
    if number_of_notes(vloop)>0
      last_pulse(vloop) = theVoices(vloop).startPulses(number_of_notes(vloop));
      last_duration(vloop) = theVoices(vloop).durations(number_of_notes(vloop));
    end
  end

  %% 2. Synthesize soundtrack one voice at a time (mono version)
  % Find size of vector to hold all notes
  soundtrack = zeros(1,ceil(max(last_pulse)*samples_per_pulse+max(last_duration)*samples_per_pulse)); 
  % Synthesize the notes, one voice at a time
  fprintf('synthesizing %d voices\n',number_of_voices);

  for vloop = 1:number_of_voices, % voices loop
    fprintf('voices %d\n',vloop);
    for nloop = 1:number_of_notes(vloop) % notes loop
    % Find duration
    duration = theVoices(vloop).durations(nloop) * seconds_per_pulse;
    % Generate waveform, include harmonics and ADSR
    if justorwell == 1
      music = key2notewt(1,theVoices(vloop).noteNumbers(nloop),duration,adsr,harmonics);
    else
      music = key2notejt(1,theVoices(vloop).noteNumbers(nloop),duration,adsr,harmonics);
    end
    % compute where to insert tone
    startIndex = floor(theVoices(vloop).startPulses(nloop)*samples_per_pulse);
    if startIndex == 0
      startIndex = 1;
    end
    % calculate where to end
    endIndex = startIndex+length(music)-1;
    % insert voices in soundtrack, in the right place
    soundtrack(startIndex:endIndex) = soundtrack(startIndex:endIndex)+music;
    end
  end % for number_of_voices
  fprintf('soundtrack done!\n')
   
   norm_sound = (soundtrack - min(soundtrack)) / ( max(soundtrack) - min(soundtrack) );
   % record sound to a WAV file
   %fprintf('recording sound to WAV\n')
   %audiowrite('BWV847-with-harmonics-adsr.wav', norm_sound, fs);
   %% Playback in speaker
   %soundsc( norm_sound, fs );
end