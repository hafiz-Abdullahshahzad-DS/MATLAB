clc,clear all,close all

% load the data file
load('data_sectionM.mat');
row_num = input('Enter Row Number (1 - 103):');


while row_num>103 | row_num<1
    disp('This Row Dont contain any data'); % Ensure the user enter correctly
    row_num = input('Enter Row Number (1 - 103):');
end


temp_data = SECTION_M(row_num,4:end); % Data started from the 4th column% Create a timeseries object for the given time
t_Data = datetime(1975,1,1):datetime(2016,12,31);

[y m d] = ymd(t_Data);

% get the month and year only for task 2 and 3
dt_data = [y' m' d' temp_data'];

my_data = unique([y' m'],'rows'); % collect all the month and years from the data

mm_data = []; %monthly mean data

max_month_data = [];    % monthly maximum data
min_month_data = [];    %monthly minimum data

for i = 1:length(my_data(:,1)) % update for the monthly data
    cm_data = dt_data(dt_data(:,1)==my_data(i,1) & dt_data(:,2)==my_data(i,2),:); % collect the data for a month
    
    mm_data(i) = mean(cm_data(:,4));
    max_month_data(i) = max(cm_data(:,4));
    min_month_data(i) = min(cm_data(:,4));
end
my_data(:,3)=1;
% plot the timeseries data
p_date = datetime(my_data);
figure 
% plot mean
subplot(311), plot(p_date,mm_data,'r'),title('January 1975 to December 2016'),ylabel({'Mean(T)','(degreeC)'}) ,xlabel('Months from the begining of data') 
% plot maximum
subplot(312), plot(p_date,max_month_data,'r'),ylabel({'Maximum(T)','(degreeC)'}) ,xlabel('Months from the begining of data') 
% plot minimum
subplot(313), plot(p_date,min_month_data,'r'),ylabel({'Minimum(T)','(degreeC)'}) ,xlabel('Months from the begining of data') 
% Find the coolest day
[M index] = min(temp_data);
cool_day = t_Data(index);
fprintf('The Coolest day of data is %s \n',string(cool_day))
% Find the hottest day
[M index] = max(temp_data);
hot_day = t_Data(index);
fprintf('The hottest day of data is %s \n',string(hot_day))

% data for mean T 
data_mean_T = [];
data_Extreme_T = [];
data_minimum_T = [];
mydata_val = [my_data mm_data' max_month_data' min_month_data'];


% Gather the mean data of all months
for i =1:12
    cm_data =mydata_val(mydata_val(:,2)==i,:);
    data_mean_T(i,:) = [min(cm_data(:,4)) mean(cm_data(:,4)) median(cm_data(:,4)) mode(cm_data(:,4)) max(cm_data(:,4)) std(cm_data(:,4))];
    data_Extreme_T(i,:) = [min(cm_data(:,5)) mean(cm_data(:,5)) median(cm_data(:,5)) mode(cm_data(:,5)) max(cm_data(:,5)) std(cm_data(:,5))];
    data_minimum_T(i,:) = [min(cm_data(:,6)) mean(cm_data(:,6)) median(cm_data(:,6)) mode(cm_data(:,6)) max(cm_data(:,6)) std(cm_data(:,6))];
end

% Draw the tables

Months = {'JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'};

MeanTemperatureTable = array2table(data_mean_T,'VariableNames',{'Min','Mean','Median','Mode','MAX','std'},'RowNames',{'JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'})

MaximumExtremeTemperatureTable = array2table(data_Extreme_T,'VariableNames',{'Min','Mean','Median','Mode','MAX','std'},'RowNames',{'JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'})

MinimumExtremeTemperatureTable = array2table(data_minimum_T,'VariableNames',{'Min','Mean','Median','Mode','MAX','std'},'RowNames',{'JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'})

%% Task 5
figure;

slope_mean_Temp = [];
% plot the mean data for months
for i =1:12
    cm_data =mydata_val(mydata_val(:,2)==i,:);

    % fit the line 
    [p x] = polyfit(cm_data(:,1),cm_data(:,4),1);
    
    slope_mean_Temp(i) = p(1);
    fit_y = polyval(p,cm_data(:,1));
    
    % plot the curves and trend lines
    subplot(3,4,i),plot(cm_data(:,1),cm_data(:,4),'r'),title(strcat('Month ',num2str(i))),ylabel('Mean of temperature');
    hold on, plot(cm_data(:,1),fit_y)
end
slope_max = [];
figure;
% plot the maximum data of months
for i =1:12
    cm_data =mydata_val(mydata_val(:,2)==i,:);   
    [p x] = polyfit(cm_data(:,1),cm_data(:,5),1);
    
    % fit the line
    slope_max(i) = p(1);
    fit_y = polyval(p,cm_data(:,1));
    
    % plot the curves in subplot
    subplot(3,4,i),plot(cm_data(:,1),cm_data(:,5),'r'),title(strcat('Month #',num2str(i))),ylabel('Maximum extreme of T');
    hold on, plot(cm_data(:,1),fit_y)
end
slope_min = [];
figure;
% plot the minimum of data
for i =1:12
    cm_data =mydata_val(mydata_val(:,2)==i,:);
    [p x] = polyfit(cm_data(:,1),cm_data(:,6),1);
    slope_min(i)=p(1);
    % Get the fitted line of it
    fit_y = polyval(p,cm_data(:,1));
    % plot the curves in subplot
    subplot(3,4,i),plot(cm_data(:,1),cm_data(:,6),'r'),title(strcat('Month #',num2str(i))),ylabel('Minimum extreme of T');
    hold on, plot(cm_data(:,1),fit_y)
end

slopes = [slope_mean_Temp' slope_min' slope_max'];
slope_table = array2table(slopes,'VariableNames',{'MeanTEMPERATURE','MaximumExtremeTemperature','MinimumExtremeTemperature'},'RowNames',{'JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'})

