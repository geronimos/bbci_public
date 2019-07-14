% eeg_file= fullfile(BTB.DataDir, 'bbciMat', 'VPodt_19_05_28', ...
%     '2019_BCIPJ_SEP_A1_1_wrist_rVPodt');

%  eeg_file= fullfile(BTB.DataDir, 'bbciMat', 'VPodv_19_06_04', ...
%      '2019_BCIPJ_SEP_A2_2_wrist_l1VPodv');
% 
% eeg_file= dir(fullfile(BTB.DataDir, 'bbciMat', 'VPodw_19_06_11', ...
%                    '2019_BCIPJ_SEP_A3_*_wrist_lVPodx.mat'));

% Load EEG data for analysis
eeg_file = fullfile(BTB.DataDir, 'bbciMat', 'VPody_19_07_10', ...
                   '2019_BCIPJ_SEP_A1_R_4_foot_rVPody.mat');
try
    [cnt, mrk, mnt] = file_loadMatlab(eeg_file);
catch
    error('You need to run ''demo_convert_SSEP'' first');
end
% % subj='';
% %Load EEG data from multiple files
% for ii=1:numel(eeg_file)
%     [~,eeg_file(ii).name]= fileparts(eeg_file(ii).name);
%     eeg_file(ii).name=fullfile(subj,eeg_file(ii).name);
% end
%
% try
%     [cnt, mrk, mnt] = file_loadMatlab({eeg_file.name});
% catch
%     error('You need to run ''demo_convert_SSEP'' first');
% end

% Define some settings
disp_ival= [-100 200];
ref_ival= [-100 0];
crit_maxmin= 85;
crit_ival= [10 100];
crit_clab= {'F9,z,10','AF3,4'};
clab= {'C1','C2'};
colOrder= [1 0 1; 0.4 0.4 0.4];

% Apply highpass filter to reduce drifts
b= procutil_firlsFilter(0.5, cnt.fs);
cnt= proc_filtfilt(cnt, b);
% Wps = 70/cnt.fs*2;
% [b,a]=butter(5,Wps);
% cnt= proc_filtfilt(cnt, b,a);
% Artifact rejection based on variance criterion
mrk= reject_varEventsAndChannels(cnt, mrk, disp_ival, 'verbose', 1);

% Segmentation
epo= proc_segmentation(cnt, mrk, disp_ival);

% Artifact rejection based on maxmin difference criterion on frontal chans
[epo iArte] = proc_rejectArtifactsMaxMin(epo, crit_maxmin, 'Clab',crit_clab, ...
    'Ival',crit_ival, 'Verbose',1);

% Baseline subtraction, and calculation of a measure of discriminability
epo= proc_baseline(epo, ref_ival);
epo_r= proc_rSquareSigned(epo);

% Select some discriminative intervals, with constraints to find N2, P2, P3 like components.
fig_set(3);
%constraint= ...
%    {{-1, [10 20], {'P3-4','CP3-4','C3-4'}, [10 20]}, ...
%    {1, [15 25], {'P3-4','CP3-4','C3-4'}, [15 25]}, ...
%    {-1, [15 25], {'P3-4','CP3-4','C3-4'}, [15 25]}, ...
%    {-1, [20 40], {'P3-4','CP3-4','C3-4'}, [20 40]}, ...
%    {-1, [10 50], {'P3-4','CP3-4','C3-4'}, [10 50]} ...
%    {1, [10 50], {'P3-4','CP3-4','C3-4'}, [10 50]}, ...
%    {1, [40 60], {'P3-4','CP3-4','C3-4'}, [40 60]}};
constraint= ... % Foot Analysis
    {{-1, [33 42], {'P3-4','CP3-4','C3-4'}, [33 42]}, ...
    {1, [25 45], {'P3-4','CP3-4','C3-4'}, [25 45]}};
[ival_scalps, nfo]= ...
    procutil_selectTimeIntervals(epo_r, 'Visualize', 1, 'VisuScalps', 1, ...
    'Clab',{'not','E*'}, ...
    'Constraint', constraint);
%printFigure('r_matrix', [18 13]);
ival_scalps= visutil_correctIvalsForDisplay(ival_scalps, 'Fs',epo.fs);

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

fig_set(4, 'Resize',[1 2/3]);
plot_scalpEvolutionPlusChannel(epo_r, mnt, clab, ival_scalps, defopt_scalp_r);
%printFigure(['erp_topo_r'], [20 9]);
