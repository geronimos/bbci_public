%% Load EEG data for analysis
startup_bbci_toolbox;
data_dir = 'C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\data\bbciMat'; %directory of the bbciMat folder
subject_folder = '19_07_14_MA'; %subfolder of the subject
data_set = '2019_BCIPJ_SEP_M_2_wrist_lVPoeu.mat'; %actual name of the file
eeg_file= fullfile(data_dir, subject_folder, data_set);

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

%% Leadfield
leadfield = load([BTB.DataDir '\leadfield4shell1922eTPM_cortex3dim_Andy.mat']);
leadfield = leadfield.L;

gridpos = load([BTB.DataDir '\gridpos.mat']);

load([BTB.DataDir '\elec_aligned_Andy_proj.mat']);

%Find a filter vector to throw out the unneccessary channels and then find
%a sorting vector
idx = find(ismember(mnt.clab,'A2'));
if idx ~= 0
    mnt.clab{idx} = 'T8';
end
[Lia,Locb] = ismember(elec_aligned.label, mnt.clab);
filtered_lab = elec_aligned.label(Lia);
[Lia2,Locb2] = ismember(mnt.clab, filtered_lab);
sorted_lab = filtered_lab(Locb2);

if ~isequal(sorted_lab, mnt.clab')
    print('Sorting didnt work')
    return
end

%Filter and sort the leadfield
leadfield = leadfield(Lia,:,:);
leadfield = leadfield(Locb2,:,:);

%% MUSIC
time = 152;
patt = epo.x(time,:)';
[s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,gridpos);
