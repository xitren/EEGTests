clc;
clear all;
%% основные пути
cur_fold = cd; 

%% загрузка признаков
% данные эксперимента 225, для обучения и для тестирования берутся разные
% наборы одних и тех же данных (кросс-валидация)

load('DividedClasses.mat')

% train_features - обучающая выборка (648 замеров 80-мерного вектора признаков)
% train_group - группирующая переменная обучающей выборки (1 - целевые стимулы, 0 - нецелевые)
% test_features - тестовая выборка
% test_group - группирующая переменная тестовой выборки 
% (используется для проверки работы обученного классификатора)

%y_ch1 = y_ch5;

train_group = classes(1:length(classes)/2);
test_group = classes((length(classes)/2 + 1):length(classes));
ch_part1 = y_ch1(1, 1:length(y_ch1)/2);
ch_part2 = y_ch1(1, (length(y_ch1)/2 + 1):(length(y_ch1)) );
train_features = ch_part1;
test_features = ch_part2;

%% классификация
% рабочий классификатор
[w, classes_work, y1, y2, test_y, center] = lda(train_features, train_group, test_features);

% сравнение результатов классификации и группирующей переменной тестовой выборки
cmp_work = classes_work == test_group;

% количество правильных ответов классификатора (рабочий и стандартный классификаторы)
p_work = size(find(cmp_work == 1), 2);

% точность классификатора
accuracy_work = p_work / size(cmp_work, 2) * 100;