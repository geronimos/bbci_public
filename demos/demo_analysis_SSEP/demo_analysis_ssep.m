%% start toolbox
datadir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/data/';
tmpdir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/tmp/';
startup_bbci_toolbox('DataDir',datadir , 'TmpDir',tmpdir);


%% right wrist median nerve analysis
stimloc = 'wrist_r_Pz';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_wrist_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ival, stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals.csv'])

%% left wrist median nerve analysis
stimloc = 'wrist_l_Pz';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_wrist_l*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ival, stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals.csv'])

%% right foot nervus tibialis analysis
stimloc = 'foot_r_Cz';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_foot_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Cz'};
search_ival = [35 45];
sign = 1;
n = length(filepaths);
ivals = zeros(n,2);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ival, stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals.csv'])


%% right pinky finger analysis
stimloc = 'pinkyfinger_r_Pz';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*pinkiefinger_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ival, stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals.csv'])


%% right index finger analysis
stimloc = 'idxfinger_r_Pz';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*idxfinder_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = zeros(n,2);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    ivals(i,:) = hard_ssep_analysis(eeg_file, clab, search_ival, stimloc, sign);
end
% write erp_topo info to csv file
ival_tbl = cell(n,3);
ival_tbl(:,1) = names;
ival_tbl(:,2:3) = num2cell(ivals);
writetable(cell2table(ival_tbl), [stimloc '/' 'ivals.csv'])
