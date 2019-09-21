%% MEAN right wrist median nerve analysis
stimloc = 'wrist_r_Pz';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_wrist_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
% Define some settings
disp_ival= [-100 50];   % plot ival
ref_ival= [-100 0];     % baseline correction
crit_maxmin= 75;        % artefact rejection
crit_ival= [10 50];     % artefact rejection
crit_clab= {'F9,z,10','AF3,4'}; % artefact rejection
colOrder= [1 0 1; 0.4 0.4 0.4]; % ival color
epos = struct(n);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    try
        [cnt, mrk, mnt]= file_loadMatlab(eeg_file);
    catch
        error('You need to run ''demo_convert_SSEP'' first');
    end

    % Apply highpass filter to reduce drifts
    b= procutil_firlsFilter(3, cnt.fs);
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
end


% Cut epo to only plot from t=0
epo.x = epo.x(120:end,:,:);
epo.t = epo.t(120:end);

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

% plot epochs of all channels
fig_set(1)
H = grid_plot(epo, mnt, defopt_erps, 'ColorOrder',colOrder);
%grid_addBars(epo_r, 'HScale', H.scale);
print([stimloc '/' fname 'erp'], '-depsc');

% plot selected channels with scalp evolution below
fig_set(2);
H = plot_scalpEvolutionPlusChannel(epo, mnt, clab, ival_scalps_plt, ...
    defopt_scalp_erp, ...
    'ColorOrder',colOrder);
%grid_addBars(epo);
print([stimloc '/' fname 'erp_topo'], '-depsc');

% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals.csv'])

