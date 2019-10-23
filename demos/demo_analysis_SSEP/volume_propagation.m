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

% get stimloc cells with:
%   s - fit quality, i.e. how good does the dipole position fit from 0 to 1
%   vmax - field of the best dipole
%   imax - grid index of best dipole
%   dip_mom - moment of the best dipole
%   dip_loc - location of the best dipole
filepaths = dir(fullfile(savematdir, '*.mat'));
names = {filepaths.name};
for i = 1:length(filepaths)
    load([savematdir char(names(i))]);
end

%% right wrist
% get dipole location
fields = fieldnames(wrist_r);
for i = 1:numel(fields)
  imax = wrist_r.(fields{i})(3);
  wrist_r.(fields{i})(5) = {grid.gridpos(imax{1},:)}; % get dipole position
end

figure
trisurf(cortexgrid.tri, cortexgrid.pos(:,1), cortexgrid.pos(:,2), ...
    cortexgrid.pos(:,3), randi(255, size(cortexgrid.pos, 1), 1))