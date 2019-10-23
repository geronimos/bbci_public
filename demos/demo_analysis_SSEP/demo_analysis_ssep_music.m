clc
close all
clear
%% start toolbox
datadir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/data/';
tmpdir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/tmp/';
startup_bbci_toolbox('DataDir', datadir , 'TmpDir', tmpdir);
ivaldir = [datadir 'bbciPlot/CP34CPz_TP200_baseline70/'];
stimloc = [datadir 'bbciPlot/CP34CPz_TP200_baseline70_reconstruction'];
savematdir = [datadir 'bbciMat/CP34CPz_TP200_baseline70/'];

%% right wrist median nerve analysis
wrist_r = struct();
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*wrist_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
n = length(filepaths);
ivals = csvread([ivaldir 'ivals_wrist_r.csv'], 1,1);
for i = 1:1
    eeg_file= fullfile(folders(i), names(i));
    [mnt, epo] = hard_ssep_analysis_music(eeg_file);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
    
    fieldname = strjoin(names(i));
    fieldname =  fieldname(1:4);
    wrist_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};
    
    figure
    plot_scalp(mnt, vmax);
    print([ivaldir fieldname '_wrist_r'], '-depsc');
    %saveas(gcf, [ivaldir fieldname '_wrist_r' '.eps'])
end

save([savematdir 'wrist_r_dipoles.mat'], 'wrist_r')


%% left wrist median nerve analysis
wrist_l = struct();
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '*wrist_l.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
n = length(filepaths);
ivals = csvread([ivaldir 'ivals_wrist_l.csv'], 1,1);

for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [mnt, epo] = hard_ssep_analysis_music(eeg_file);
    epo.t = round(epo.t, 13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
       
    fieldname = strjoin(names(i));
    fieldname =  fieldname(1:4);
    wrist_l.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    figure
    plot_scalp(mnt, vmax);
    print([ivaldir fieldname '_wrist_l'], '-depsc');
    %saveas(gcf, [fieldname '_wrist_l' '.svg'])
end

save([savematdir 'wrist_l_dipoles.mat'], 'wrist_l')

%% right foot nervus tibialis analysis
foot_r = struct();
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*foot_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
n = length(filepaths);
ivals = csvread([ivaldir 'ivals_foot_r.csv'], 1,1);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [mnt, epo] = hard_ssep_analysis_music(eeg_file);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);

    fieldname = strjoin(names(i));
    fieldname =  fieldname(1:4);
    foot_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    figure
    plot_scalp(mnt, vmax);
    print([ivaldir fieldname '_foot_r'], '-depsc');
    %saveas(gcf, [fieldname '_foot_r' '.svg'])
end

save([savematdir 'foot_r_dipoles.mat'], 'foot_r')


%% right pinky finger analysis
pinkyfinger_r = struct();
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*pinkiefinger_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
n = length(filepaths);
ivals = csvread([ivaldir 'ivals_pinkiefinger_r.csv'], 1,1);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [mnt, epo] = hard_ssep_analysis_music(eeg_file);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
    
    fieldname = strjoin(names(i));
    fieldname =  fieldname(1:4);
    pinkyfinger_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    figure
    plot_scalp(mnt, vmax);
    print([ivaldir fieldname '_pinkyfinger_r'], '-depsc');
    %saveas(gcf, [fieldname '_pinkyfinger_r' '.svg'])
end

save([savematdir 'pinkyfinger_r_dipoles.mat'], 'pinkyfinger_r')


%% right index finger analysis
idxfinger_r = struct();
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '*idxfinger_r.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
n = length(filepaths);
ivals = csvread([ivaldir 'ivals_idxfinger_r.csv'], 1,1);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [mnt, epo] = hard_ssep_analysis_music(eeg_file);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
    
    fieldname = strjoin(names(i));
    fieldname =  fieldname(1:4);
    idxfinger_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    figure
    plot_scalp(mnt, vmax);
    print([ivaldir fieldname '_idxfinger_r'], '-depsc');
    % saveas(gcf, [fieldname '_idxfinger_r' '.svg'])
end

save([savematdir 'idxfinger_r_dipoles.mat'], 'idxfinger_r')
