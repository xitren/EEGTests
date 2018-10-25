
load('Sync','eeg_sync');
ups = zeros(1,0);
downs = zeros(1,0);
for i = 2:size(eeg_sync,1)
    if ( (eeg_sync(i-1,1) < 500) && (eeg_sync(i,1) > 500) )
        ups = [ups;i];
    end
    if ( (eeg_sync(i-1,1) > -500) && (eeg_sync(i,1) < -500) )
        downs = [downs;i];
    end
end
dist_ups = zeros(1,0);
dist_downs = zeros(1,0);
dist_between = zeros(1,0);
for i = 2:size(ups,1)
    dist_ups = [dist_ups;ups(i)-ups(i-1)];
end
for i = 2:size(downs,1)
    dist_downs = [dist_downs;downs(i)-downs(i-1)];
end
for i = 2:size(ups,1)
    dist_between = [dist_between;downs(i)-ups(i-1)];
end
fprintf('Mean of ups: %u ms\n',int32(mean(dist_ups))*2);
fprintf('Mean of downs: %u ms\n',int32(mean(dist_downs))*2);
fprintf('Mean of btws: %u ms\n',int32(mean(dist_between))*2);
fprintf('Deviation of ups: %u ms\n',int32(mad(dist_ups))*2);
fprintf('Deviation of downs: %u ms\n',int32(mad(dist_downs))*2);
fprintf('Deviation of btws: %u ms\n',int32(mad(dist_between))*2);
fprintf('Min of ups: %u ms\n',int32(min(dist_ups))*2);
fprintf('Min of downs: %u ms\n',int32(min(dist_downs))*2);
fprintf('Min of btws: %u ms\n',int32(min(dist_between))*2);
fprintf('Max of ups: %u ms\n',int32(max(dist_ups))*2);
fprintf('Max of downs: %u ms\n',int32(max(dist_downs))*2);
fprintf('Max of btws: %u ms\n',int32(max(dist_between))*2);

load('Sync','sync','targ');
chsync = zeros(1,0);
chsync_up = zeros(1,0);
chsync_down = zeros(1,0);
chsync_up_cl = zeros(1,0);
chsync_down_cl = zeros(1,0);
for i = 2:size(sync,1)
    if ( sync(i-1,1) ~= sync(i,1) )
        if ( sync(i-1,1) < sync(i,1) )
            chsync_up = [chsync_up;i*2.003-130];
            if (targ(i,1) == sync(i,1))
                chsync_up_cl = [chsync_up_cl;1];
            else
                chsync_up_cl = [chsync_up_cl;0];
            end
        else
            chsync_down = [chsync_down;i*2.003-130];
            if (targ(i,1) == sync(i-1,1))
                chsync_down_cl = [chsync_down_cl;1];
            else
                chsync_down_cl = [chsync_down_cl;0];
            end
        end
    end
end
[ classes, syncs ] = GetSyncs( ups, chsync_up, chsync_up_cl, 100 );

load('Sync','eeg_ch1','eeg_ch2','eeg_ch3','eeg_ch4','eeg_ch5');
classes = classes';
y_ch1 = zeros(250,0);
y_ch2 = zeros(250,0);
y_ch3 = zeros(250,0);
y_ch4 = zeros(250,0);
y_ch5 = zeros(250,0);
for i=1:size(syncs,1)
    y_ch1 = [y_ch1,eeg_ch1(syncs(i):(syncs(i)+249),1)];
    y_ch2 = [y_ch2,eeg_ch2(syncs(i):(syncs(i)+249),1)];
    y_ch3 = [y_ch3,eeg_ch3(syncs(i):(syncs(i)+249),1)];
    y_ch4 = [y_ch4,eeg_ch4(syncs(i):(syncs(i)+249),1)];
    y_ch5 = [y_ch5,eeg_ch5(syncs(i):(syncs(i)+249),1)];
end
save('DividedClasses','classes','y_ch1','y_ch2','y_ch3','y_ch4','y_ch5');

dt = size(eeg_sync,1)/size(chsync,1);
x1 = 1:size(eeg_sync,1);
x2 = (1:size(sync,1))*2.003-130;
y1 = eeg_sync(1:end,1);
y2 = sync*300+1500;
plot(x1,y1,x2,y2);