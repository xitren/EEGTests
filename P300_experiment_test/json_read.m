function [data, target, current] = json_read(path_file)
%JSON_READ Summary of this function goes here
%   Detailed explanation goes here
%% Data preparation
file_temp = 'temp.txt';
file_id = fopen(path_file, 'r');
tline = fgetl(file_id); % Skip string
tline = fgetl(file_id); % Skip string
buffer = fread(file_id, Inf); % Read rest of the file
fclose(file_id);
file_id_temp = fopen(file_temp, 'wt'); % Create or open destination file
fwrite(file_id_temp, buffer); % Save buffer to file
fclose(file_id_temp);
file_id_temp = fopen(file_temp, 'r'); % Create or open destination file
tline = fgetl(file_id_temp); % Skip string
%% Find number of strings in temp file
num_of_strings = 0;
while ischar(tline)
   num_of_strings = num_of_strings + 1;
   tline = fgetl(file_id_temp);
end
fclose(file_id_temp);
%% Reading data
[   sample_id, ...
    target, ...
    current, ...
    channel_1, ...
    channel_2, ...
    channel_3, ...
    channel_4, ...
    channel_5, ...
    channel_6 ] = textread(file_temp, ' {"sample": %d, "data": [%d, %d, %d, %d, %d, %d, %d, %d]},', (num_of_strings - 3));
data = [channel_1, channel_2, channel_3, channel_4, channel_5, channel_6];
end

