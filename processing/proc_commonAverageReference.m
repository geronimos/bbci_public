function dat= proc_commonAverageReference(dat, refChans, rerefChans)
%PROC_COMMONAVERAGEREFERENCE - rereferencing to a common reference
%
%Synopsis:
% dat= proc_commonAverageReference(dat, <refChans, rerefChans>)
%
% rereference signals to common average reference. you should only
% used scalp electrodes as reference, not e.g. EMG channels.
%
%Arguments:
%      dat        - data structure of continuous or epoched data
%      refChans   - channels used as average reference, see chanind for format, 
%                   default scalpChannels(dat)
%      rerefChans - those channels are rereferenced, default refChans
%
%Returns:
%      dat        - updated data structure
%
% SEE scalpChannels, chanind

% bb, ida.first.fhg.de
dat = misc_history(dat);

if ~exist('refChans','var') || isempty(refChans)
  refChans= scalpChannels(dat);
end
if ~exist('rerefChans','var') || isempty(rerefChans), rerefChans= refChans; end

misc_checkType(dat, 'STRUCT(x clab)'); 
misc_checkType(refChans, 'CELL{CHAR}|CHAR'); 
misc_checkType(rerefChans, 'CELL{CHAR}|CHAR'); 


rc= chanind(dat, refChans);
rrc= chanind(dat, rerefChans);
car= mean(dat.x(:,rc,:), 2);
%% this might consume too much memory:
%car= repmat(car, [1 length(rrc) 1]);
%dat.x(:,rrc,:)= dat.x(:,rrc,:) - car;

for cc= rrc,
  dat.x(:,cc,:)= dat.x(:,cc,:) - car;
  dat.clab{cc}= [dat.clab{cc} ' car'];
end
