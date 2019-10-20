BTB_memo = BTB;
% BTB.RawDir = fullfile(BTB.DataDir, 'demoRaw');
BTB.MatDir = fullfile(BTB.DataDir, 'bbciMat');

% Subdirectory of the RAW data to convert
% add more to the list if you want to do it in a row
% subdir_list = {'VPodt_19_05_28'}; %reorder needed
% subdir_list = {'VPodv_19_06_04'}; %reorder needed
% subdir_list = {'VPodw_19_06_11'}; %reorder needed
% subdir_list = {'VPodx_19_07_02'};
%subdir_list = {'19_07_10_RA'}; % amplifiers swapped?!
%subdir_list = {'19_07_11_GA'};
%subdir_list = {'19_07_14_MA'};
%subdir_list = {'19_07_16_RB'};
%subdir_list = {'19_07_18_TA'};
%subdir_list = {'19_07_19_GB'};
%subdir_list = {'19_07_19_TB'};
%subdir_list = {'19_07_25_MB'};
subdir_list = {'19_07_10_A1' '19_07_16_B4' '19_07_19_B7' ...
    '19_07_11_A2' '19_07_18_A5' '19_07_25_B8' ...
    '19_07_14_A3' '19_07_19_B6'};
reorder = 0;

Fs = 1250; % new sampling rate

% Definition of classes based on markers
stimDef= {[31:46], [11:26]; 'target', 'nontarget'};

% Load raw files (with filtering), define classes and montage,
% and save data in matlab format
for k= 1:length(subdir_list)
    % Files to convert into .mat
    basename_list = dir(fullfile(BTB.RawDir, subdir_list{k}, '*.vhdr'));
    basename_list = {basename_list.name};
    for ib= 1:length(basename_list)
        subdir= subdir_list{k};
        sbj= subdir(1:find(subdir=='_',1,'first')-1);
        %   file= fullfile(subdir, [basename_list{ib} sbj]);
        [~, filename]=fileparts(basename_list{ib});
        file= fullfile(subdir, filename);
        fprintf('converting %s\n', file)
        % header of the raw EEG files
        hdr = file_readBVheader(file);
        
        % low-pass filter
        %Wps = [84 98]/hdr.fs*2;
        %[n, Ws] = cheb2ord(Wps(1), Wps(2), 3, 40);
       % [filt.b, filt.a]= cheby2(n, 50, Ws);
        % load raw data, downsampling is done while loading (after filtering)
       % [cnt, mrk_orig] = file_readBV(file, 'Fs',Fs, 'Filt',filt);
       [cnt, mrk_orig] = file_readBV(file, 'Fs',Fs);
       % Reorder to fix wrong workspace configuration 
       if reorder
            cnt.clab{util_chanind(cnt.clab,'PO9')} = 'AF7';
            cnt.clab{util_chanind(cnt.clab,'PO10')} = 'AF8';
        end
        % Re-referencing to linked-mastoids
        %   (data was referenced to T10 during acquisition)
        A = eye(length(cnt.clab));
        iref2 = util_chanind(cnt.clab, 'T8');
        A(iref2,:) = -0.5;
        A(:,iref2) = [];
        cnt = proc_linearDerivation(cnt, A);
        
        % create mrk and mnt
        mrk= mrk_defineClasses(mrk_orig, stimDef);
        mrk.orig= mrk_orig;
        mnt= mnt_setElectrodePositions(cnt.clab);
        mnt= mnt_setGrid(mnt, 'M+EOG');
        
        % save in matlab format
        file_saveMatlab(file, cnt, mrk, mnt, 'Vars','hdr');
    end
end

BTB= BTB_memo;
