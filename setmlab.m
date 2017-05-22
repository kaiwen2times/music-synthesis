% Set MUSICLAB directories
here = pwd; % save current directory
DIR = [here, '/musiclab/']; % MUSICLAB directory
chdir(DIR) % goto MUSICLAB directory
addpath(genpath(pwd)); % add to path directory and subdirectories
chdir(here) % return to where you were