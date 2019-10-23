function [leadfield, gridpos] = load_leadfield(mnt)
%% Leadfield
datadir = '/Users/geronimobergk/TUcloud/1_MSc_Elektrotechnik/1_SS19/1_BCI-PJ/data/';
leadfield = load([datadir 'leadfield4shell1922eTPM_cortex3dim_Andy.mat']);
leadfield = leadfield.L;

gridpos = load([datadir 'gridpos.mat']);

load([datadir 'elec_aligned_Andy_proj.mat']);

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
end
