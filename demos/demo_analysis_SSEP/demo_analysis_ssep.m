clc
%% start toolbox
datadir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/data/';
tmpdir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/tmp/';
startup_bbci_toolbox('DataDir', datadir , 'TmpDir',tmpdir);

% analyze all subjects from m to M
m = 1;
M = 8;

%% right wrist median nerve analysis
stimloc = [datadir 'bbciPlot/CP34CPz_TP200_baseline70'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*wrist_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'CP3'};
search_ivals = [15 20; 16 20; 18 23; 18 22; 18 22; 18 22; 18 22; 19 24];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = m:M
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ivals(i,:), stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals_wrist_r.csv'])

%% left wrist median nerve analysis
stimloc = [datadir 'bbciPlot/CP34CPz_TP200_baseline70'];
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '*wrist_l.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'CP4'};
search_ivals = [15 20; 15 20; 18 26; 15 20; 18 25; 18 22; 20 26; 20 25];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = m:M
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ivals(i,:), stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals_wrist_l.csv'])

%% right index finger analysis
stimloc = [datadir 'bbciPlot/CP34CPz_TP200_baseline70'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*idxfinger_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'CP3'};
search_ivals = [25 30; 20 25; 20 25; 20 25; 20 25; 20 25; 15 20; 25 30];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = m:M
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ivals(i,:), stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals_idxfinger_r.csv'])
 
%% right foot nervus tibialis analysis
stimloc = [datadir 'bbciPlot/CP34CPz_TP200_baseline70'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*foot_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'CPz'};
search_ivals = [33 40; 32 36; 30 35; 35 38; 35 40; 40 45; 35 40; 35 40];
sign = 1;
n = length(filepaths);
ivals = zeros(n,2);
for i = m:M
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ivals(i,:), stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals_foot_r.csv'])


%% right pinky finger analysis
stimloc = [datadir 'bbciPlot/CP34CPz_TP200_baseline70'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*pinkiefinger_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'CP3'};
search_ivals = [25 30; 20 25; 20 25; 23 27; 17 25; 25 30; 25 30; 15 20];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = m:M
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ivals(i,:), stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals_pinkiefinger_r.csv'])
