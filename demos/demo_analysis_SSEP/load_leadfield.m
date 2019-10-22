function [leadfield, gridpos] = load_leadfield(mnt)
%% Leadfield
leadfield = load(['C:\Users\Timo\tubCloud\Shared\1_BCI-PJ' '\leadfield4shell1922eTPM_cortex3dim_Andy.mat']);
leadfield = leadfield.L;

gridpos = load(['C:\Users\Timo\tubCloud\Shared\1_BCI-PJ' '\gridpos.mat']);

load(['C:\Users\Timo\tubCloud\Shared\1_BCI-PJ' '\elec_aligned_Andy_proj.mat']);

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
