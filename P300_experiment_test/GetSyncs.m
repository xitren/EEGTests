function [ classes, syncs ] = GetSyncs( sync, chsync, classes_in, distance )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    classes = int32(zeros(0,1));
    syncs = int32(zeros(0,1));
    for i = 1:size(chsync,1)
        distance_table = zeros(size(sync,1),1);
        for j = 1:size(sync,1)
            distance_table(j,1) = abs(chsync(i,1)-sync(j,1));
        end
        [val,ind] = min(distance_table);
        if (distance_table(ind) < distance)
            classes = [classes;classes_in(i,1)];
            syncs = [syncs;chsync(ind)];
        else
            classes = [classes;-1];
            syncs = [syncs;chsync(i,1)];
        end
    end

end

