%% start toolbox
datadir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/data/';
tmpdir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/tmp/';
startup_bbci_toolbox('DataDir',datadir , 'TmpDir',tmpdir);


%% right wrist median nerve analysis
filepaths = dir(fullfile(BTB.MatDir, 'VPo*', '2019_BCIPJ*_wrist_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'C3', 'CP3'};
search_ival = [10 40];
for i = 1:1%length(filepaths)
    eeg_file= fullfile(folders(i), names(i));
    ssep_analysis(eeg_file, clab, search_ival)
end

%% right foot nervus tibialis analysis
filepaths = dir(fullfile(BTB.MatDir, 'VPo*', '2019_BCIPJ*_foot_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'C1','Cz'};
search_ival = [18 38];
for i = length(filepaths):length(filepaths)
    eeg_file= fullfile(folders(i), names(i));
    ssep_analysis(eeg_file, clab, search_ival)
end
