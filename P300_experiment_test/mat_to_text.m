clc;
clear all;

name = 'DividedClasses.mat';
load(name);

format_clss = '%d\n';
format_spec = '%f %f %f %f %f \n';

file_id = fopen('data_class.txt','w');
counter = 0;
for i=1:length(classes)
    if ( classes(i) ~= -1)
        string = classes(i);
        fprintf(file_id, format_clss, string);
        for j=1:length(y_ch1(:, 1))
            string = [y_ch1(j, i) y_ch2(j, i) y_ch3(j, i) y_ch4(j, i) y_ch5(j, i)];
            fprintf(file_id, format_spec, string);
        end
        counter = counter + 1;
    end
end
fclose(file_id);