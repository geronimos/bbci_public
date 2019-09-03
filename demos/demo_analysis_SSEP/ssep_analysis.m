function ssep_analysis(eeg_file, clab, search_ival)
try
    [cnt, mrk, mnt]= file_loadMatlab(eeg_file);
catch
    error('You need to run ''demo_convert_SSEP'' first');
end

% Define some settings
disp_ival= [-100 50];
ref_ival= [-100 0];
crit_maxmin= 80;
crit_ival= [10 50];
crit_clab= {'F9,z,10','AF3,4'};
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
%constraint= ... % Wrist Analysis
%    {{-1, [17 19], {'P3-4','CP3-4','C3-4'}}, ...   % N18
%    {-1, [20 21], {'P3-4','CP3-4','C3-4'}}, ...    % N20
%    {-1, [23 25], {'P3-4','CP3-4','C3-4'}}};       % N24
%    {-1, [28 32], {'P3-4','CP3-4','C3-4'}}};      % N30
%  
% clab = {'not', 'E*'}
[ival_scalps, nfo]= ...
    procutil_selectTimeIntervals(epo_r, 'Visualize', 0, ...
                                        'VisuScalps', 0, ...
                                        'Clab', clab, ...
                                        'NIvals',6, ...
                                        'Sign',-1, ...
                                        'IvalMax',search_ival);
ival_scalps= visutil_correctIvalsForDisplay(ival_scalps, 'Fs', epo.fs);

[~, fname, ~] = fileparts(char(eeg_file));

% plot epochs of all channels
fig_set(1)
H= grid_plot(epo, mnt, defopt_erps, 'ColorOrder',colOrder);
grid_addBars(epo_r, 'HScale', H.scale);
print([fname 'erp'], '-depsc');

% plot selected channels with scalp evolution below
fig_set(2);
H= plot_scalpEvolutionPlusChannel(epo, mnt, clab, ival_scalps, ...
    defopt_scalp_erp, ...
    'ColorOrder',colOrder);
grid_addBars(epo_r);
print([fname 'erp_topo'], '-depsc');

% write erp_topo info to csv file
writetable(struct2table(nfo), [fname 'erp_numb.csv'])

end