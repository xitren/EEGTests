clc;
clear all;
%% �������� ����
cur_fold = cd; 

%% �������� ���������
% ������ ������������ 225, ��� �������� � ��� ������������ ������� ������
% ������ ����� � ��� �� ������ (�����-���������)

load('DividedClasses.mat')

% train_features - ��������� ������� (648 ������� 80-������� ������� ���������)
% train_group - ������������ ���������� ��������� ������� (1 - ������� �������, 0 - ���������)
% test_features - �������� �������
% test_group - ������������ ���������� �������� ������� 
% (������������ ��� �������� ������ ���������� ��������������)

%y_ch1 = y_ch5;

train_group = classes(1:length(classes)/2);
test_group = classes((length(classes)/2 + 1):length(classes));
ch_part1 = y_ch1(1, 1:length(y_ch1)/2);
ch_part2 = y_ch1(1, (length(y_ch1)/2 + 1):(length(y_ch1)) );
train_features = ch_part1;
test_features = ch_part2;

%% �������������
% ������� �������������
[w, classes_work, y1, y2, test_y, center] = lda(train_features, train_group, test_features);

% ��������� ����������� ������������� � ������������ ���������� �������� �������
cmp_work = classes_work == test_group;

% ���������� ���������� ������� �������������� (������� � ����������� ��������������)
p_work = size(find(cmp_work == 1), 2);

% �������� ��������������
accuracy_work = p_work / size(cmp_work, 2) * 100;