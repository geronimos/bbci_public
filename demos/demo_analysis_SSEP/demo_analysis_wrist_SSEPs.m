% First call
% startup_bbci_toolbox('DataDir', './data/', 'TmpDir','./tmp/');
%
% Load EEG data for analysis
eeg_file= fullfile(BTB.DataDir, 'bbciMat', 'VPody_19_07_10_1250', ...
                   '2019_BCIPJ_SEP_A1_R_1_wrist_rVPody.mat');
try
    [cnt, mrk, mnt]= file_loadMatlab(eeg_file);
catch
    error('You need to run ''demo_convert_SSEP'' first');
end

% Define some settings
disp_ival= [-100 100];
ref_ival= [-100 0];
crit_maxmin= 70;
crit_ival= [10 100];
crit_clab= {'F9,z,10','AF3,4'};
clab= {'C3','C4'};
colOrder= [1 0 1; 0.4 0.4 0.4];

% Apply highpass filter to reduce drifts
b= procutil_firlsFilter(3, cnt.fs);
cnt= proc_filtfilt(cnt, b);
% Artifact rejection based on variance criterion
mrk= reject_varEventsAndChannels(cnt, mrk, disp_ival, 'verbose', 1);

% Segmentation
epo= proc_segmentation(cnt, mrk, disp_ival);
epo_r = proc_rSquareSigned(epo);

% Artifact rejection based on maxmin difference criterion on frontal chans
[epo, iArte] = proc_rejectArtifactsMaxMin(epo, crit_maxmin, ...
    'Clab',crit_clab, ...
    'Ival',crit_ival, ...
    'Verbose',1);

% Baseline subtraction, and calculation of a measure of discriminability
epo = proc_baseline(epo, ref_ival);

% Select some discriminative intervals, with constraints 
% to find N2, P2, P3 like components.
constraint= ... % Wrist Analysis
    {{-1, [17 19], {'P3-4','CP3-4','C3-4'}}, ...   % N18
    {-1, [20 21], {'P3-4','CP3-4','C3-4'}}, ...    % N20
    {-1, [23 25], {'P3-4','CP3-4','C3-4'}}};       % N24
    %{-1, [28 32], {'P3-4','CP3-4','C3-4'}}};      % N30
    %{-1, [34 36], {'P3-4','CP3-4','C3-4'}}};      % N35
[ival_scalps, nfo]= ...
    procutil_selectTimeIntervals(epo_r, 'Visualize', 0, ...
                                        'VisuScalps', 0, ...
                                        'Clab', {'not', 'E*'}, ...
                                        'NIvals',3, ...
                                        'Constraint', constraint);
ival_scalps= visutil_correctIvalsForDisplay(ival_scalps, 'Fs', epo.fs);

fig_set(1)
H= grid_plot(epo, mnt, defopt_erps, 'ColorOrder',colOrder);
grid_addBars(epo_r, 'HScale', H.scale);
%printFigure(['erp'], [19 12]);

fig_set(2);
H= plot_scalpEvolutionPlusChannel(epo, mnt, clab, ival_scalps, ...
    defopt_scalp_erp, ...
    'ColorOrder',colOrder);
grid_addBars(epo_r);
%printFigure(['erp_topo'], [20  4+5*size(epo.y,1)]);
