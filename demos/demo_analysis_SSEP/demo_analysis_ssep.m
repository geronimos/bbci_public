%% start toolbox
datadir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/data/';
tmpdir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/tmp/';
startup_bbci_toolbox('DataDir',datadir , 'TmpDir',tmpdir);


%% right wrist median nerve analysis
stimloc = 'wrist_r';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_wrist_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'C3', 'CP3'};
search_ival = [19 21];
for i = 1:length(filepaths)
    eeg_file= fullfile(folders(i), names(i));
    ssep_analysis(eeg_file, clab, search_ival, stimloc, -1)
end

%% left wrist median nerve analysis
stimloc = 'wrist_l';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_wrist_l*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'C4', 'CP4'};
search_ival = [18 23];
for i = 5:length(filepaths)
    eeg_file= fullfile(folders(i), names(i));
    ssep_analysis(eeg_file, clab, search_ival, stimloc, -1)
end

%% right foot nervus tibialis analysis
stimloc = 'foot_r';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_foot_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'C1','Cz'};
search_ival = [30 45];
constraint= {{1, [36 38], {'C1-2','CP1-2','FC1-2'}, [30 45]}};
for i = 1:length(filepaths)
    eeg_file= fullfile(folders(i), names(i));
    ssep_analysis(eeg_file, clab, search_ival, stimloc, 1, constraint)
end

%% right pinky finger analysis
stimloc = 'pinkyfinger_r';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*pinkiefinger_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'C3', 'CP3'};
search_ival = [18 22];
for i = 1:4 %length(filepaths)
    eeg_file= fullfile(folders(i), names(i));
    ssep_analysis(eeg_file, clab, search_ival, stimloc)
end



%% right index finger analysis
stimloc = 'idxfinger_r';
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*idxfinder_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'C3', 'CP3'};
search_ival = [18 22];
for i = 1:length(filepaths)
    eeg_file= fullfile(folders(i), names(i));
    ssep_analysis(eeg_file, clab, search_ival, stimloc)
end