%% Load sound files

% Relative path to sounds directory
dirname = 'data/sounds';
% List the .wav files
out = dir(sprintf('%s/*.wav', dirname)); % .wav file

N = length(out);
% Memory pre-allocation
s = struct('name',cell(1),'y',[],'fs',0,'nbits',0,'t',0);
sounds = repmat(s,1,N);
% Load the sound files
for i = 1:N
  sounds(i).name = out(i).name;
  [sounds(i).y, sounds(i).fs, sounds(i).nbits] = ...
    wavread(sprintf('%s/%s', dirname, out(i).name));
  nsamples = length(sounds(i).y);
  sounds(i).t = linspace(0, nsamples/sounds(i).fs, nsamples);
end

%% Plots in time domain

for i = 1:N
  figure
  plot(sounds(i).t, sounds(i).y);
  title(sprintf('Soudn wave %s over time\n', sounds(i).name))
  xlabel('Time [s]')
  ylabel('Signal amplitude')
  axis([sounds(i).t(1) sounds(i).t(end) ...
    min(sounds(i).y) max(sounds(i).y)])
end

%% Spectrograms and cepstrograms

addpath('GetSpeechFeatures/')
winlength = 30/1000; % window length of 30 (ms)
ncep = 13; % number of cepstral coefficients

for i = 1:N
  % Compute spectrogram and cepstrogram
  [mfccs, spectgram, f, t] = GetSpeechFeatures(sounds(i).y, ...
    sounds(i).fs, winlength, ncep);
  % Normalize cepstrogram
  mfccs = (mfccs - repmat(mean(mfccs,2), [1 length(t)])) ./ ...
    repmat(std(mfccs,0,2), [1 length(t)]);
  mean(mfccs,2)
  std(mfccs,0,2)
  
  figure
  imagesc(t,f,10*log10(spectgram));
  colormap gray; colorbar; axis xy;
  title(sprintf('Spectrogram of the sound file %s\n', sounds(i).name));
  xlabel('Time [s]')
  ylabel('Frequency [Hz]')
  
  
  figure
  
  subplot('211')
  imagesc(t,f,10*log10(spectgram));
  colorbar; axis xy;
  title(sprintf('Spectrogram of the sound file %s\n', sounds(i).name));
  xlabel('Time [s]')
  ylabel('Frequency [Hz]')
  
  subplot('212')
  imagesc(t,[],mfccs);
  colorbar; axis xy;
  title(sprintf('Cepstrogram of the sound file %s\n', sounds(i).name));
  xlabel('Time [s]')
  ylabel('Cepstral coefficients')
 end