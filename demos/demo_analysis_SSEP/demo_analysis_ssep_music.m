%% start toolbox
datadir = 'C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\data\';
tmpdir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/tmp/';
startup_bbci_toolbox('DataDir',datadir , 'TmpDir',tmpdir);
ivaldir = 'C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\bbciPlot\PzCz_TP200_baseline50';


%% right wrist median nerve analysis
wrist_r = struct();
stimloc = [datadir 'bbciPlot/PzCz_tp100'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '2019_BCIPJ*_wrist_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = csvread('C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\bbciPlot\PzCz_TP200_baseline50\ivals_wrist_r.csv', 1,1);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [ival_scalps mnt epo] = hard_ssep_analysis_music(eeg_file, clab, search_ival, stimloc, sign);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
    

    
    fieldname = strjoin(names(i));
    fieldname =  ['x' fieldname(16:end-4)];
    wrist_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    plot_scalp(mnt, vmax);
    saveas(gcf, [fieldname '_wrist_r' '.svg'])
end

save('wrist_r_dipoles.mat', 'wrist_r')


%% left wrist median nerve analysis
wrist_l = struct();
stimloc = [datadir 'bbciPlot/PzCz_hardconstraint/wrist_l_Pz'];
filepaths = dir(fullfile(BTB.MatDir, '19_07_*', '2019_BCIPJ*_wrist_l*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = csvread('C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\bbciPlot\PzCz_TP200_baseline50\ivals_wrist_l.csv', 1,1);


for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [ival_scalps mnt epo] = hard_ssep_analysis_music(eeg_file, clab, search_ival, stimloc, sign);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
   
    
    fieldname = strjoin(names(i));
    fieldname =  ['x' fieldname(16:end-4)];
    wrist_l.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    plot_scalp(mnt, vmax);
    saveas(gcf, [fieldname '_wrist_l' '.svg'])
end

save('wrist_l_dipoles.mat', 'wrist_l')

%% right foot nervus tibialis analysis
foot_r = struct();
stimloc = [datadir 'bbciPlot/PzCz_hardconstraint/foot_r_Cz'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '2019_BCIPJ*_foot_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Cz'};
search_ival = [35 45];
sign = 1;
n = length(filepaths);
ivals = csvread('C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\bbciPlot\PzCz_TP200_baseline50\ivals_foot_r.csv', 1,1);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [ival_scalps mnt epo] = hard_ssep_analysis_music(eeg_file, clab, search_ival, stimloc, sign);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);

    fieldname = strjoin(names(i));
    fieldname =  ['x' fieldname(16:end-4)];
    foot_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    plot_scalp(mnt, vmax);
    saveas(gcf, [fieldname '_foot_r' '.svg'])
end

save('foot_r_dipoles.mat', 'foot_r')


%% right pinky finger analysis
pinkyfinger_r = struct();
stimloc = [datadir 'bbciPlot/PzCz_hardconstraint/pinkyfinger_r_Pz'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '2019_BCIPJ*pinkiefinger_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = csvread('C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\bbciPlot\PzCz_TP200_baseline50\ivals_pinkiefinger_r.csv', 1,1);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [ival_scalps mnt epo] = hard_ssep_analysis_music(eeg_file, clab, search_ival, stimloc, sign);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
    
    fieldname = strjoin(names(i));
    fieldname =  ['x' fieldname(16:end-4)];
    pinkyfinger_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    plot_scalp(mnt, vmax);
    saveas(gcf, [fieldname '_pinkyfinger_r' '.svg'])
end

save('pinkyfinger_r_dipoles.mat', 'pinkyfinger_r')


%% right index finger analysis
idxfinger_r = struct();
stimloc = [datadir 'bbciPlot/PzCz_hardconstraint/idxfinger_r_Pz'];
filepaths = dir(fullfile(BTB.MatDir, '19_07*', '2019_BCIPJ*idxfinder_r*.mat'));
folders = {filepaths.folder};
names = {filepaths.name};
clab = {'Pz'};
search_ival = [15 23];
sign = -1;
n = length(filepaths);
ivals = csvread('C:\Users\Timo\tubCloud\Shared\1_BCI-PJ\bbciPlot\PzCz_TP200_baseline50\ivals_idxfinger_r.csv', 1,1);
for i = 1:n
    eeg_file= fullfile(folders(i), names(i));
    [ival_scalps mnt epo] = hard_ssep_analysis_music(eeg_file, clab, search_ival, stimloc, sign);
    epo.t = round(epo.t,13);
    [leadfield, grid] = load_leadfield(mnt);
    tidx = find(epo.t==ivals(n,1));
    tidx2 = find(epo.t==ivals(n,2));
    patt = mean(mean(epo.x(tidx:tidx2,:,:),3),1)';

    [s,vmax,imax,dip_mom,dip_loc]=haufemusic(patt,leadfield,grid);
    
    fieldname = strjoin(names(i));
    fieldname =  ['x' fieldname(16:end-4)];
    idxfinger_r.(fieldname) = {s,vmax,imax,dip_mom,dip_loc};

    plot_scalp(mnt, vmax);
    saveas(gcf, [fieldname '_idxfinger_r' '.svg'])
end

save('idxfinger_r_dipoles.mat', 'idxfinger_r')
