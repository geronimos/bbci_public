function [ival_scalps mnt epo] = hard_ssep_analysis_music(eeg_file, clab, search_ival, stimloc, sign)

try
    [cnt, mrk, mnt]= file_loadMatlab(eeg_file);
catch
    error('You need to run ''demo_convert_SSEP'' first');
end

% Define some settings
disp_ival= [-100 50];   % plot ival
ref_ival= [-70 -5];     % baseline correction
crit_maxmin= 75;        % artefact rejection
crit_ival= [10 50];     % artefact rejection
crit_clab= {'F9,z,10','AF3,4'}; % artefact rejection
colOrder= [1 0 1; 0.4 0.4 0.4]; % ival color

% Apply highpass filter to reduce drifts
b= procutil_firlsFilter(3, cnt.fs);
cnt= proc_filtfilt(cnt, b);

b= procutil_firlsFilter(100, cnt.fs, 'Lowpass',1);
cnt= proc_filtfilt(cnt, b);

% Artifact rejection based on variance criterion
mrk= reject_varEventsAndChannels(cnt, mrk, disp_ival, 'verbose', 1);

% Segmentation
epo= proc_segmentation(cnt, mrk, disp_ival);

% Artifact rejection based on maxmin difference criterion on frontal chans
[epo, iArte] = proc_rejectArtifactsMaxMin(epo, crit_maxmin, ...
    'Clab',crit_clab, ...
    'Ival',crit_ival, ...
    'Verbose',1);

% Baseline subtraction, and calculation of a measure of discriminability
epo = proc_baseline(epo, ref_ival);

% Cut epo to only plot from t=0
epo.x = epo.x(130:end,:,:);
epo.t = epo.t(130:end);

% get ival
selec_pot = epo.x(epo.t > search_ival(1) & epo.t < search_ival(2), ...
    strcmp(epo.clab, clab), :);
min_idx = find(epo.t > search_ival(1) & epo.t < search_ival(2), 1);

selec_pot_trial_mean = mean(selec_pot, 3);
if sign == 1
    [val, idx] = max(selec_pot_trial_mean);
end
if sign == -1
    [val, idx] = min(selec_pot_trial_mean);
end

ival_scalps = [epo.t(min_idx + idx - 1), epo.t(min_idx + idx + 1)];

ival_scalps_plt= visutil_correctIvalsForDisplay(ival_scalps, 'Fs', epo.fs);

[~, fname, ~] = fileparts(char(eeg_file));






end