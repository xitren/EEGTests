% [~, targ, sync, ~, ~, ~, ~, ~, ~] = ...
%     textread('Denis_s_monitorom_2018-07-16-14-05-04.JSON', ...
%     '  {"sample": %d, "data": [%d, %d, %d, %d, %d, %d, %d, %d]},', 46867);
% [data, header] = ReadEDF('Denis_s_monitorom_20180716.edf');

% [~, targ, sync, ~, ~, ~, ~, ~, ~] = ...
%     textread('Denis_s_predyavitelem_2018-07-16-14-24-50.JSON', ...
%     '  {"sample": %d, "data": [%d, %d, %d, %d, %d, %d, %d, %d]},', 46787);
% [data, header] = ReadEDF('Denis_s_predyavitelem_20180716.edf');


old_start = 450700;
old_end = 544000;
[~, targ, sync, ~, ~, ~, ~, ~, ~] = ...
    textread('Old_experiment_2018-07-05-13-50-34.JSON', ...
    '  {"sample": %d, "data": [%d, %d, %d, %d, %d, %d, %d, %d]},', 45931);
[data, header] = ReadEDF('Old_experiment_20180705.edf');
eeg_sync = data{1,6}(old_start:old_end,1);
eeg_ch1 = data{1,1}(old_start:old_end,1);
eeg_ch2 = data{1,2}(old_start:old_end,1);
eeg_ch3 = data{1,3}(old_start:old_end,1);
eeg_ch4 = data{1,4}(old_start:old_end,1);
eeg_ch5 = data{1,5}(old_start:old_end,1);
plot(eeg_sync);

save('Sync','eeg_sync','eeg_ch1','eeg_ch2','eeg_ch3','eeg_ch4','eeg_ch5',...
    'sync','targ');
